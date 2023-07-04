import 'package:dio/dio.dart';

class CarsWebServices {
  late Dio dio;

  CarsWebServices() {
    BaseOptions options = BaseOptions(
      responseType: ResponseType.json,
      baseUrl: 'https://a0bfd6fd-ddd9-4b90-a189-1db502001050.mock.pstmn.io/',
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCars() async {
    try {
      Response response = await dio.get('cars');
      //print('RESPONSEEEEEEEEEEEEE' + response.data.toString());
      return response.data;
    } catch (e) {
      //print('ERORRRRRRRRRRRRRRRRRwebservices' + e.toString());
      return [];
    }
  }
}
