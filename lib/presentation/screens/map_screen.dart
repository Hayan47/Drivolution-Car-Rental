import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/map_bloc/map_bloc.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/models/car_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapScreen extends StatelessWidget {
  final Car car;
  MapScreen({required this.car, super.key});

  late GoogleMapController _googleMapController;

  List<LatLng> polyLineCoordinate = [];

  late Set<Marker> markers = {};

  final Set<Polyline> _polylines = <Polyline>{};

  // @override
  // void dispose() {
  //   _googleMapController.dispose();
  //   super.dispose();
  // }

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

  //?get polypoints
  void _getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    Position position = await _getCurrentLocation();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        dotenv.env['GOOGLE_MAP'],
        PointLatLng(position.latitude, position.longitude),
        PointLatLng(
            widget.car.geoPoint.latitude, widget.car.geoPoint.longitude));

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polyLineCoordinate.add(LatLng(point.latitude, point.longitude));
      }
    }
  }

  _addMarker() async {
    Uint8List customMarker = await imageToByte(
      widget.car.img,
    );
    Uint8List? smalling = resizeImage(customMarker, 200, 100);

    setState(() {
      markers.add(Marker(
        icon: BitmapDescriptor.fromBytes(smalling!),
        markerId: const MarkerId('carloc'),
        infoWindow: const InfoWindow(title: 'Car Location'),
        position:
            LatLng(widget.car.geoPoint.latitude, widget.car.geoPoint.longitude),
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
    context
        .read<MapBloc>()
        .add(LoadCarLocation(geoPoint: car.geoPoint, carImage: car.img));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myBlue,
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
                      color: MyColors.mywhite,
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

          // _getPolyPoints();
          // setState(() {
          //add marker
          // markers.add(Marker(
          //   markerId: const MarkerId('yourloc'),
          //   infoWindow: const InfoWindow(title: 'Your Location'),
          //   position: LatLng(position.latitude, position.longitude),
          // ));
          //add polyline
          // _polylines.add(Polyline(
          //   polylineId: const PolylineId('route'),
          //   color: Colors.red,
          //   width: 10,
          //   points: polyLineCoordinate,
          // ));
          // });
        },
      ),
    );
  }
}
