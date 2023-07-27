import 'package:bloc/bloc.dart';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/services/user_services.dart';
import 'package:drivolution/services/reservations_services.dart';
import 'package:meta/meta.dart';

import '../../data/models/usr_model.dart';

part 'usr_state.dart';

class UsrCubit extends Cubit<UsrState> {
  UsrCubit() : super(UsrInitial());

  //!get user ingo
  Future<Usr?> getUserInfo(String userID) async {
    try {
      final userInfo = await UserServices().getUserInfo(userID);
      List<Reservation> res =
          await ReservationsServices().getUserReservations(userID);
      emit(UsrLoaded(userInfo!, res));
      return userInfo;
    } catch (e) {
      emit(UsrError('Failed to load user information'));
      return null;
    }
  }
}
