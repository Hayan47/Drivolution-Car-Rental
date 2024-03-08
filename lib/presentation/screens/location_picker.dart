import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/map_bloc/map_bloc.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPicker extends StatelessWidget {
  late GoogleMapController _googleMapController;
  LocationPicker({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myBlue,
        title: const Text('Pick location'),
        actions: [
          BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              if (state is MapLoading) {
                return const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: MyColors.mywhite,
                      strokeWidth: 3,
                    ),
                  ),
                );
              } else if (state is CarLocationPicked) {
                return IconButton(
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
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          backgroundColor: MyColors.myBlue,
          label: Text(
            'get your location',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: MyColors.mywhite,
                ),
          ),
          onPressed: () async {
            context.read<MapBloc>().add(GetMyLocation());
          },
        ),
      ),
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapError) {
            ScaffoldMessenger.of(context).showSnackBar(
              MySnackBar(
                icon: const Icon(Icons.error, color: MyColors.myred2, size: 18),
                message: state.message,
                margin: 5,
              ),
            );
          } else if (state is UserLocationFetched) {
            _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(state.userPosition.latitude,
                      state.userPosition.longitude),
                  zoom: 14,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return PopScope(
            onPopInvoked: (didPop) {
              if (state is! CarLocationPicked) {
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
            child: GoogleMap(
              onMapCreated: (controller) => _googleMapController = controller,
              onTap: (location) =>
                  context.read<MapBloc>().add(MapTapEvent(location: location)),
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.7749, -122.4194), // San Francisco
                zoom: 14,
              ),
              markers: state is CarLocationPicked
                  ? state.markers
                  : state is UserLocationFetched
                      ? state.markers
                      : {},
            ),
          );
        },
      ),
    );
  }
}
