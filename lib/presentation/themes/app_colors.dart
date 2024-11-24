import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Ocean Blues (Previously Primary/Blue colors)
  static const oceanBlue = Color(0xff78bcc4);
  static const deepNavy = Color(0xff002c3e);
  static const twilightBlue = Color(0xff243B55);
  static const skyBlue = Color(0xff9FD5DB);
  static const aquaFrost = Color(0xffB8E0E5);
  static const mistBlue = Color(0xffE5F4F6);

  // Vibrant Reds (Previously Secondary/Red colors)
  static const blazingRed = Color(0xffff2800);
  static const coralRed = Color(0xfff7444e);
  static const sunsetRed = Color(0xffFD1D1D);
  static const darkRed = Color(0xffCC0000);
  static const roseWhite = Color(0xffFFE5E5);
  static const softRed = Color(0xffFF8080);

  // Pure Colors
  static const pureWhite = Color(0xfff7f8f3);
  static const charcoal = Color(0xff1E1E24);

  // Monochrome Scale
  static const pearl = Color(0xffffffff);
  static const silverMist = Color(0xffE1E1E6);
  static const stormGrey = Color(0xffA2A2AD);
  static const steelGrey = Color(0xff686875);
  static const graphite = Color(0xff4A4A53);
  static const slate = Color(0xff2D2D35);
  static const obsidian = Color(0xff1E1E24);
  static const jetBlack = Color(0xff000000);

  // Status Colors
  static const successGreen = Color(0xff4CAF50);
  static const mintGreen = Color(0xffE8F5E9);
  static const goldenAlert = Color(0xffFFC107);
  static const warmYellow = Color(0xffFFF8E1);
  static const alertRed = blazingRed;
  static const softPink = Color(0xffFFEBEE);
  static const infoBlue = oceanBlue;
  static const paleBlue = mistBlue;

  // Text Colors
  static const textDark = obsidian;
  static const textMedium = graphite;
  static const textLight = steelGrey;
  static const textInactive = stormGrey;
  static const textOnDark = pearl;
  static const textOnColor = pearl;
  static const textOnLight = obsidian;

  // Surface Colors
  static const surfacePrimary = pearl;
  static const surfaceAlt = pureWhite;
  static const surfaceHover = Color(0xffF5F5F7);
  static const surfacePressed = Color(0xffECECEE);

  // Border Colors
  static const borderSubtle = silverMist;
  static const borderDefault = stormGrey;
  static const borderBold = graphite;

  // Shadow Colors
  static const shadowSubtle = Color(0x1A000000);
  static const shadowDefault = Color(0x26000000);
  static const shadowIntense = Color(0x33000000);

  // Overlay Colors
  static const overlayLight = Color(0x0DFFFFFF);
  static const overlayDark = Color(0x1A000000);

  // Brand Reference Colors
  static const brandMain = oceanBlue;
  static const brandAccent = blazingRed;
  static const brandHighlight = skyBlue;

  // Function to create Material Color Swatch
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05, .1, .2, .3, .4, .5, .6, .7, .8, .9];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (final double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      charcoal,
      twilightBlue,
      charcoal,
    ],
  );

  static LinearGradient cardGradient1 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      blazingRed.withOpacity(0.6),
      coralRed.withOpacity(1),
      blazingRed.withOpacity(0.6),
    ],
  );

  static const LinearGradient cardGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      charcoal,
      coralRed,
    ],
  );
  // Material Design Swatches
  static final MaterialColor oceanBlueSwatch = createMaterialColor(oceanBlue);
  static final MaterialColor blazingRedSwatch = createMaterialColor(blazingRed);

  // Helper method to get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
