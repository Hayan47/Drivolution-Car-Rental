import 'dart:async';
import 'package:drivolution/data/repositories/authentication_repository.dart';
import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final logger = LoggerService().getLogger('Auth Cubit Logger');
  final AuthRepository authRepository;
  AuthCubit({
    required this.authRepository,
  }) : super(NotAuthenticated());

  void checkAuth() async {
    try {
      final accessToken = await authRepository.getAccessToken();
      if (accessToken == null) {
        logger.info('access token is null');
        emit(NotAuthenticated());
      } else {
        logger.info('access token found');
        emit(Authenticated(userid: JwtDecoder.decode(accessToken)['user_id']));
      }
      logger.info(state);
    } catch (e) {
      emit(NotAuthenticated());
      logger.info(state);
      logger.severe(e);
    }
  }
}
