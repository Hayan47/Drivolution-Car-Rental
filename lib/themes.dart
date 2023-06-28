import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool isDarktheme = false;

  ThemeMode get currentTheme => isDarktheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarktheme = !isDarktheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
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
      // app bar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: MyColors.myred3,
        titleTextStyle: GoogleFonts.karla(
          fontWeight: FontWeight.bold,
          color: MyColors.mywhite,
          fontSize: 24,
        ),
        centerTitle: true,
        actionsIconTheme: IconThemeData(
          color: MyColors.mywhite,
        ),
        //icon theme
        iconTheme: IconThemeData(
          color: MyColors.mywhite,
        ),
      ),
      //text theme
      textTheme: TextTheme(
          bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 18,
      )),
      //bottom nav bar theme
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: MyColors.mywhite),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      backgroundColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      primaryColor: MyColors.myred,
      secondaryHeaderColor: MyColors.mywhite,
      hintColor: Colors.grey.shade900,
      // accentColor: Colors.grey.shade900,
      //app bar theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: MyColors.myred3,
        titleTextStyle: GoogleFonts.karla(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 24,
        ),
        centerTitle: true,
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        // icon theme
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      textTheme: TextTheme(
          bodyText1: TextStyle(color: MyColors.mywhite, fontSize: 18)),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Colors.black),
    );
  }
}
