part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class PickLocation extends LocationEvent {}

class LocationPicked extends LocationEvent {
  final LatLng location;
  final String city;

  const LocationPicked(this.location, this.city);
}

class LocationNotPicked extends LocationEvent {}
