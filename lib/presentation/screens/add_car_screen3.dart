import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';

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
              color: AppColors.alertRed,
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
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: ResponsiveHelper.hp(context, 40),
                ),
                child: Image.asset('assets/lottie/car_location.png'),
              ),
              const SizedBox(height: 25),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.city == ""
                        ? Text(
                            '( ${state.location.latitude.toString().substring(0, 6)} , ${state.location.longitude.toString().substring(0, 6)} )',
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.pureWhite,
                              fontSize: 26,
                            ),
                          )
                        : Text(
                            state.city,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.pureWhite,
                              fontSize: 26,
                            ),
                          ),
                    const SizedBox(width: 25),
                    GestureDetector(
                      onTap: () =>
                          context.read<LocationBloc>().add(PickLocation()),
                      child: const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.oceanBlue,
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
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: ResponsiveHelper.hp(context, 40),
                ),
                child: Image.asset('assets/lottie/car_location.png'),
              ),
              // const SizedBox(height: 25),
              Text(
                'add your car location',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.oceanBlue,
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 15),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: ResponsiveHelper.hp(context, 12),
                ),
                child: GestureDetector(
                  onTap: () => context.read<LocationBloc>().add(PickLocation()),
                  child: Lottie.asset(
                    'assets/lottie/Location.json',
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
