import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/logic/car_image_cubit/car_image_cubit.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';

class AddCar1 extends StatelessWidget {
  const AddCar1({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LogoBloc>().add(FetchCarLogosEvent());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          'Select Car Logo',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.pureWhite,
          ),
        ),
        BlocBuilder<LogoBloc, LogoState>(
          builder: (context, state) {
            if (state.carLogos.isEmpty) {
              return Expanded(
                child: Center(
                  child: SizedBox(
                    width: 150,
                    child: Lottie.asset('assets/lottie/SplashyLoader.json'),
                  ),
                ),
              );
            } else {
              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1,
                  ),
                  itemCount: state.carLogos.length,
                  itemBuilder: (context, index) {
                    final isSelected = state.selectedIndex == index;
                    // selectedlogo = state.selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        context.read<LogoBloc>().add(SelectLogoEvent(index));
                        context.read<CarFormBloc>().add(
                              LogoChanged(
                                logoPath: state.carLogos[index],
                              ),
                            );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        decoration: BoxDecoration(
                          borderRadius:
                              isSelected ? BorderRadius.circular(14) : null,
                          border: isSelected
                              ? Border.all(
                                  color: AppColors.oceanBlue,
                                  width: 2,
                                )
                              : null,
                          boxShadow: isSelected
                              ? [
                                  const BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: CachedNetworkImage(
                            imageUrl: state.carLogos[index],
                            // placeholder: (context, url) =>
                            //     Lottie.asset('assets/lottie/SplashyLoader.json'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
        //!select main image
        Text(
          'Select Car Image',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.pureWhite,
          ),
        ),
        const SizedBox(height: 25),
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
