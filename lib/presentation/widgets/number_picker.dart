import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MyNumberPicker extends StatelessWidget {
  final int value;
  final ValueChanged onChanged;
  const MyNumberPicker(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      textStyle: AppTypography.labelLarge.copyWith(color: AppColors.oceanBlue),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.charcoal),
      ),
      selectedTextStyle: AppTypography.labelLarge.copyWith(
        color: AppColors.pureWhite,
        fontSize: 20,
      ),
      axis: Axis.horizontal,
      itemWidth: 30,
      haptics: false,
      value: value,
      minValue: 2,
      maxValue: 50,
      itemCount: 5,
      onChanged: onChanged,
    );
  }
}
