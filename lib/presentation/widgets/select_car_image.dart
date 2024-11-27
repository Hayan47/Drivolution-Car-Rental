import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/logic/car_image_cubit/car_image_cubit.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SelectCarImage extends StatelessWidget {
  const SelectCarImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select Car Image',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.pureWhite,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<CarImageCubit>().pickCarImage();
            },
            child: BlocConsumer<CarImageCubit, CarImageState>(
              listener: (context, state) {
                if (state is CarImageError) {
                  showToastMessage(
                    context,
                    state.message,
                    const Icon(Icons.error,
                        color: AppColors.alertRed, size: 18),
                  );
                }
              },
              builder: (context, state) {
                if (state is CarImageChanged) {
                  context
                      .read<CarFormBloc>()
                      .add(MainImageChanged(image: state.imageData));
                  return Center(
                    child: SizedBox(
                      child: Card(
                        color: Colors.transparent,
                        child: Image.memory(
                          state.imageData,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                } else if (state is CarImageLoading) {
                  return Center(
                    child: SizedBox(
                      width: 150,
                      child: Lottie.asset('assets/lottie/SplashyLoader.json'),
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.oceanBlue,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/img/cars/carholder.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
