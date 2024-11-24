import 'package:drivolution/constants/car_dropdown_constants.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/presentation/widgets/dropdown.dart';
import 'package:drivolution/presentation/widgets/number_picker.dart';
import 'package:drivolution/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';

class AddCar2 extends StatelessWidget {
  final _featureController = TextEditingController();
  AddCar2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarFormBloc, CarFormState>(
      builder: (context, state) {
        return ListView(
          children: [
            Text(
              'Add Car Info',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.pureWhite,
              ),
            ),
            const SizedBox(height: 10),
            //!car name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Car Name',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
                MyTextField(
                  initialValue: state.name,
                  hint: 'bmw 3series',
                  inputType: TextInputType.name,
                  actionType: TextInputAction.next,
                  onChanged: (value) =>
                      context.read<CarFormBloc>().add(NameChanged(name: value)),
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
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
                MyTextField(
                  initialValue: state.model,
                  hint: '2023',
                  inputType: TextInputType.number,
                  actionType: TextInputAction.next,
                  onChanged: (value) => context.read<CarFormBloc>().add(
                        ModelChanged(model: value),
                      ),
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
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
                MyTextField(
                  initialValue: state.color,
                  hint: 'grey',
                  inputType: TextInputType.text,
                  actionType: TextInputAction.next,
                  onChanged: (value) => context.read<CarFormBloc>().add(
                        ColorChanged(color: value),
                      ),
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
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
                MyTextField(
                  initialValue: state.interiorColor,
                  hint: 'Black',
                  inputType: TextInputType.text,
                  actionType: TextInputAction.next,
                  onChanged: (value) => context.read<CarFormBloc>().add(
                        InteriorColorChanged(interiorColor: value),
                      ),
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
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
                MyTextField(
                  initialValue: state.engine,
                  hint: 'v6 3500cc',
                  inputType: TextInputType.text,
                  actionType: TextInputAction.next,
                  onChanged: (value) => context.read<CarFormBloc>().add(
                        EngineChanged(engine: value),
                      ),
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
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
                MyTextField(
                  initialValue: state.kiloMetrage.toString(),
                  hint: '75',
                  inputType: TextInputType.number,
                  actionType: TextInputAction.next,
                  onChanged: (value) => context.read<CarFormBloc>().add(
                        KilometrageChanged(kilometrage: int.parse(value)),
                      ),
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
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
                MyTextField(
                  initialValue: state.rent.toString(),
                  hint: '50',
                  inputType: TextInputType.number,
                  actionType: TextInputAction.next,
                  onChanged: (value) => context.read<CarFormBloc>().add(
                        RentChanged(rent: int.parse(value)),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            //!car type + fuel type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyDropdown(
                  label: 'type',
                  icon: 'assets/icons/sedan.png',
                  hint: 'select',
                  dropdownValue: state.type,
                  items: CarDropdownConstants.types
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) =>
                      context.read<CarFormBloc>().add(TypeChanged(type: value)),
                ),
                MyDropdown(
                  label: 'fuel',
                  icon: 'assets/icons/gas.png',
                  hint: 'select',
                  dropdownValue: state.fuel,
                  items: CarDropdownConstants.fuels
                      .map((fuel) =>
                          DropdownMenuItem(value: fuel, child: Text(fuel)))
                      .toList(),
                  onChanged: (value) =>
                      context.read<CarFormBloc>().add(FuelChanged(fuel: value)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            //!car transmission + drivetrain
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyDropdown(
                  label: 'transmission',
                  icon: 'assets/icons/gear.png',
                  hint: 'select',
                  dropdownValue: state.transmission,
                  items: CarDropdownConstants.transmissions
                      .map((transmission) => DropdownMenuItem(
                          value: transmission, child: Text(transmission)))
                      .toList(),
                  onChanged: (value) => context
                      .read<CarFormBloc>()
                      .add(TransmissionChanged(transmission: value)),
                ),
                MyDropdown(
                  label: 'drivetrain',
                  icon: 'assets/icons/wheel.png',
                  hint: 'select',
                  dropdownValue: state.drivetrain,
                  items: CarDropdownConstants.drivetrains
                      .map((drivetrain) => DropdownMenuItem(
                          value: drivetrain, child: Text(drivetrain)))
                      .toList(),
                  onChanged: (value) => context
                      .read<CarFormBloc>()
                      .add(DrivetrainChanged(drivetrain: value)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            //! Doors
            Column(
              children: [
                Text(
                  'Doors',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyNumberPicker(
                      value: state.doors,
                      onChanged: (value) {
                        context
                            .read<CarFormBloc>()
                            .add(DoorsChanged(doors: value));
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            //! Seats
            Column(
              children: [
                Text(
                  'Seats',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyNumberPicker(
                      value: state.seats,
                      onChanged: (value) {
                        context
                            .read<CarFormBloc>()
                            .add(SeatsChanged(seats: value));
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            //!features
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Features',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.features.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppColors.charcoal,
                    child: ListTile(
                      dense: true,
                      title: Text(
                        state.features[index],
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.pureWhite,
                          fontSize: 15,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.oceanBlue,
                        ),
                        onPressed: () {
                          context.read<CarFormBloc>().add(
                              FeatureRemoved(feature: state.features[index]));
                        },
                      ),
                    ),
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
                        color: AppColors.steelGrey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.pureWhite,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                        controller: _featureController,
                        cursorColor: AppColors.pureWhite,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Android Auto',
                          hintStyle: AppTypography.labelLarge.copyWith(
                            color: AppColors.pureWhite.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.oceanBlue,
                    ),
                    onPressed: () {
                      if (_featureController.text.isEmpty) return;
                      context
                          .read<CarFormBloc>()
                          .add(FeatureAdded(feature: _featureController.text));
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
                  'description',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.oceanBlue,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: AppColors.charcoal.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.pureWhite,
                  width: 0.4,
                ),
              ),
              child: TextField(
                maxLines: 4,
                textAlign: TextAlign.center,
                cursorColor: AppColors.pureWhite,
                cursorRadius: const Radius.circular(50),
                cursorWidth: 1,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                autofocus: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.pureWhite,
                ),
                onChanged: (value) => context.read<CarFormBloc>().add(
                      DescriptionChanged(description: value),
                    ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }
}
