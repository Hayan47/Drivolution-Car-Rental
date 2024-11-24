import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/map_bloc/map_bloc.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

class LocationPicker extends StatelessWidget {
  late GoogleMapController _googleMapController;
  LocationPicker({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.oceanBlue,
        title: const Text('Pick location'),
        actions: [
          BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              if (state is MapLoading) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.stormGrey,
                      strokeWidth: 2,
                    ),
                  ),
                );
              } else if (state is CarLocationPicked) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    child: Lottie.asset('assets/lottie/CheckAnimation.json',
                        repeat: false, width: 32),
                    onTap: () {
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
          backgroundColor: AppColors.oceanBlue,
          label: Text(
            'get your location',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.pureWhite,
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
            showToastMessage(
              context,
              state.message,
              const Icon(Icons.error, color: AppColors.alertRed, size: 18),
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
