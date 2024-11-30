import 'package:drivolution/data/services/logger_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final logger = LoggerService().getLogger('Location Bloc Logger');
  LocationBloc() : super(InitialLocationState()) {
    on<PickLocation>(
      (event, emit) {
        emit(PickingLocationState());
        logger.info(state);
      },
    );

    on<LocationPicked>(
      (event, emit) async {
        try {
          emit(LocationPickedState(location: event.location, city: event.city));
        } catch (e) {
          emit(LocationErrorState(message: 'An unexpected error occurred'));
          logger.severe(e);
        }
      },
    );

    on<LocationNotPicked>(
      (event, emit) {
        emit(const LocationErrorState(message: 'location not set'));
      },
    );

    on<ResetLocationEvent>(
      (event, emit) {
        emit(InitialLocationState());
      },
    );
  }
}
