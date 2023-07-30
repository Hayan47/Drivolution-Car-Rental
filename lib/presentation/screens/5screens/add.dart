// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/logic/cubit/cars_cubit.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../constants/my_colors.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/snackbar.dart';
import '../../widgets/textfield.dart';
import '../location_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  late String id;
  final _carNameController = TextEditingController();
  final _carModelController = TextEditingController();
  String dropdownValue1 = 'Sedan';
  List<String> carTypes = [
    'Sedan',
    'Pick Up',
    'SUV',
    'Sport',
    'Coupe',
    'Convertible',
    'HatchBack',
  ];
  String dropdownValue2 = 'gaz';
  List<String> carFuel = [
    'gaz',
    'disel',
    'electric',
  ];
  final _carColorController = TextEditingController();
  final _carEngineController = TextEditingController();
  final _carKilometrageController = TextEditingController();
  final _carInteriorColorController = TextEditingController();
  String dropdownValue3 = 'Automatic';
  List<String> carTransmission = [
    'Automatic',
    'Manual',
  ];
  String dropdownValue4 = 'AWD';
  List<String> carDrivetrain = [
    'AWD',
    '4WD',
    'front-wheel',
    'rear-wheel',
  ];
  int _currentValue1 = 4;
  int _currentValue2 = 4;
  List<String> features = [];
  final _carRentController = TextEditingController();
  final _carDescriptionController = TextEditingController();
  final _featureController = TextEditingController();
  Map<String, dynamic> loc = {
    'latitude': '',
    'longitude': '',
    'cityName': '',
  };
  List<Uint8List> carImages = [];
  List<String> carImagesLinks = [];
  Uint8List? carImage;
  String? imageUrl;
  int selectedlogo = -1;
  final List<String> carLogos = [
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Faudi.png?alt=media&token=f485f827-ed0c-4ca2-b391-813ce8fec775',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fbmw.png?alt=media&token=51a37597-d31b-4a2e-8d12-8ac4a773d2e2',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fmercedes.png?alt=media&token=fa05ebe0-5ea9-4995-8ada-6ae5a3b350b9',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Flamborghini.png?alt=media&token=99ed609d-17f0-42d0-8889-80a675e7ed40',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fchevrolet.png?alt=media&token=911ee48a-bd71-4678-b6d9-b0872ddd7aa1',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Frangerover.png?alt=media&token=bdf03fdb-e755-40f9-872f-3675e60dca2f',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fbyd.png?alt=media&token=409d93f4-e150-4bc6-a2af-814a70c7a94d',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fkia.png?alt=media&token=f970836f-b75a-427f-93ab-ba97813b4bba',
  ];

  //? remove img background
  Future<Uint8List> removeBackground(Uint8List imageFile) async {
    final response = await http.post(
      Uri.parse('https://api.remove.bg/v1.0/removebg'),
      headers: {
        'X-Api-Key': 'v9hizpcYyJfHxJFLyNKBHdrs',
      },
      body: {
        'image_file_b64': base64.encode(imageFile),
      },
    );

    if (response.statusCode == 200) {
      Uint8List imageBytes = response.bodyBytes;
      return imageBytes;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'image upload failed',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
      throw Exception('Failed to remove background: ${response.body}');
    }
  }

  //? resize img
  Uint8List compressImage(
      Uint8List imageBytes, int targetWidth, int targetHeight) {
    // Decode the image
    img.Image? image = img.decodeImage(imageBytes);
    // Resize the image
    img.Image resizedImage =
        img.copyResize(image!, width: targetWidth, height: targetHeight);
    // Compress the image and return it as a Uint8List
    return img.encodeJpg(resizedImage, quality: 50);
  }

  //? pick main image
  pickMainImage() async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        final imageData = await image.readAsBytes();
        final img = await removeBackground(imageData);
        // final compressedImage =
        //     compressImage(img, 815, 300);
        setState(() {
          carImage = img;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'Image not picked correctly',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
  }

  //? pick images
  pickImages() async {
    try {
      List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
      for (var pickedFile in pickedFiles) {
        final image = File(pickedFile.path);
        final imageData = await image.readAsBytes();
        setState(() {
          carImages.add(Uint8List.fromList(imageData));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'Images not picked correctly',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
  }

  //? pick location
  pickLocation() async {
    try {
      Map<String, dynamic> result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LocationPicker()),
      );
      setState(() {
        loc = result;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'picking location failed',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
  }

  //? add car
  addCar() async {
    print(MediaQuery.sizeOf(context).width);
    //! check car logo
    if (selectedlogo == -1) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'choose car logo',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car image
    if (imageUrl == null) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car image',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car name
    if (_carNameController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car name',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car model
    if (_carModelController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car model',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car rent price
    if (_carRentController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car rent price',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car images
    if (carImagesLinks.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car image album',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car location
    if (loc['latitude'] == 0 || loc['longitude'] == 0) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car location',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car images
    if (carImagesLinks.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car image album',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car color
    if (_carColorController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car color',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car interior color
    if (_carInteriorColorController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car interior color',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car engie
    if (_carEngineController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car engine size',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    //! check car kilometrage
    if (_carKilometrageController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'add car kilometrage',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
    for (int i = 0; i < carImages.length; i++) {
      final file = carImages[i];
      final imageName = '${_carNameController.text}$i.jpg';
      final ref = FirebaseStorage.instance
          .ref()
          .child('cars')
          .child(id)
          .child(_carNameController.text)
          .child(imageName);
      try {
        await ref.putData(file);
        final imageUrl = await ref.getDownloadURL();
        carImagesLinks.add(imageUrl);
        // print('Uploaded image $i: $imageUrl');
      } on FirebaseException {
        ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
          icon: const Icon(
            Icons.error,
            color: MyColors.myred,
            size: 20,
          ),
          title: 'Error',
          message: 'uploading images failed',
          margin: MediaQuery.sizeOf(context).width * 0.2,
        ));
      }
    }
    final file = carImage;
    final imageName = '${_carNameController.text}_main_image.jpg';
    final ref = FirebaseStorage.instance
        .ref()
        .child('cars')
        .child(id)
        .child(_carNameController.text)
        .child(imageName);
    try {
      await ref.putData(file!);
      imageUrl = await ref.getDownloadURL();
    } on FirebaseException {
      ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
        icon: const Icon(
          Icons.error,
          color: MyColors.myred,
          size: 20,
        ),
        title: 'Error',
        message: 'uploading images failed',
        margin: MediaQuery.sizeOf(context).width * 0.2,
      ));
    }
    context.read<CarsCubit>().addCar(
          Car(
            logo: carLogos[selectedlogo],
            img: imageUrl!,
            name: _carNameController.text,
            model: _carModelController.text,
            rent: int.parse(_carRentController.text),
            images: carImagesLinks,
            geoPoint: GeoPoint(loc['latitude'], loc['longitude']),
            locationName: loc['cityName'].toString(),
            type: dropdownValue1,
            seats: _currentValue2,
            doors: _currentValue1,
            fuel: dropdownValue2,
            features: features,
            color: _carColorController.text,
            interiorColor: _carInteriorColorController.text,
            engine: _carEngineController.text,
            drivetrain: dropdownValue4,
            kilometrage: int.parse(_carKilometrageController.text),
            transmission: dropdownValue3,
            ownerid: id,
            description: _carDescriptionController.text,
          ),
        );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      icon: const Icon(
        Icons.done,
        color: Colors.green,
        size: 20,
      ),
      title: 'Done',
      message: 'car added successfuly',
      margin: MediaQuery.sizeOf(context).width * 0.2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const ProfileScreen();
    }
    id = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: MyColors.myBlue2,
      body: SafeArea(
        child: Container(
          //?gradiant effect
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff1E1E24),
                Color(0xff243B55),
                Color(0xff1E1E24),
              ],
            ),
          ),

          //?child
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        //*blur effect

                        BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 50,
                            sigmaY: 50,
                          ),
                          child: Container(),
                        ),

                        //*child

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  'Add Car',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: MyColors.myred2,
                                        fontSize: 28,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(color: MyColors.myred2),
                              const SizedBox(height: 10),
                              //!car logo
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: carLogos.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedlogo = index;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.easeIn,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: selectedlogo == index
                                                ? MyColors.myBlue
                                                : Colors.transparent,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                blurRadius: 5,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: MyColors.mywhite,
                                                ),
                                              ),
                                              imageUrl: carLogos[index],
                                              fit: BoxFit.contain,
                                              width: 50,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(width: 10);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              //!pick main image
                              GestureDetector(
                                onTap: pickMainImage,
                                child: SizedBox(
                                  height: 200,
                                  child: carImage != null
                                      ? Card(
                                          color: Colors.transparent,
                                          child: Image.memory(
                                            carImage!,
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            border: Border.all(
                                              color: MyColors.myBlue,
                                              width: 2,
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.asset(
                                              'assets/img/cars/carholder.jpg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              //!car name
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Car Name',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                    MyTextField(
                                      hint: 'bmw 3series',
                                      inputType: TextInputType.name,
                                      actionType: TextInputAction.next,
                                      controller: _carNameController,
                                    ),
                                  ],
                                ),
                              ),
                              //!car model
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Car Model',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                    MyTextField(
                                      hint: '2023',
                                      inputType: TextInputType.number,
                                      actionType: TextInputAction.next,
                                      controller: _carModelController,
                                    ),
                                  ],
                                ),
                              ),
                              //!car color
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Color',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                    MyTextField(
                                      hint: 'grey',
                                      inputType: TextInputType.text,
                                      actionType: TextInputAction.next,
                                      controller: _carColorController,
                                    ),
                                  ],
                                ),
                              ),
                              //!car interior color
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Interior Color',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                    MyTextField(
                                      hint: 'Black',
                                      inputType: TextInputType.text,
                                      actionType: TextInputAction.next,
                                      controller: _carInteriorColorController,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              //!car engine
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Engine',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                    MyTextField(
                                      hint: 'v6 3500cc',
                                      inputType: TextInputType.text,
                                      actionType: TextInputAction.next,
                                      controller: _carEngineController,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              //!car kilometrage
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Kilometrage',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                    MyTextField(
                                      hint: '75',
                                      inputType: TextInputType.number,
                                      actionType: TextInputAction.next,
                                      controller: _carKilometrageController,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              //!car rent
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rent per day \$',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                    MyTextField(
                                      hint: '50',
                                      inputType: TextInputType.number,
                                      actionType: TextInputAction.next,
                                      controller: _carRentController,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              //!car type + fuel type
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyDropdown(
                                      icon: 'assets/icons/sedan.png',
                                      label: 'type',
                                      dropdownValue: dropdownValue1,
                                      items: carTypes
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownValue1 = value;
                                        });
                                      },
                                    ),
                                    MyDropdown(
                                      icon: 'assets/icons/gas.png',
                                      label: 'fuel',
                                      dropdownValue: dropdownValue2,
                                      items: carFuel
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownValue2 = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              //!car transmission + drivetrain
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyDropdown(
                                      icon: 'assets/icons/gear.png',
                                      label: 'transmission',
                                      dropdownValue: dropdownValue3,
                                      items: carTransmission
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownValue3 = value;
                                        });
                                      },
                                    ),
                                    MyDropdown(
                                      icon: 'assets/icons/wheel.png',
                                      label: 'drivetrain',
                                      dropdownValue: dropdownValue4,
                                      items: carDrivetrain
                                          .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e,
                                              )))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownValue4 = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              //!car doors
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Doors',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                    NumberPicker(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myBlue,
                                            fontSize: 16,
                                          ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border:
                                            Border.all(color: MyColors.myBlue2),
                                        // color: Colors.white,
                                      ),
                                      selectedTextStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.mywhite,
                                            fontSize: 20,
                                          ),
                                      axis: Axis.horizontal,
                                      itemWidth: 30,
                                      haptics: false,
                                      value: _currentValue1,
                                      minValue: 2,
                                      maxValue: 50,
                                      onChanged: (value) => setState(
                                          () => _currentValue1 = value),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              //!car seats
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Seats',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                    NumberPicker(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myBlue,
                                            fontSize: 16,
                                          ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        border:
                                            Border.all(color: MyColors.myBlue2),
                                        // color: Colors.white,
                                      ),
                                      selectedTextStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.mywhite,
                                            fontSize: 20,
                                          ),
                                      axis: Axis.horizontal,
                                      itemWidth: 30,
                                      haptics: false,
                                      value: _currentValue2,
                                      minValue: 2,
                                      maxValue: 50,
                                      onChanged: (value) => setState(
                                          () => _currentValue2 = value),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  color: MyColors.myred3,
                                ),
                              ),
                              const SizedBox(height: 10),

                              //!fetures
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Features',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: features.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == features.length) {
                                      FocusNode focusNode = FocusNode();
                                      //? add input field
                                      return Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 44,
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.4),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: TextField(
                                                focusNode: focusNode,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: MyColors.mywhite,
                                                      fontSize: 16,
                                                    ),
                                                textAlign: TextAlign.center,
                                                controller: _featureController,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  hintText: 'Android Auto',
                                                  hintStyle: GoogleFonts.karla(
                                                    color: MyColors.mywhite
                                                        .withOpacity(0.5),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.send,
                                              color: MyColors.myBlue,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                features.add(
                                                    _featureController.text);
                                              });
                                              _featureController.clear();
                                              focusNode.requestFocus();
                                            },
                                          ),
                                        ],
                                      );
                                    } else {
                                      //? show feature name
                                      return ListTile(
                                        dense: true,
                                        title: Text(
                                          features[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: MyColors.mywhite,
                                                fontSize: 14,
                                              ),
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: MyColors.myBlue,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              features.removeAt(index);
                                            });
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              //!car description
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  color:
                                      const Color(0xff1E1E24).withOpacity(0.4),
                                  child: TextField(
                                    textInputAction: TextInputAction.done,
                                    controller: _carDescriptionController,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    autofocus: false,
                                    style: GoogleFonts.karla(
                                      color: MyColors.mywhite,
                                      fontSize: 16,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Add description",
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 14,
                                          ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.myBlue,
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: MyColors.myred3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              //!car location
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'car location',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.myred2,
                                            fontSize: 18,
                                          ),
                                    ),
                                    GestureDetector(
                                      onTap: pickLocation,
                                      child: const Icon(
                                        Icons.location_on_outlined,
                                        color: MyColors.myBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              (loc['latitude'] == '')
                                  ? Container()
                                  : Column(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: MyColors.myred2,
                                                  fontSize: 14,
                                                ),
                                            children: [
                                              const TextSpan(
                                                text: 'latitude: ',
                                              ),
                                              TextSpan(
                                                text:
                                                    loc['latitude'].toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: MyColors.mywhite,
                                                      fontSize: 14,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        RichText(
                                          text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: MyColors.myred2,
                                                  fontSize: 14,
                                                ),
                                            children: [
                                              const TextSpan(
                                                text: 'longitude: ',
                                              ),
                                              TextSpan(
                                                text:
                                                    loc['longitude'].toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: MyColors.mywhite,
                                                      fontSize: 14,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        RichText(
                                          text: TextSpan(
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: MyColors.myred2,
                                                  fontSize: 18,
                                                ),
                                            children: [
                                              const TextSpan(
                                                text: 'city: ',
                                              ),
                                              TextSpan(
                                                text:
                                                    loc['cityName'].toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: MyColors.mywhite,
                                                      fontSize: 18,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                              const SizedBox(height: 15),
                              //!pick images
                              Text(
                                'pick an album',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                    ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: GestureDetector(
                                  onTap: pickImages,
                                  child: SizedBox(
                                    height: 200,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: MyColors.myred,
                                        ),
                                      ),
                                      child: GridView.count(
                                        crossAxisCount: 3,
                                        children: (carImages.isEmpty)
                                            ? List.generate(
                                                9,
                                                (index) => Card(
                                                  child: Image.asset(
                                                      'assets/img/cars/carholder2.jpg'),
                                                ),
                                              )
                                            : List.generate(
                                                carImages.length,
                                                (index) {
                                                  return Card(
                                                    child: Image.memory(
                                                      carImages[index],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              //!submit
                              Padding(
                                padding: const EdgeInsets.only(bottom: 80),
                                child: TextButton(
                                  onPressed: addCar,
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        MyColors.myred),
                                    fixedSize: MaterialStateProperty.all(
                                      const Size(100, 20),
                                    ),
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
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
