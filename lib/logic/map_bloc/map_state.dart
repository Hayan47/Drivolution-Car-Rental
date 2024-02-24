part of 'map_bloc.dart';

class MapState extends Equatable {
  final LatLng pickedLocation;
  final String cityName;
  final Set<Marker> markers;
  const MapState({
    required this.pickedLocation,
    required this.cityName,
    required this.markers,
  });

  @override
  List<Object> get props => [pickedLocation, cityName, markers];

  MapState copyWith({
    LatLng? pickedLocation,
    String? cityName,
    Set<Marker>? markers,
  }) {
    return MapState(
        pickedLocation: pickedLocation ?? this.pickedLocation,
        cityName: cityName ?? this.cityName,
        markers: markers ?? this.markers);
  }
}
