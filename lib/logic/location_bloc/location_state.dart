part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class InitialLocationState extends LocationState {}

class PickingLocationState extends LocationState {}

class LocationPickedState extends LocationState {
  final LatLng location;
  final String city;

  const LocationPickedState({required this.location, required this.city});

  @override
  List<Object> get props => [location, city];
}

class LocationErrorState extends LocationState {
  final String message;

  const LocationErrorState({required this.message});
}
