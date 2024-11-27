import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:drivolution/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (ResponsiveHelper.getScreenSize(context) == ScreenSize.large ||
            ResponsiveHelper.getScreenSize(context) == ScreenSize.extraLarge &&
                desktop != null) {
          return tablet!;
        }
        if (ResponsiveHelper.getScreenSize(context) == ScreenSize.medium &&
            tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}
