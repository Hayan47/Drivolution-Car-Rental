// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:typed_data';
import 'package:drivolution/data/services/image_service.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/screens/add_car_screen1.dart';
import 'package:drivolution/presentation/screens/add_car_screen2.dart';
import 'package:drivolution/presentation/screens/add_car_screen3.dart';
import 'package:drivolution/presentation/screens/location_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../constants/my_colors.dart';
import '../widgets/snackbar.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  late String id;
  List<Uint8List> carImages = [];
  List<String> carImagesLinks = [];
  Uint8List? carImage;
  String? imageUrl;

  final _pageController = PageController();
  int _currentPage = 0;
  int percent = 0;
  bool loading = false;
  int imageNum = 1;
  final ImageService _imageService = ImageService();
  Map loc = {};
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
      // _errorHandling.showError('picking location failed', context);
    }
  }

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
    // //*add car
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
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      icon: const Icon(
        Icons.done,
        color: Colors.green,
        size: 20,
      ),
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
                    AddCar1(),
                    AddCar2(),
                    AddCar3(),
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
                        // Center(
                        //   child: TextButton(
                        //       onPressed: () async {
                        //         setState(() {
                        //           loading = true;
                        //         });
                        //         //*upload main image
                        //         // await uploadImage(
                        //         //     carImage!,
                        //         //     '${_carNameController.text}_main_image.jpg',
                        //         //     0);
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
                            TextButton(
                              onPressed: addCar,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(MyColors.myred),
                                fixedSize: MaterialStateProperty.all(
                                  Size(100, 20),
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
                          ],
                        )
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
                    child: Image.asset(
                      'assets/icons/arrow_left.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
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
                          child: Image.asset(
                            'assets/icons/arrow_right.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
