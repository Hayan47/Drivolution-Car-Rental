import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'doors_event.dart';
part 'doors_state.dart';

class DoorsBloc extends Bloc<DoorsEvent, DoorsState> {
  DoorsBloc() : super(const DoorsState(4)) {
    on<DoorsEvent>((event, emit) {
      if (event is SelectDoorsNumberEvent) {
        emit(DoorsState(event.selectedNumber));
        print(event.selectedNumber);
      }
    });
  }
}
