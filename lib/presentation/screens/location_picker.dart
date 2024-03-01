import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/map_bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPicker extends StatelessWidget {
  late GoogleMapController _mapController;
  LocationPicker({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return PopScope(
          onPopInvoked: (didPop) {
            if (state.pickedLocation == const LatLng(0, 0)) {
              context.read<LocationBloc>().add(LocationNotPicked());
            } else {
              context.read<LocationBloc>().add(
                    LocationPicked(
                      LatLng(state.pickedLocation.latitude,
                          state.pickedLocation.longitude),
                      state.cityName,
                    ),
                  );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.myBlue,
              title: const Text('Pick a location'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: () {
                    context.read<LocationBloc>().add(
                          LocationPicked(
                            LatLng(state.pickedLocation.latitude,
                                state.pickedLocation.longitude),
                            state.cityName,
                          ),
                        );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            body: GoogleMap(
              onMapCreated: (controller) => _mapController = controller,
              onTap: (location) {
                context.read<MapBloc>().add(MapTapEvent(location: location));
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194), // San Francisco
                zoom: 14,
              ),
              markers: <Marker>{
                Marker(
                  markerId: const MarkerId('picked_location'),
                  position: state.pickedLocation,
                ),
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                backgroundColor: MyColors.myBlue,
                label: const Text('get your location'),
                onPressed: () async {
                  Position position = await BlocProvider.of<MapBloc>(context)
                      .getCurrentLocation();
                  _mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(position.latitude, position.longitude),
                        zoom: 14,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
