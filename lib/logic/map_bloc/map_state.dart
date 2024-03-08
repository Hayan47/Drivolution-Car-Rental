part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitial extends MapState {}

final class MapLoading extends MapState {}

final class CarLocationPicked extends MapState {
  final LatLng pickedLocation;
  final String cityName;
  final Set<Marker> markers;

  const CarLocationPicked({
    required this.pickedLocation,
    required this.cityName,
    required this.markers,
  });

  @override
  List<Object> get props => [pickedLocation, cityName, markers];
}

final class UserLocationFetched extends MapState {
  final LatLng pickedLocation;
  final String cityName;
  final Set<Marker> markers;
  final Position userPosition;

  const UserLocationFetched({
    required this.userPosition,
    required this.pickedLocation,
    required this.cityName,
    required this.markers,
  });

  @override
  List<Object> get props => [pickedLocation, cityName, markers, userPosition];
}

final class MapError extends MapState {
  final String message;

  const MapError({required this.message});

  @override
  List<Object> get props => [message];
}
