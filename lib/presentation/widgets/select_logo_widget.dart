import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/logic/logo_bloc/logo_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/image_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SelectLogoWidget extends StatelessWidget {
  const SelectLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1,
                  ),
                  itemCount: state.carLogos.length,
                  itemBuilder: (context, index) {
                    final isSelected = state.selectedIndex == index;
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
                            errorWidget: (context, url, error) => ImageErrorSmallWidget(),
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
      ],
    );
  }
}
