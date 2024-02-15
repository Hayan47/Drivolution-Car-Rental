// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivolution/data/services/error_handling.dart';
import 'package:drivolution/data/services/image_service.dart';
import 'package:drivolution/logic/cubit/cars_cubit.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/dropdown_bloc/dropdown_bloc.dart';
import 'package:drivolution/logic/forms_bloc/forms_bloc.dart';
import 'package:drivolution/logic/image_bloc/image_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../constants/my_colors.dart';
import '../widgets/dropdown.dart';
import '../widgets/snackbar.dart';
import '../widgets/textfield.dart';
import 'location_picker.dart';

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
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fastonmartin.png?alt=media&token=5eb094ef-14d9-44e3-9598-f506e04b2913',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fbently.png?alt=media&token=1ee13dfd-c3f0-4614-9529-61024f3e3467',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fcadilac.png?alt=media&token=1321a3d8-db40-4a5a-9259-34f1fa5b2766',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fferrari.png?alt=media&token=30a69a7a-3ce4-40c0-93cf-ea81a35edfcb',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Ffiat.png?alt=media&token=8cad43ae-f4b6-4cdb-bedc-3a3b147ce7f7',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fhonda.png?alt=media&token=b4c909e0-fd9b-49fe-8ea2-28d9c53f7887',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fhyundai.png?alt=media&token=7db4f484-6d9d-4399-be57-b3cdd19592d2',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fjaguar.png?alt=media&token=b0c49937-5bf0-4d42-9431-4ed21e5895ab',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Flexus.png?alt=media&token=4a8a901c-b09f-4249-9590-fdd48de5d1a5',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fmazda.png?alt=media&token=a2687a07-64ad-450b-b85c-703fb0a42ca3',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fmitsubishi.png?alt=media&token=8f0d18a8-7f47-472a-9dee-a9fe57c296fd',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fnissan.png?alt=media&token=7b7be975-a06d-4bff-b742-78332dda5eeb',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fopel.png?alt=media&token=0d0cf1b1-ab10-41d0-b581-b13f6cf3062a',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fpeugeot.png?alt=media&token=8ffca1ed-1e25-4225-b1fd-1ce3bdd41697',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fporsche.png?alt=media&token=bdbefdd9-0cbe-4d15-8850-4f0161549b4b',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Frenault.png?alt=media&token=9607467e-5c42-48e4-8bc1-5cb6b3490a7d',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fskooda.png?alt=media&token=6af3e067-35e0-465a-944d-749d7ec02120',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Fsubaru.png?alt=media&token=89d4ef0c-b064-47e9-a18e-c8959ac919e9',
    'https://firebasestorage.googleapis.com/v0/b/drivolution.appspot.com/o/myfiles%2Flogos%2Ftoyota.png?alt=media&token=c89705c1-de38-4058-a192-e6366c9e0854',
  ];
  final _pageController = PageController();
  int _currentPage = 0;
  int percent = 0;
  bool loading = false;
  int imageNum = 1;
  final ImageService _imageService = ImageService();
  final ErrorHandling _errorHandling = ErrorHandling();

  //?pick location
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
      _errorHandling.showError('picking location failed', context);
    }
  }

  //? add car
  addCar() async {
    //*check images
    if (carImages.isEmpty) {
      _errorHandling.showError('add car images', context);
      return;
    }
    //*upload main image
    await _imageService.uploadImage(
      file: carImage,
      folderName: _carNameController.text,
      imageName: '${_carNameController.text}_main_image.jpg',
      id: id,
      i: 1,
      context: context,
    );
    //*upload images
    for (int i = 0; i < carImages.length; i++) {
      await _imageService.uploadImage(
        file: carImages[i],
        folderName: _carNameController.text,
        imageName: '${_carNameController.text}$i.jpg',
        id: id,
        i: i + 2,
        context: context,
      );
    }
    //*add car
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
      color: Colors.green,
      icon: const Icon(
        Icons.done,
        color: Colors.green,
        size: 20,
      ),
      title: 'Done',
      message: 'car added successfuly',
      margin: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const ProfileScreen();
    }
    id = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      body: Container(
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
        child: Column(
          children: [
            AppBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    //!first page
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Select Car Logo',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                  ),
                        ),
                        BlocBuilder<LogoBloc, LogoState>(
                          builder: (context, state) {
                            return Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  childAspectRatio: 1,
                                ),
                                itemCount: carLogos.length,
                                itemBuilder: (context, index) {
                                  final isSelected =
                                      state.selectedIndex == index;
                                  selectedlogo = state.selectedIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      context
                                          .read<LogoBloc>()
                                          .add(SelectLogoEvent(index));
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeOut,
                                      decoration: BoxDecoration(
                                        borderRadius: isSelected
                                            ? BorderRadius.circular(14)
                                            : null,
                                        border: isSelected
                                            ? Border.all(
                                                color: MyColors.myBlue,
                                                width: 2,
                                              )
                                            : null,
                                        boxShadow: isSelected
                                            ? [
                                                const BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 2),
                                                ),
                                              ]
                                            : null,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: CachedNetworkImage(
                                          imageUrl: carLogos[index],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        //!select main image
                        Text(
                          'Select Car Image',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                  ),
                        ),
                        const SizedBox(height: 25),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.read<ImageBloc>().add(AddImageEvent());
                            },
                            child: BlocConsumer<ImageBloc, ImageState>(
                              listener: (context, state) {
                                if (state is ImageError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    MySnackBar(
                                      color: MyColors.myred,
                                      icon: const Icon(Icons.error,
                                          color: Colors.white, size: 18),
                                      title: 'Error',
                                      message: state.errorMessage,
                                      margin: 5,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is ImageChanged) {
                                  return Center(
                                    child: SizedBox(
                                      child: Card(
                                        color: Colors.transparent,
                                        child: Image.memory(
                                          state.image,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (state is ImageLoading) {
                                  return const SizedBox(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: MyColors.myred,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: MyColors.myBlue,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/img/cars/carholder.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    //!second page
                    ListView(
                      children: [
                        Text(
                          'Add Car Info',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                  ),
                        ),
                        const SizedBox(height: 10),

                        //!car name
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // FormBlocListener<AllFieldsFormBloc, String,
                              //     String>(
                              //   onSubmitting: (context, state) {
                              //     // LoadingDialog.show(context);
                              //   },
                              //   onSuccess: (context, state) {
                              //     // LoadingDialog.hide(context);

                              //     // Navigator.of(context).pushReplacement(
                              //     //     MaterialPageRoute(
                              //     //         builder: (_) =>
                              //     //             const SuccessScreen()
                              //     //             )

                              //     //             );
                              //   },
                              //   onFailure: (context, state) {
                              //     // LoadingDialog.hide(context);

                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //         SnackBar(
                              //             content:
                              //                 Text(state.failureResponse!)));
                              //   },
                              //   child: DropdownFieldBlocBuilder<String>(
                              //     selectFieldBloc: context
                              //         .read<AllFieldsFormBloc>()
                              //         .typesDropdown,
                              //     decoration: const InputDecoration(
                              //       labelText: 'DropdownFieldBlocBuilder222',
                              //       prefixIcon: Icon(Icons.sentiment_satisfied),
                              //     ),
                              //     itemBuilder: (context, value) => FieldItem(
                              //       child: Text(value),
                              //     ),
                              //   ),
                              // ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  border: Border.all(color: MyColors.myBlue2),
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
                                onChanged: (value) =>
                                    setState(() => _currentValue1 = value),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        //!car seats
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  border: Border.all(color: MyColors.myBlue2),
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
                                onChanged: (value) =>
                                    setState(() => _currentValue2 = value),
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
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.symmetric(horizontal: 35),
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
                                          color: Colors.grey.withOpacity(0.4),
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
                                            focusedBorder: InputBorder.none,
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
                                        if (_featureController.text.isEmpty)
                                          return;
                                        setState(() {
                                          features.add(_featureController.text);
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
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            color: const Color(0xff1E1E24).withOpacity(0.4),
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
                      ],
                    ),
                    //!third page
                    Column(
                      children: [
                        //!car location
                        Image.asset('assets/lottie/car_location.png'),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'add your car location',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: MyColors.myBlue,
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            const SizedBox(width: 15),
                            GestureDetector(
                              onTap: pickLocation,
                              child: const Icon(
                                Icons.location_on_outlined,
                                color: MyColors.myBlue,
                              ),
                            ),
                          ],
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
                                          text: loc['latitude'].toString(),
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
                                          text: loc['longitude'].toString(),
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
                                          text: loc['cityName'].toString(),
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
                      ],
                    ),
                    //!forth page
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //!pick images
                        Text(
                          'pick an album',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                  ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onLongPress: () =>
                              carImages = _imageService.removeImages(),
                          onTap: () async => carImages =
                              (await _imageService.pickImages(context))!,
                          child: Container(
                            height: MediaQuery.sizeOf(context).height / 2,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.myred,
                              ),
                            ),
                            child: GridView.count(
                              padding: const EdgeInsets.all(8),
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
                        Center(
                          child: LinearPercentIndicator(
                            backgroundColor: MyColors.mywhite,
                            lineHeight: 7,
                            percent: percent / 100,
                            progressColor: MyColors.myred,
                            curve: Curves.bounceIn,
                            center: Text(
                              '$percent %',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'uploading image  $imageNum',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
                            ),
                            const SizedBox(width: 5),
                            const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                color: MyColors.mywhite,
                                strokeWidth: 2,
                              ),
                            ),
                          ],
                        ),
                        // :
                        Center(
                          child: TextButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                //*upload main image
                                // await uploadImage(
                                //     carImage!,
                                //     '${_carNameController.text}_main_image.jpg',
                                //     0);
                                //*upload images
                                for (int i = 0; i < carImages.length; i++) {
                                  await _imageService.uploadImage(
                                    file: carImages[i],
                                    folderName: _carNameController.text,
                                    imageName:
                                        '${_carNameController.text}$i.jpg',
                                    id: id,
                                    i: i + 2,
                                    context: context,
                                  );
                                }
                                // setState(() {
                                //   loading = false;
                                // });
                              },
                              child: Text('TEST')),
                        ),

                        //////////////////////////////////////////////////////////
                        //!submit
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     TextButton(
                        //       onPressed: addCar,
                        //       style: ButtonStyle(
                        //         backgroundColor:
                        //             MaterialStateProperty.all(MyColors.myred),
                        //         fixedSize: MaterialStateProperty.all(
                        //           Size(100, 20),
                        //         ),
                        //       ),
                        //       child: Text(
                        //         'Submit',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyMedium!
                        //             .copyWith(
                        //               color: MyColors.mywhite,
                        //               fontSize: 18,
                        //             ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        if (_currentPage > 0) {
                          _currentPage--;
                        }
                        _pageController.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Text('previuos')),
                  _currentPage == 3
                      ? Container()
                      : TextButton(
                          onPressed: () {
                            // //?first page check
                            // if (_currentPage == 0) {
                            //   if (selectedlogo == -1) {
                            //     showError('add car logo');
                            //     return;
                            //   }
                            //   if (carImage == null) {
                            //     showError('add car image');
                            //     return;
                            //   }
                            // }
                            // //?second page check
                            // if (_currentPage == 1) {
                            //   if (_carNameController.text.isEmpty) {
                            //     showError('add car name');
                            //     return;
                            //   }
                            //   if (_carModelController.text.isEmpty) {
                            //     showError('add car model');
                            //     return;
                            //   }
                            //   if (_carColorController.text.isEmpty) {
                            //     showError('add car color');
                            //     return;
                            //   }
                            //   if (_carInteriorColorController.text.isEmpty) {
                            //     showError('add car interior color');
                            //     return;
                            //   }
                            //   if (_carEngineController.text.isEmpty) {
                            //     showError('add car engine');
                            //     return;
                            //   }
                            //   if (_carKilometrageController.text.isEmpty) {
                            //     showError('add car kilometrage');
                            //     return;
                            //   }
                            //   if (_carRentController.text.isEmpty) {
                            //     showError('add car rent');
                            //     return;
                            //   }
                            // }
                            // //?third page check
                            // if (_currentPage == 2) {
                            //   if (loc['latitude'] == '' ||
                            //       loc['longitude'] == '') {
                            //     showError('add car location');
                            //     return;
                            //   }
                            // }

                            if (_currentPage < 3) {
                              _currentPage++;
                            }
                            _pageController.animateToPage(
                              _currentPage,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Text('next')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
