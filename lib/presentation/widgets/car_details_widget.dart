import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';

class CarDetailsWidget extends StatelessWidget {
  final String color;
  final String interiorColor;
  final String engine;
  final String transmission;
  final String drivetrain;
  final String kilometrage;

  const CarDetailsWidget({
    super.key,
    required this.color,
    required this.interiorColor,
    required this.engine,
    required this.transmission,
    required this.drivetrain,
    required this.kilometrage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.pearl.withOpacity(0.1),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                'Details',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.oceanBlue,
                  fontSize: 26,
                ),
              ),
            ),
          ),
        ),
        //!1 color
        Container(
          decoration: BoxDecoration(
              color: AppColors.pearl.withOpacity(0.1),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Color',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      color,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: AppColors.oceanBlue,
                ),
              ),
              //!2 interior color
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Interior Color',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      interiorColor,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: AppColors.oceanBlue,
                ),
              ),
              //!3 engine
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Engine',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        engine,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        textAlign: TextAlign.end,
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.pureWhite,
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: AppColors.oceanBlue,
                ),
              ),
              //!4 transmission
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transmission',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      transmission,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: AppColors.oceanBlue,
                ),
              ),
              //!5 Drive train
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Drivetrain',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      drivetrain,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: AppColors.oceanBlue,
                ),
              ),
              //!6 kilometrage
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'kilometrage',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      kilometrage,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
