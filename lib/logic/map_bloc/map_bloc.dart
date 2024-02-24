import 'package:bloc/bloc.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
      : super(const MapState(
            pickedLocation: LatLng(0, 0), cityName: '', markers: {})) {
    on<MapTapEvent>((event, emit) async {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          event.location.latitude, event.location.longitude);
      Placemark placemark = placemarks.first;
      emit(
        MapState(
          pickedLocation: event.location,
          cityName: placemark.locality!,
          markers: {
            Marker(
              markerId: const MarkerId('picked_location'),
              position: event.location,
            ),
          },
        ),
      );
    });
  }

  //?get my location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      //return Future.error('Location Services are Desabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permession Denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Permession Permenantly Denied');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
