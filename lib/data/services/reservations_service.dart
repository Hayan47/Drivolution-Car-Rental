import 'package:drivolution/data/services/api_service.dart';

class ReservationService extends ApiService {
  Future<Map<String, dynamic>> makeReservation(
      Map<String, dynamic> reservationData) async {
    final response = await dio.post('reservations/', data: reservationData);
    return response.data;
  }

  Future<List<dynamic>> getCarReservations(int carid) async {
    final response =
        await dio.get('reservations/', queryParameters: {'car_id': carid});
    logger.warning(response.data);
    return response.data;
  }

  Future<List<dynamic>> getUserReservations(int userid) async {
    final response =
        await dio.get('reservations/', queryParameters: {'renter_id': userid});
    return response.data;
  }
}
