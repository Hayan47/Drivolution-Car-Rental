import 'package:bloc/bloc.dart';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/logic/cubit/reservations_cubit.dart';
import 'package:drivolution/services/auth.dart';
import 'package:drivolution/services/reservations_services.dart';
import 'package:meta/meta.dart';

import '../../data/models/usr_model.dart';

part 'usr_state.dart';

class UsrCubit extends Cubit<UsrState> {
  UsrCubit() : super(UsrInitial());

  //!get user ingo
  Future<void> getUserInfo(String userID) async {
    try {
      final userInfo = await Auth().getUserInfo(userID);
      List<Reservation> res =
          await ReservationsServices().getUserReservations(userID);
      emit(UsrLoaded(userInfo!, res));
    } catch (e) {
      emit(UsrError('Failed to load user information'));
    }
  }

//   //!get user reservations
//   Future<void> getUserReservations(String userID) async {
//     try {
//       ReservationsServices().getUserReservations(userID).then((res) {
//         emit(UsrLoaded(res));
//       });
//     } catch (error) {
//       emit(ReservationError(error.toString()));
//       print("EEEEEEEEEEEEEEEEERRRRRRRRRRRORRRRR");
//     }
//   }
}
