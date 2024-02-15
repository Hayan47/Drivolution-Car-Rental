import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dropdown_event.dart';
part 'dropdown_state.dart';

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(const DropdownState({})) {
    on<DropdownEvent>((event, emit) {
      if (event is UpdateDropdownValueEvent) {
        emit(DropdownState({
          ...state.dropdownValues,
          event.dropdownId: event.newValue,
        }));
      }
    });
  }
}
