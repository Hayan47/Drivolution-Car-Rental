import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(InitialLocationState()) {
    on<PickLocation>((event, emit) {
      emit(PickingLocationState());
      print(state);
    });

    on<LocationPicked>((event, emit) async {
      try {
        emit(LocationPickedState(location: event.location, city: event.city));
        print(state);
      } catch (error) {
        emit(LocationErrorState(message: error.toString()));
        print(state);
      }
    });

    on<LocationNotPicked>((event, emit) {
      emit(const LocationErrorState(message: 'location not set'));
      print(state);
    });
  }
}
