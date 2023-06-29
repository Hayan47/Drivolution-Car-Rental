import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_to_byte/image_to_byte.dart';
import 'package:image/image.dart' as IMG;
import '../../data/models/car_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapScreen extends StatefulWidget {
  final Car car;
  const MapScreen({required this.car, super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _googleMapController;

  List<LatLng> polyLineCoordinate = [];

  late Set<Marker> markers = {};

  Set<Polyline> _polylines = Set<Polyline>();

  // @override
  // void dispose() {
  //   _googleMapController.dispose();
  //   super.dispose();
  // }

  //get my location
  Future<Position> _getCurrentLocation() async {
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

  //get polypoints
  void _getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    Position position = await _getCurrentLocation();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        dotenv.env['GOOGLE_MAP'],
        PointLatLng(position.latitude, position.longitude),
        PointLatLng(
            widget.car.geoPoint!.latitude, widget.car.geoPoint!.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polyLineCoordinate.add(LatLng(point.latitude, point.longitude)));
    }
  }

  _addMarker() async {
    Uint8List customMarker = await imageToByte(
      widget.car.img!,
    );
    Uint8List? smalling = resizeImage(customMarker, 200, 100);

    setState(() {
      markers.add(Marker(
        icon: BitmapDescriptor.fromBytes(smalling!),
        markerId: const MarkerId('carloc'),
        infoWindow: const InfoWindow(title: 'Car Location'),
        position: LatLng(
            widget.car.geoPoint!.latitude, widget.car.geoPoint!.longitude),
      ));
    });
  }

  Uint8List? resizeImage(Uint8List data, width, height) {
    Uint8List? resizedData = data;
    IMG.Image? img = IMG.decodeImage(data);
    IMG.Image resized = IMG.copyResize(img!, width: width, height: height);
    resizedData = Uint8List.fromList(IMG.encodePng(resized));
    return resizedData;
  }

  @override
  void initState() {
    _addMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
                widget.car.geoPoint!.latitude, widget.car.geoPoint!.longitude),
            zoom: 14,
          ),
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          onMapCreated: (controller) => _googleMapController = controller,
          markers: markers,
          polylines: _polylines),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          label: const Text('get your location'),
          onPressed: () async {
            Position position = await _getCurrentLocation();

            _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14,
                ),
              ),
            );

            _getPolyPoints();
            setState(() {
              //add marker
              markers.add(Marker(
                markerId: const MarkerId('yourloc'),
                infoWindow: const InfoWindow(title: 'Your Location'),
                position: LatLng(position.latitude, position.longitude),
              ));
              //add polyline
              _polylines.add(Polyline(
                polylineId: PolylineId('route'),
                color: Colors.red,
                width: 10,
                points: polyLineCoordinate,
              ));
            });
          },
        ),
      ),
    );
  }
}
