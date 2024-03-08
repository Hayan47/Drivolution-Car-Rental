part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapTapEvent extends MapEvent {
  final LatLng location;

  const MapTapEvent({required this.location});
}

class LoadCarLocation extends MapEvent {
  final GeoPoint geoPoint;
  final String carImage;

  const LoadCarLocation({required this.geoPoint, required this.carImage});
}

class GetMyLocation extends MapEvent {}
