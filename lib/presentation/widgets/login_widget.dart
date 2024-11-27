import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:drivolution/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: ResponsiveHelper.hp(context, 40),
          ),
          child: Lottie.asset('assets/lottie/register.zip'),
        ),
        Text(
          'Make Your Account Now!',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.oceanBlue,
            fontSize: 26,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
              bottom:
                  ResponsiveHelper.getScreenSize(context) == ScreenSize.small
                      ? 100
                      : 40),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, 'loginscreen');
            },
            backgroundColor: AppColors.oceanBlue,
            label: const Text("log in"),
          ),
        ),
      ],
    );
  }
}
