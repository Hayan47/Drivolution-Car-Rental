import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CarDescriptionWidget extends StatelessWidget {
  final String description;
  const CarDescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Discription',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.oceanBlue,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 10),
          ReadMoreText(
            description,
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.pureWhite,
              fontSize: 15,
            ),
            trimMode: TrimMode.Line,
            trimLines: 2,
            moreStyle: AppTypography.labelLarge.copyWith(
              color: AppColors.pureWhite,
              fontSize: 15,
            ),
            lessStyle: AppTypography.labelLarge.copyWith(
              color: AppColors.pureWhite,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
