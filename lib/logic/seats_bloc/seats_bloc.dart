import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seats_event.dart';
part 'seats_state.dart';

class SeatsBloc extends Bloc<SeatsEvent, SeatsState> {
  SeatsBloc() : super(const SeatsState(4)) {
    on<SeatsEvent>((event, emit) {
      if (event is SelectSeatsNumberEvent) {
        emit(SeatsState(event.selectedNumber));
      }
    });
  }
}
