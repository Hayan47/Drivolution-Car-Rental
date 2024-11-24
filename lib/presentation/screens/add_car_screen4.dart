import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/album_bloc/album_bloc.dart';
import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/logic/car_image_cubit/car_image_cubit.dart';
import 'package:drivolution/logic/location_bloc/location_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';

class AddCar4 extends StatelessWidget {
  const AddCar4({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'pick an album',
          style: AppTypography.labelLarge.copyWith(color: AppColors.pureWhite),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onLongPress: () {
            context.read<AlbumBloc>().add(ResetAlbumEvent());
            context.read<CarFormBloc>().add(CarAlbumChanged(images: []));
          },
          onTap: () => context.read<AlbumBloc>().add(AddAlbumEvent()),
          child: BlocConsumer<AlbumBloc, AlbumState>(
            listener: (context, state) {
              if (state is AlbumError) {
                showToastMessage(
                  context,
                  state.errorMessage,
                  const Icon(Icons.error, color: AppColors.alertRed, size: 18),
                );
              }
            },
            builder: (context, state) {
              if (state is AlbumChanged) {
                context
                    .read<CarFormBloc>()
                    .add(CarAlbumChanged(images: state.images));
                return GridView.count(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  crossAxisCount: 3,
                  children: List.generate(
                    state.images.length,
                    (index) => Card(
                      child: Image.memory(state.images[index]),
                    ),
                  ),
                );
              } else if (state is AlbumLoading) {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blazingRed,
                    ),
                  ),
                );
              } else {
                return GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  crossAxisCount: 3,
                  children: List.generate(
                    9,
                    (index) => Card(
                      child: Image.asset('assets/img/cars/carholder2.jpg'),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 15),
        //!submit

        BlocConsumer<CarFormBloc, CarFormState>(
          listener: (context, state) {
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
          },
          builder: (context, state) {
            if (state.status == FormStatus.loading) {
              return Center(
                child: SizedBox(
                  width: 40,
                  child: Lottie.asset('assets/lottie/SplashyLoader.json'),
                ),
              );
            } else {
              return TextButton(
                onPressed: () {
                  String id = FirebaseAuth.instance.currentUser!.uid;
                  context.read<CarFormBloc>().add(FormSubmitted(ownerid: id));
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(AppColors.blazingRed),
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
          },
        ),
      ],
    );
  }
}
