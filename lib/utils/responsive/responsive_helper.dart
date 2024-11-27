import 'package:drivolution/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double getWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait;
  }

  // Responsive spacing methods
  static double hp(BuildContext context, double percentage) {
    return getHeight(context) * (percentage / 100);
  }

  static double wp(BuildContext context, double percentage) {
    return getWidth(context) * (percentage / 100);
  }

  // Font scaling
  static double sp(BuildContext context, double size) {
    final width = getWidth(context);
    return size * (width / 375); // Using iPhone 8 as base width
  }

  // Get current screen size category
  static ScreenSize getScreenSize(BuildContext context) {
    final width = getWidth(context);
    if (width < 600) return ScreenSize.small;
    if (width < 1024) return ScreenSize.medium;
    if (width < 1440) return ScreenSize.large;
    return ScreenSize.extraLarge;
  }

  // Responsive padding based on screen size
  static EdgeInsets screenPadding(BuildContext context) {
    final screenSize = getScreenSize(context);
    switch (screenSize) {
      case ScreenSize.small:
        return EdgeInsets.symmetric(horizontal: wp(context, 5));
      case ScreenSize.medium:
        return EdgeInsets.symmetric(horizontal: wp(context, 10));
      case ScreenSize.large:
      case ScreenSize.extraLarge:
        return EdgeInsets.symmetric(horizontal: wp(context, 15));
    }
  }
}
