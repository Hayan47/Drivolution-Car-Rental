import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';

class CarBoxWidget extends StatelessWidget {
  final Widget logo;
  final String title;

  const CarBoxWidget({
    super.key,
    required this.logo,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 100,
        minHeight: 100,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.pearl.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.pearl.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.jetBlack.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon container with gradient background
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: AppColors.boxGradient,
                  ),
                  child: Center(
                    child: logo,
                  ),
                ),
                // Seats text with gradient
                Row(
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [AppColors.dodgerBlue, AppColors.royalPurple],
                      ).createShader(bounds),
                      child: Text(
                        title,
                        style: AppTypography.labelLarge.copyWith(
                          fontSize: 20,
                          color: AppColors.pearl,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
