import 'package:drivolution/logic/album_bloc/album_bloc.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/logic/car_image_cubit/car_image_cubit.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SubmitCarButton extends StatelessWidget {
  const SubmitCarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarFormBloc, CarFormState>(listener: (context, state) {
      if (state.status == FormStatus.success) {
        showToastMessage(
          context,
          'Car Added Successfully',
          const Icon(Icons.done, color: AppColors.successGreen, size: 18),
        );
        context.read<LogoBloc>().add(ResetLogoEvent());
        context.read<LocationBloc>().add(ResetLocationEvent());
        context.read<AlbumBloc>().add(ResetAlbumEvent());
        context.read<CarImageCubit>().reset();
        Navigator.pushNamedAndRemoveUntil(
          context,
          'mainscreen',
          (Route<dynamic> route) => false,
        );
        context.read<CarFormBloc>().add(ResetFormEvent());
      } else if (state.status == FormStatus.failure) {
        showToastMessage(
          context,
          'Car Not Added Successfully',
          const Icon(Icons.error, color: AppColors.alertRed, size: 18),
        );
      } else if (state.errors.isNotEmpty) {
        showToastMessage(
          context,
          state.errors.values.first,
          const Icon(Icons.error, color: AppColors.alertRed, size: 18),
        );
      }
    }, builder: (context, state) {
      // if (state.status == FormStatus.loading) {
      //   return Center(
      //     child: SizedBox(
      //       width: 40,
      //       child: Lottie.asset('assets/lottie/SplashyLoader.json'),
      //     ),
      //   );
      // } else {
      return TextButton(
        onPressed: () {
          context.read<CarFormBloc>().add(FormSubmitted());
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.blazingRed),
        ),
        child: Text(
          'Submit',
          style: AppTypography.h4.copyWith(
            color: AppColors.pureWhite,
            fontSize: 18,
          ),
        ),
      );
    }
        // },
        );
  }
}
