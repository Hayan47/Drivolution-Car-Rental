import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/doors_bloc/doors_bloc.dart';
import 'package:drivolution/logic/features_bloc/features_bloc.dart';
import 'package:drivolution/logic/forms_bloc/forms_bloc.dart';
import 'package:drivolution/logic/seats_bloc/seats_bloc.dart';
import 'package:drivolution/presentation/widgets/dropdown.dart';
import 'package:drivolution/presentation/widgets/numberpicker.dart';
import 'package:drivolution/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

class AddCar2 extends StatelessWidget {
  String dropdownValue3 = 'Automatic';
  List<String> features = [];
  final _featureController = TextEditingController();

  List<String> carTransmission = [
    'Automatic',
    'Manual',
  ];
  AddCar2({super.key});

  @override
  Widget build(BuildContext context) {
    final formbloc = BlocProvider.of<AllFieldsFormBloc>(context);
    return ListView(
      children: [
        Text(
          'Add Car Info',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: MyColors.mywhite,
              ),
        ),
        const SizedBox(height: 10),
        //!car name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Car Name',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myBlue,
                      fontSize: 18,
                    ),
              ),
              MyTextField2(
                hint: 'bmw 3series',
                inputType: TextInputType.name,
                actionType: TextInputAction.next,
                bloc: formbloc.carName,
              ),
            ],
          ),
        ),
        //!car model
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Car Model',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myBlue,
                      fontSize: 18,
                    ),
              ),
              MyTextField2(
                hint: '2023',
                inputType: TextInputType.number,
                actionType: TextInputAction.next,
                bloc: formbloc.carModel,
              ),
            ],
          ),
        ),
        //!car color
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Color',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myBlue,
                      fontSize: 18,
                    ),
              ),
              MyTextField2(
                hint: 'grey',
                inputType: TextInputType.text,
                actionType: TextInputAction.next,
                bloc: formbloc.carColor,
              ),
            ],
          ),
        ),
        //!car interior color
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Interior Color',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myBlue,
                      fontSize: 18,
                    ),
              ),
              MyTextField2(
                hint: 'Black',
                inputType: TextInputType.text,
                actionType: TextInputAction.next,
                bloc: formbloc.carInteriorColor,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        //!car engine
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Engine',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myBlue,
                      fontSize: 18,
                    ),
              ),
              MyTextField2(
                hint: 'v6 3500cc',
                inputType: TextInputType.text,
                actionType: TextInputAction.next,
                bloc: formbloc.carEngine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        //!car kilometrage
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kilometrage',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myBlue,
                      fontSize: 18,
                    ),
              ),
              MyTextField2(
                hint: '75',
                inputType: TextInputType.number,
                actionType: TextInputAction.next,
                bloc: formbloc.carKiloMetrage,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        //!car rent
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rent per day \$',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myBlue,
                      fontSize: 18,
                    ),
              ),
              MyTextField2(
                hint: '50',
                inputType: TextInputType.number,
                actionType: TextInputAction.next,
                bloc: formbloc.carRent,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        //!car type + fuel type
        Row(
          children: [
            MyDropdown2(
              label: 'type',
              icon: 'assets/icons/sedan.png',
              bloc: formbloc.typesDropdown,
            ),
            MyDropdown2(
              label: 'fuel',
              icon: 'assets/icons/gas.png',
              bloc: formbloc.fuelDropdown,
            ),
          ],
        ),
        const SizedBox(height: 20),
        //!car transmission + drivetrain
        Row(
          children: [
            MyDropdown2(
              label: 'transmission',
              icon: 'assets/icons/gear.png',
              bloc: formbloc.transmissionDropdown,
            ),
            MyDropdown2(
              label: 'drivetrain',
              icon: 'assets/icons/wheel.png',
              bloc: formbloc.drivetrainDropdown,
            ),
          ],
        ),
        const SizedBox(height: 10),
        //! Doors
        Column(
          children: [
            Text(
              'Doors',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.myBlue,
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<DoorsBloc, DoorsState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyNumberPicker(
                      value: state.selectedNumber,
                      onChanged: (value) {
                        context
                            .read<DoorsBloc>()
                            .add(SelectDoorsNumberEvent(value));
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        //! Seats
        Column(
          children: [
            Text(
              'Seats',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.myBlue,
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<SeatsBloc, SeatsState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyNumberPicker(
                      value: state.selectedNumber,
                      onChanged: (value) {
                        context
                            .read<SeatsBloc>()
                            .add(SelectSeatsNumberEvent(value));
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),

        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 15),
        //   child: Divider(
        //     color: MyColors.myred3,
        //   ),
        // ),
        const SizedBox(height: 10),

        //!fetures
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Features',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myBlue,
                      fontSize: 18,
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
          child: BlocBuilder<FeaturesBloc, FeaturesState>(
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  color: MyColors.myred2,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.features.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      title: Text(
                        state.features[index],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                          context
                              .read<FeaturesBloc>()
                              .add(DeleteFeature(index));
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.mywhite,
                          fontSize: 16,
                        ),
                    textAlign: TextAlign.center,
                    controller: _featureController,
                    cursorColor: MyColors.mywhite,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'Android Auto',
                      hintStyle:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: MyColors.mywhite.withOpacity(0.5),
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
                  if (_featureController.text.isEmpty) return;
                  context
                      .read<FeaturesBloc>()
                      .add(AddFeature(_featureController.text));
                  _featureController.clear();
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
        //!car description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            color: const Color(0xff1E1E24).withOpacity(0.4),
            child: TextFieldBlocBuilder(
              // controller: _carDescriptionController,
              textFieldBloc: formbloc.carFeatures,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              autofocus: false,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                hintText: "Add description",
                hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
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
    );
  }
}
