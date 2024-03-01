import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/app_router.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/album_bloc/album_bloc.dart';
import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/logic/doors_bloc/doors_bloc.dart';
import 'package:drivolution/logic/features_bloc/features_bloc.dart';
import 'package:drivolution/logic/forms_bloc/forms_bloc.dart';
import 'package:drivolution/logic/image_bloc/image_bloc.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/logic/seats_bloc/seats_bloc.dart';
import 'package:drivolution/logic/upload_bloc/upload_bloc.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCar4 extends StatelessWidget {
  const AddCar4({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'pick an album',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: MyColors.mywhite),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onLongPress: () => context.read<AlbumBloc>().add(RemoveAlbumEvent()),
          onTap: () => context.read<AlbumBloc>().add(AddAlbumEvent()),
          child: BlocConsumer<AlbumBloc, AlbumState>(
            listener: (context, state) {
              if (state is AlbumError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  MySnackBar(
                    icon: const Icon(Icons.error,
                        color: MyColors.myred2, size: 18),
                    message: state.errorMessage,
                    margin: 5,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AlbumChanged) {
                return GridView.count(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  crossAxisCount: 3,
                  children: List.generate(
                    state.images.length,
                    (index) => Card(
                      child: Image.memory(state.images[index]),
                    ),
                  ),
                );
              } else if (state is AlbumLoading) {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: MyColors.myred,
                    ),
                  ),
                );
              } else {
                return GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  crossAxisCount: 3,
                  children: List.generate(
                    9,
                    (index) => Card(
                      child: Image.asset('assets/img/cars/carholder2.jpg'),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 15),
        //!submit
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<UploadBloc, UploadState>(
              listener: (context, state) {
                if (state is UploadFailedState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackBar(
                      icon: const Icon(Icons.error,
                          color: MyColors.myred2, size: 18),
                      message: state.message,
                      margin: 5,
                    ),
                  );
                } else if (state is UploadSuccessState) {
                  final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);
                  final location = (BlocProvider.of<LocationBloc>(context).state
                          as LocationPickedState)
                      .location;
                  final latitude = location.latitude;
                  final longitude = location.longitude;
                  String id = FirebaseAuth.instance.currentUser!.uid;
                  final Car car = Car(
                    logo: BlocProvider.of<LogoBloc>(context).getSelectedLogo(),
                    img: state.imageUrls[0],
                    name: formBloc.carName.value,
                    model: formBloc.carModel.value,
                    rent: int.parse(formBloc.carRent.value),
                    images: state.imageUrls.sublist(1),
                    geoPoint: GeoPoint(latitude, longitude),
                    locationName: (BlocProvider.of<LocationBloc>(context).state
                            as LocationPickedState)
                        .city,
                    type: formBloc.typesDropdown.value!,
                    seats: BlocProvider.of<SeatsBloc>(context)
                        .state
                        .selectedNumber,
                    doors: BlocProvider.of<DoorsBloc>(context)
                        .state
                        .selectedNumber,
                    fuel: formBloc.fuelDropdown.value!,
                    features: (BlocProvider.of<FeaturesBloc>(context).state
                            as UpdatedFeaturesState)
                        .features,
                    color: formBloc.carColor.value,
                    interiorColor: formBloc.carInteriorColor.value,
                    engine: formBloc.carEngine.value,
                    drivetrain: formBloc.drivetrainDropdown.value!,
                    kilometrage: int.parse(formBloc.carKiloMetrage.value),
                    transmission: formBloc.transmissionDropdown.value!,
                    ownerid: id,
                    description: formBloc.carDescription.value,
                  );
                  context.read<CarsBloc>().add(AddCarEvent(car: car));
                }
              },
              builder: (context, state) {
                if (state is UploadingState) {
                  return Row(
                    children: [
                      Text(
                        "uploadnig images",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: MyColors.myred2,
                              fontSize: 16,
                            ),
                      ),
                      const SizedBox(width: 10),
                      const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          color: MyColors.myred2,
                          strokeWidth: 2,
                        ),
                      ),
                    ],
                  );
                } else {
                  return BlocConsumer<CarsBloc, CarsState>(
                    listener: (context, state) {
                      if (state is CarAdded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          MySnackBar(
                            icon: const Icon(Icons.done,
                                color: Colors.green, size: 18),
                            message: state.message,
                            margin: 80,
                          ),
                        );
                        AppRouter().disposeAddCarBlocs();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'mainscreen',
                          (Route<dynamic> route) => false,
                        );
                      } else if (state is CarsError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          MySnackBar(
                            icon: const Icon(Icons.error,
                                color: MyColors.myred2, size: 18),
                            message: state.message,
                            margin: 5,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is CarsLoading) {
                        return Row(
                          children: [
                            Text(
                              "uploadnig car info",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: MyColors.myred2,
                                    fontSize: 16,
                                  ),
                            ),
                            const SizedBox(width: 10),
                            const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                color: MyColors.myred2,
                                strokeWidth: 2,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return TextButton(
                          onPressed: () {
                            final formBloc =
                                BlocProvider.of<AllFieldsFormBloc>(context);
                            String id = FirebaseAuth.instance.currentUser!.uid;
                            List<Uint8List> images =
                                (BlocProvider.of<AlbumBloc>(context).state
                                        as AlbumChanged)
                                    .images;
                            images.insert(
                                0,
                                (BlocProvider.of<ImageBloc>(context).state
                                        as ImageChanged)
                                    .image);
                            //? UPLOAD
                            context.read<UploadBloc>().add(
                                  UploadImagesEvent(
                                    images: images,
                                    path:
                                        'cars/$id/${formBloc.carName.value}/${formBloc.carName.value}',
                                  ),
                                );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(MyColors.myred),
                          ),
                          child: Text(
                            'Submit',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: MyColors.mywhite,
                                  fontSize: 18,
                                ),
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
