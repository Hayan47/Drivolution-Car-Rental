import 'package:dio/dio.dart';
import 'package:drivolution/data/exceptions/api_exception.dart';
import 'package:drivolution/data/exceptions/network_exception.dart';
import 'package:drivolution/data/exceptions/not_found_exception.dart';
import 'package:drivolution/data/exceptions/storage_exception.dart';
import 'package:drivolution/data/exceptions/unauthorized_exception.dart';
import 'package:drivolution/data/exceptions/validation_exception.dart';
import 'package:drivolution/data/services/authentication_service.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:synchronized/synchronized.dart';

class ApiService {
  final logger = LoggerService().getLogger('Api Service Logger');
  final Dio dio;
  final AuthService authService;
  bool _isRefreshing = false;
  final _refreshLock = Lock(); // Add a lock for concurrent refresh attempts

  ApiService({
    AuthService? authService,
  })  : dio = Dio(),
        authService = authService ?? AuthService() {
    dio.options.baseUrl = 'http://127.0.0.1:8000/api/';
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: _handleRequest,
      onResponse: _handleResponse,
      onError: _handleError,
    ));
  }

  Future<void> _handleRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    logger.fine("Requested endpoint: ${options.path}");
    try {
      final token = await authService.getAccessToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    } catch (e) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: StorageException(message: 'Error getting access token'),
        ),
      );
    }
  }

  void _handleResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return handler.next(response);
    }
    handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        error: ApiException(
          message: 'Unexpected response status',
          statusCode: response.statusCode,
          errors: response.data,
        ),
      ),
    );
  }

  Future<void> _handleError(
    DioException e,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      if (_isNetworkError(e)) {
        return _handleNetworkError(e, handler);
      }

      final statusCode = e.response?.statusCode;
      if (statusCode == null) {
        return _handleUnexpectedError(e, handler);
      }

      if (statusCode == 401) {
        if (e.requestOptions.path.contains('token/refresh/')) {
          await authService.clearTokens();
          return handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              error: UnauthorizedException(),
            ),
          );
        }

        return await _refreshLock.synchronized(() async {
          if (!_isRefreshing) {
            logger.warning("Refreshing Token");
            _isRefreshing = true;
            try {
              if (await _handleUnauthorized()) {
                _isRefreshing = false;
                final retryResponse = await _retryRequest(e.requestOptions);
                return handler.resolve(retryResponse);
              }
            } finally {
              _isRefreshing = false;
            }
          }
          return handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              error: UnauthorizedException(),
            ),
          );
        });
      }

      return _handleHttpError(e, handler, statusCode);
    } catch (error) {
      handler.reject(DioException(
        requestOptions: e.requestOptions,
        error: error,
      ));
    }
  }

  bool _isNetworkError(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError;
  }

  void _handleNetworkError(DioException e, ErrorInterceptorHandler handler) {
    final message = e.type == DioExceptionType.connectionError
        ? 'Network connection failed'
        : 'Connection timeout';
    handler.reject(
      DioException(
        requestOptions: e.requestOptions,
        error: NetworkException(message: message),
      ),
    );
  }

  void _handleHttpError(
    DioException e,
    ErrorInterceptorHandler handler,
    int statusCode,
  ) {
    final error = switch (statusCode) {
      400 => ValidationException.fromJson(e.response?.data ?? {}),
      403 => ApiException(
          message: 'Forbidden',
          statusCode: statusCode,
          errors: e.response?.data,
        ),
      404 => NotFoundException(),
      422 => ApiException(
          message: 'Validation failed',
          statusCode: statusCode,
          errors: e.response?.data,
        ),
      500 || 503 => ApiException(
          message: 'Server error',
          statusCode: statusCode,
          errors: e.response?.data,
        ),
      _ => ApiException(
          message: 'Unknown error occurred',
          statusCode: statusCode,
          errors: e.response?.data,
        ),
    };
    handler.reject(DioException(
      requestOptions: e.requestOptions,
      error: error,
    ));
  }

  void _handleUnexpectedError(DioException e, ErrorInterceptorHandler handler) {
    handler.reject(DioException(
      requestOptions: e.requestOptions,
      error: ApiException(
        message: e.message ?? 'Unknown error occurred',
        errors: e.response?.data,
      ),
    ));
  }

  Future<bool> _handleUnauthorized() async {
    try {
      final refreshToken = await authService.getRefreshToken();
      logger.warning("Refresh Token read from storage");
      if (refreshToken == null) return false;

      final response = await dio.post(
        'token/refresh/',
        data: {'refresh': refreshToken},
      );
      logger.warning("Refresh response: $response");
      await authService.saveTokens(
        response.data['access'],
        response.data['refresh'],
      );
      return true;
    } catch (e) {
      logger.severe(e);
      await authService.clearTokens();
      return false;
    }
  }

  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    return await dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );
  }
}
