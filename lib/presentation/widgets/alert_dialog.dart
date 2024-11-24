import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const MyAlertDialog({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.coralRed,
      title: Text(
        text,
        style: AppTypography.h4.copyWith(
          fontSize: 16,
          color: AppColors.pureWhite,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            'yes',
            style: AppTypography.h4.copyWith(
              fontSize: 16,
              color: AppColors.pureWhite,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(AppColors.steelGrey)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'no',
            style: AppTypography.h4.copyWith(
              fontSize: 16,
              color: AppColors.pureWhite,
            ),
          ),
        ),
      ],
    );
  }
}
