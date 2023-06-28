import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../constants/my_colors.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/textfield.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myred3,
        title: const Text('Add Car Screen'),
        centerTitle: true,
      ),
      body: Container(
        //gradiant effect

        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                MyColors.myred.withOpacity(1),
                // MyColors.myred2.withOpacity(1),
                MyColors.myBlue.withOpacity(1),
                MyColors.myBlue2.withOpacity(1),
              ]),
        ),
        //child
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      //blur effect

                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 50,
                          sigmaY: 50,
                        ),
                        child: Container(),
                      ),

                      //child

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Add Car',
                                style: GoogleFonts.karla(
                                  color: MyColors.myBlue2,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                            //car name
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Car Name',
                                    style: TextStyle(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
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
                            //car model
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Car Model',
                                    style: TextStyle(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  MyTextField(
                                    hint: '2023',
                                    inputType: TextInputType.name,
                                    actionType: TextInputAction.next,
                                    controller: _carModelController,
                                  ),
                                ],
                              ),
                            ),
                            //car color
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Color',
                                    style: TextStyle(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
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
                            //car interior color
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Interior Color',
                                    style: TextStyle(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
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
                            //car engine
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Engine',
                                    style: TextStyle(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
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
                            //car kilometrage
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Kilometrage',
                                    style: TextStyle(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  MyTextField(
                                    hint: '75',
                                    inputType: TextInputType.text,
                                    actionType: TextInputAction.next,
                                    controller: _carKilometrageController,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            //car type + fuel type
                            MyDropdown(
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
                            const SizedBox(height: 10),
                            MyDropdown(
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
                            const SizedBox(height: 10),

                            //car transmission + drivetrain
                            MyDropdown(
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
                            const SizedBox(height: 10),
                            MyDropdown(
                              label: 'drivetrain',
                              dropdownValue: dropdownValue4,
                              items: carDrivetrain
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropdownValue4 = value;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            //car doors
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Doors',
                                    style: TextStyle(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  NumberPicker(
                                    textStyle: GoogleFonts.karla(
                                      color: MyColors.myBlue2,
                                      fontSize: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border:
                                          Border.all(color: MyColors.myBlue2),
                                      // color: Colors.white,
                                    ),
                                    selectedTextStyle: GoogleFonts.karla(
                                      color: MyColors.mywhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    axis: Axis.horizontal,
                                    itemWidth: 30,
                                    haptics: true,
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
                            //seats
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Seats',
                                    style: TextStyle(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  NumberPicker(
                                    textStyle: GoogleFonts.karla(
                                      color: MyColors.myBlue2,
                                      fontSize: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border:
                                          Border.all(color: MyColors.myBlue2),
                                      // color: Colors.white,
                                    ),
                                    selectedTextStyle: GoogleFonts.karla(
                                      color: MyColors.mywhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    axis: Axis.horizontal,
                                    itemWidth: 30,
                                    haptics: true,
                                    value: _currentValue2,
                                    minValue: 2,
                                    maxValue: 50,
                                    onChanged: (value) =>
                                        setState(() => _currentValue2 = value),
                                  ),
                                ],
                              ),
                            ),
                            //fetures
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Features',
                                    style: TextStyle(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: features.length + 1,
                                itemBuilder: (context, index) {
                                  final _carFeaturesColorController =
                                      TextEditingController();
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            color: MyColors.myred2,
                                          ),
                                          width: 150,
                                          height: 40,
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              hintText: 'Android Auto',
                                              border: InputBorder.none,
                                            ),
                                            controller:
                                                _carFeaturesColorController,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add,
                                          color: MyColors.mywhite,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            features.add(
                                                _carFeaturesColorController
                                                    .text);
                                          });
                                        },
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
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
    );
  }
}
