import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  StreamSubscription? _subscription;
  InternetBloc() : super(InternetInitial()) {
    on<InternetEvent>((event, emit) {
      if (event is ConnectedEvent) {
        emit(const ConnectedState(message: 'Connected'));
      } else if (event is NotConnectedEvent) {
        emit(const NotConnectedState(message: 'Not Connected'));
      }
    });
  }
}
