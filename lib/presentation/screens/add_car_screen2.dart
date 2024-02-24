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
        Row(
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
        const SizedBox(height: 10),
        //!car model
        Row(
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
        //!car color
        const SizedBox(height: 10),
        Row(
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
        const SizedBox(height: 10),
        //!car interior color
        Row(
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
        const SizedBox(height: 10),
        //!car engine
        Row(
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
        const SizedBox(height: 10),
        //!car kilometrage
        Row(
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
        const SizedBox(height: 10),
        //!car rent
        Row(
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
        const SizedBox(height: 20),
        //!fetures
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: BlocBuilder<FeaturesBloc, FeaturesState>(
            builder: (context, state) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.features.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColors.myGrey,
                    child: ListTile(
                      dense: true,
                      title: Text(
                        state.features[index],
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.mywhite,
                              fontSize: 15,
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
                    ),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
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
                                color: MyColors.mywhite.withOpacity(0.7),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Discription',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.myBlue,
                    fontSize: 18,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: MyColors.myGrey.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: MyColors.mywhite,
              width: 0.4,
            ),
          ),
          child: TextFieldBlocBuilder(
            textColor: MaterialStateProperty.all(MyColors.mywhite),
            textStyle: Theme.of(context).textTheme.bodySmall,
            maxLines: 4,
            textAlign: TextAlign.center,
            cursorColor: MyColors.mywhite,
            cursorRadius: const Radius.circular(50),
            cursorWidth: 1,
            textFieldBloc: formbloc.carFeatures,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.multiline,
            autofocus: false,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
