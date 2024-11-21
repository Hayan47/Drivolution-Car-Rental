import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AddCar3 extends StatelessWidget {
  const AddCar3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationErrorState) {
          showToastMessage(
            context,
            state.message,
            const Icon(
              Icons.error,
              color: MyColors.myred2,
            ),
          );
        }
        if (state is PickingLocationState) {
          Navigator.pushNamed(context, 'locationpicker');
        }
      },
      builder: (context, state) {
        if (state is LocationPickedState) {
          context.read<CarFormBloc>().add(
                LocationChanged(
                  lang: state.location.longitude,
                  lat: state.location.latitude,
                  locationName: state.city,
                ),
              );
          return Column(
            children: [
              Image.asset('assets/lottie/car_location.png'),
              const SizedBox(height: 25),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.city == ""
                        ? Text(
                            '( ${state.location.latitude.toString().substring(0, 6)} , ${state.location.longitude.toString().substring(0, 6)} )',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: MyColors.mywhite,
                                      fontSize: 26,
                                    ),
                          )
                        : Text(
                            state.city,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: MyColors.mywhite,
                                      fontSize: 26,
                                    ),
                          ),
                    const SizedBox(width: 25),
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
              ),
            ],
          );
        } else {
          return Column(
            children: [
              //!car location
              Image.asset('assets/lottie/car_location.png'),
              const SizedBox(height: 25),
              Text(
                'add your car location',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => context.read<LocationBloc>().add(PickLocation()),
                child: Lottie.asset('assets/lottie/Location.json',
                    width: MediaQuery.sizeOf(context).width * 0.3),
              ),
            ],
          );
        }
      },
    );
  }
}
