import 'package:bloc/bloc.dart';
import 'package:drivolution/data/services/reservations_services.dart';
import 'package:meta/meta.dart';
import '../../data/models/reservation_model.dart';
part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  List<Reservation> reservations = [];
  ReservationsCubit() : super(ReservationsInitial());

  //!get car reservations
  Future<List<Reservation>> getCarReservations(String carid) async {
    try {
      // print('Car Id: ' + carid);
      // emit(ReservationsLoading());
      await ReservationsServices().getCarReservations(carid).then((res) {
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
