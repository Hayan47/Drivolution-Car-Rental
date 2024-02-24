import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/presentation/screens/location_picker.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class AddCar3 extends StatefulWidget {
  const AddCar3({super.key});

  @override
  State<AddCar3> createState() => _AddCar3State();
}

class _AddCar3State extends State<AddCar3> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listenWhen: (previous, current) {
        return previous == current || previous != current;
      },
      listener: (context, state) {
        if (state is LocationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            MySnackBar(
              icon: const Icon(Icons.error, color: MyColors.myred2, size: 18),
              message: state.message,
              margin: 5,
            ),
          );
        }
        if (state is PickingLocationState) {
          Navigator.pushNamed(context, 'locationpicker');
        }
      },
      builder: (context, state) {
        if (state is LocationPickedState) {
          return Column(
            children: [
              Image.asset('assets/lottie/car_location.png'),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'edit location',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.myBlue,
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () =>
                        context.read<LocationBloc>().add(PickLocation()),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: MyColors.myBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.myred2,
                        fontSize: 14,
                      ),
                  children: [
                    const TextSpan(
                      text: 'latitude: ',
                    ),
                    TextSpan(
                      text: state.location.latitude.toString(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.myred2,
                        fontSize: 14,
                      ),
                  children: [
                    const TextSpan(
                      text: 'longitude: ',
                    ),
                    TextSpan(
                      text: state.location.longitude.toString(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.myred2,
                        fontSize: 18,
                      ),
                  children: [
                    const TextSpan(
                      text: 'city: ',
                    ),
                    TextSpan(
                      text: state.city,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: MyColors.mywhite,
                            fontSize: 18,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              //!car location
              Image.asset('assets/lottie/car_location.png'),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'add your car location',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.myBlue,
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () =>
                        context.read<LocationBloc>().add(PickLocation()),
                    child: const Icon(
                      Icons.location_on_outlined,
                      color: MyColors.myBlue,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
