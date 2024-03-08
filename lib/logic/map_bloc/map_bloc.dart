import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/services/image_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_to_byte/image_to_byte.dart';
part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  LatLng pickedLocation = const LatLng(0, 0);
  String cityName = '';
  Set<Marker> markers = {};
  Position? position;
  List<LatLng> polyLineCoordinate = [];

  MapBloc() : super(MapInitial()) {
    on<MapTapEvent>((event, emit) async {
      emit(MapLoading());
      List<Placemark> placemarks = await placemarkFromCoordinates(
          event.location.latitude, event.location.longitude);
      Placemark placemark = placemarks.first;
      pickedLocation = event.location;
      cityName = placemark.locality!;
      markers = {
        Marker(
          markerId: const MarkerId('picked_location'),
          position: event.location,
        ),
      };
      emit(
        CarLocationPicked(
          pickedLocation: pickedLocation,
          cityName: cityName,
          markers: markers,
        ),
      );
      print(state);
    });

    on<LoadCarLocation>((event, emit) async {
      emit(MapLoading());
      Uint8List customMarker = await imageToByte(event.carImage);
      Uint8List? smalling = ImageService().resizeImage(customMarker, 200, 100);

      pickedLocation = const LatLng(0, 0);
      cityName = '';
      markers = {
        Marker(
          icon: BitmapDescriptor.fromBytes(smalling!),
          markerId: const MarkerId('carloc'),
          infoWindow: const InfoWindow(title: 'Car Location'),
          position: LatLng(event.geoPoint.latitude, event.geoPoint.longitude),
        )
      };
      emit(
        CarLocationPicked(
          pickedLocation: pickedLocation,
          cityName: '',
          markers: markers,
        ),
      );
      print(state);
    });

    on<GetMyLocation>((event, emit) async {
      emit(MapLoading());
      // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print("getting ll");
      // if (!serviceEnabled) {
      //   // print("Permession Denied 1");
      //   // emit(state.copyWith(
      //   //     message: 'Error Getting Location Permession Denied'));
      // }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        // if (permission == LocationPermission.denied) {
        // print("Permession Denied 2");
        // emit(state.copyWith(
        //     message: 'Error Getting Location Permession Denied'));
        // }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(const MapError(message: 'Location Permession Denied'));
        print(state);
      }
      try {
        position = await Geolocator.getCurrentPosition(
            timeLimit: const Duration(seconds: 20));
        emit(
          UserLocationFetched(
            userPosition: position!,
            pickedLocation: pickedLocation,
            cityName: cityName,
            markers: markers,
          ),
        );
        print(state);
        // print(state.userPosition);
      } catch (e) {
        print(e);
        emit(MapError(message: e.toString()));
        print(state);
      }
      print(position);
    });
  }
  // //?get polypoints
  // void getPolyPoints(double latitude, double longitude) async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   // Position position = await getCurrentLocation();

  //   if (position != null) {
  //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       "",
  //       PointLatLng(position!.latitude, position!.longitude),
  //       PointLatLng(latitude, longitude),
  //     );
  //     if (result.points.isNotEmpty) {
  //       for (var point in result.points) {
  //         polyLineCoordinate.add(LatLng(point.latitude, point.longitude));
  //       }
  //     }
  //   }
  // }
}
