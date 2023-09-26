import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static ThemeData get appTheme {
    return ThemeData(
      //stretch
      androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      //back color
      backgroundColor: MyColors.mywhite,
      //scaff back color
      scaffoldBackgroundColor: MyColors.mywhite,
      // p color
      primaryColor: MyColors.myred,
      //sec color
      secondaryHeaderColor: Colors.black,
      //hint color
      hintColor: MyColors.myBlue,
      //acc color
      // accentColor: MyColors.myBlue2,
      //? app bar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: GoogleFonts.karla(
          fontWeight: FontWeight.bold,
          color: MyColors.mywhite,
          fontSize: 25,
        ),
        actionsIconTheme: const IconThemeData(
          color: MyColors.mywhite,
        ),
        //icon theme
        iconTheme: const IconThemeData(
          color: MyColors.mywhite,
        ),
      ),
      //?text theme
      textTheme: TextTheme(
        //! 1
        bodyMedium: GoogleFonts.roboto(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        //! 2
        bodySmall: GoogleFonts.karla(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      //?bottom nav bar theme
      bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(backgroundColor: MyColors.mywhite),
    );
  }
}
