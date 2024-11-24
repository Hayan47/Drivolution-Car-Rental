import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData get appTheme {
    return ThemeData(
      //? app bar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: GoogleFonts.karla(
          fontWeight: FontWeight.bold,
          color: AppColors.pureWhite,
          fontSize: 22,
        ),
        actionsIconTheme: const IconThemeData(
          color: AppColors.pureWhite,
        ),
        //icon theme
        iconTheme: const IconThemeData(
          color: AppColors.pureWhite,
        ),
      ),
    );
  }
}
