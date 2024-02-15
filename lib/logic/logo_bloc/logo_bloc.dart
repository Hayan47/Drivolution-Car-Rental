import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'logo_event.dart';
part 'logo_state.dart';

class LogoBloc extends Bloc<LogoEvent, LogoState> {
  LogoBloc() : super(const LogoState(-1)) {
    on<LogoEvent>((event, emit) {
      if (event is SelectLogoEvent) {
        emit(LogoState(event.selectedIndex));
      }
    });
  }
}
