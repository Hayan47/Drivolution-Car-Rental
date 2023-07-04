import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

// todo: get my location
class _LocationPickerState extends State<LocationPicker> {
  late GoogleMapController _mapController;
  LatLng _pickedLocation = LatLng(23, 22);
  late String _cityName;
  late Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onMapTap(LatLng location) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    Placemark placemark = placemarks.first;

    setState(() {
      _pickedLocation = location;
      print('\n');
      print(location);
      print('\n');
      _cityName = placemark.locality!;
    });
  }

  void _onDone() {
    try {
      Navigator.of(context).pop({
        'latitude': _pickedLocation.latitude,
        'longitude': _pickedLocation.longitude,
        'cityName': _cityName,
      });
    } catch (e) {
      print(e);
    }
  }

  //?get my location
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: _onDone,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onTap: _onMapTap,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.7749, -122.4194), // San Francisco
          zoom: 14,
        ),
        markers: <Marker>{
          Marker(
            markerId: const MarkerId('picked_location'),
            position: _pickedLocation,
          ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          label: const Text('get your location'),
          onPressed: () async {
            Position position = await _getCurrentLocation();

            _mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14,
                ),
              ),
            );

            setState(() {
              //add marker
              markers.add(Marker(
                markerId: const MarkerId('yourloc'),
                infoWindow: const InfoWindow(title: 'Your Location'),
                position: LatLng(position.latitude, position.longitude),
              ));
            });
          },
        ),
      ),
    );
  }
}
