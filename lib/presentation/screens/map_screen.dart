// ignore_for_file: must_be_immutable

import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/map_bloc/map_bloc.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/models/car_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapScreen extends StatelessWidget {
  late GoogleMapController _googleMapController;
  final Car car;
  MapScreen({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<MapBloc>()
        .add(LoadCarLocation(geoPoint: car.geoPoint, carImage: car.img));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.oceanBlue,
        title: const Text('Car Location'),
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
                      color: AppColors.pureWhite,
                      strokeWidth: 3,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          )
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
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(car.geoPoint.latitude, car.geoPoint.longitude),
              zoom: 14,
            ),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: state is CarLocationPicked
                ? state.markers
                : state is UserLocationFetched
                    ? state.markers
                    : {},
            // polylines: _polylines,
          );
        },
      ),
    );
  }
}
