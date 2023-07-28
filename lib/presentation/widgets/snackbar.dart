import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySnackBar extends SnackBar {
  MySnackBar({
    Key? key,
    required Icon icon,
    required String title,
    required String message,
    required double margin,
  }) : super(
          key: key,
          content:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 4),
                Text(title),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: GoogleFonts.roboto(
                color: MyColors.mywhite,
                fontSize: 14,
              ),
            ),
          ]),
          margin: EdgeInsets.symmetric(vertical: margin, horizontal: 20),
          elevation: 50,
          duration: const Duration(seconds: 8),
          backgroundColor: Colors.black.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () {},
          ),
        );
}
