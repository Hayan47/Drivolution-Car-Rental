import 'package:bloc/bloc.dart';
import 'package:drivolution/services/reservations_services.dart';
import 'package:meta/meta.dart';
import '../../data/models/reservation_model.dart';
part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  List<Reservation> reservations = [];
  ReservationsCubit() : super(ReservationsInitial());

  //!get car reservations
  List<Reservation> getCarReservations(String carid) {
    try {
      // print('Car Id: ' + carid);
      // emit(ReservationsLoading());
      ReservationsServices().getCarReservations(carid).then((res) {
        emit(ReservationsLoaded(res));
        reservations = res;
      });
      return reservations;
    } catch (error) {
      emit(ReservationsError(error.toString()));
      print("EEEEEEEEEEEEEEEEERRRRRRRRRRRORRRRR");
      return [];
    }
  }

  //!add reservation
  Future<void> addReservation(Reservation res) async {
    await ReservationsServices().makeReservation(res);
  }
}
