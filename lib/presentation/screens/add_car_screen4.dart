import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:image_picker/image_picker.dart';

class AddCar4 extends StatelessWidget {
  //? add car
  addCar() async {
    // //*check images
    // if (carImages.isEmpty) {
    //   _errorHandling.showError('add car images', context);
    //   return;
    // }
    // //*upload main image
    // await _imageService.uploadImage(
    //   file: carImage,
    //   folderName: _carNameController.text,
    //   imageName: '${_carNameController.text}_main_image.jpg',
    //   id: id,
    //   i: 1,
    //   context: context,
    // );
    // //*upload images
    // for (int i = 0; i < carImages.length; i++) {
    //   await _imageService.uploadImage(
    //     file: carImages[i],
    //     folderName: _carNameController.text,
    //     imageName: '${_carNameController.text}$i.jpg',
    //     id: id,
    //     i: i + 2,
    //     context: context,
    //   );
    // }
    //*add car
    // context.read<CarsCubit>().addCar(
    //       Car(
    //         logo: carLogos[selectedlogo],
    //         img: imageUrl!,
    //         name: _carNameController.text,
    //         model: _carModelController.text,
    //         rent: int.parse(_carRentController.text),
    //         images: carImagesLinks,
    //         geoPoint: GeoPoint(loc['latitude'], loc['longitude']),
    //         locationName: loc['cityName'].toString(),
    //         type: dropdownValue1,
    //         seats: _currentValue2,
    //         doors: _currentValue1,
    //         fuel: dropdownValue2,
    //         features: features,
    //         color: _carColorController.text,
    //         interiorColor: _carInteriorColorController.text,
    //         engine: _carEngineController.text,
    //         drivetrain: dropdownValue4,
    //         kilometrage: int.parse(_carKilometrageController.text),
    //         transmission: dropdownValue3,
    //         ownerid: id,
    //         description: _carDescriptionController.text,
    //       ),
    //     );
    // Navigator.pop(context);
    // ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
    //   icon: const Icon(
    //     Icons.done,
    //     color: Colors.green,
    //     size: 20,
    //   ),
    //   message: 'car added successfuly',
    //   margin: 0,
    // ));
  }
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
        ///////////////////////////////////!///////////////////////
        // loadin?
        // Center(
        //   child: CircularPercentIndicator(
        //     radius: 40,
        //     lineWidth: 7,
        //     backgroundColor: MyColors.myBlue2,
        //     percent: percent / 100,
        //     progressColor: MyColors.myred,
        //     curve: Curves.bounceIn,
        //     center: Text(
        //       '$percent %',
        //       style: const TextStyle(
        //           color: Colors.white, fontSize: 10),
        //     ),
        //   ),
        // ),
        // Center(
        //   child: LinearPercentIndicator(
        //     backgroundColor: MyColors.mywhite,
        //     lineHeight: 7,
        //     percent: percent / 100,
        //     progressColor: MyColors.myred,
        //     curve: Curves.bounceIn,
        //     center: Text(
        //       '$percent %',
        //       style: const TextStyle(color: Colors.white, fontSize: 10),
        //     ),
        //   ),
        // ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       'uploading image ', // $imageNum',
        //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //             color: MyColors.mywhite,
        //             fontSize: 16,
        //           ),
        //     ),
        //     const SizedBox(width: 5),
        //     const SizedBox(
        //       width: 12,
        //       height: 12,
        //       child: CircularProgressIndicator(
        //         color: MyColors.mywhite,
        //         strokeWidth: 2,
        //       ),
        //     ),
        //   ],
        // ),
        // :
        // Center(
        //   child: TextButton(
        //       onPressed: () async {
        //         setState(() {
        //           loading = true;
        //         });
        //         //*upload main image
        // await uploadImage(
        //     carImage!,
        //     '${_carNameController.text}_main_image.jpg',
        //     0);
        //         //*upload images
        //         for (int i = 0; i < carImages.length; i++) {
        //           await _imageService.uploadImage(
        //             file: carImages[i],
        //             folderName: _carNameController.text,
        //             imageName:
        //                 '${_carNameController.text}$i.jpg',
        //             id: id,
        //             i: i + 2,
        //             context: context,
        //           );
        //         }
        //         // setState(() {
        //         //   loading = false;
        //         // });
        //       },
        //       child: Text('TEST')),
        // ),

        //////////////////////////////////////////////////////////
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackBar(
                      icon:
                          const Icon(Icons.done, color: Colors.green, size: 18),
                      message: state.message,
                      margin: 5,
                    ),
                  );
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
                  print(car);
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
                            margin: 5,
                          ),
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
                            context.read<UploadBloc>().add(UploadImagesEvent(
                                images, formBloc.carName.value, id));
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
