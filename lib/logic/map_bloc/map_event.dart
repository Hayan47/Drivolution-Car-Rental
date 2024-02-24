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
