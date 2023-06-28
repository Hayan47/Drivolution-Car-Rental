// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/my_colors.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction actionType;

  const MyTextField({
    Key? key,
    required this.hint,
    required this.controller,
    required this.inputType,
    required this.actionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 44,
        width: 160,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          style: GoogleFonts.karla(
            color: MyColors.mywhite,
            fontSize: 16,
          ),
          controller: controller,
          decoration: InputDecoration(
            //hint style
            hintStyle: GoogleFonts.karla(
              color: MyColors.mywhite.withOpacity(0.5),
              fontSize: 14,
            ),
            //1 enabled border
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: MyColors.mywhite,
                width: 0.2,
              ),
            ),
            //2 focused border
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(21),
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 1,
              ),
            ),
            //hint
            hintText: hint,
            floatingLabelStyle: const TextStyle(color: MyColors.myBlue2),
            labelStyle: GoogleFonts.karla(
              color: MyColors.mywhite,
              fontSize: 16,
            ),
            floatingLabelAlignment: FloatingLabelAlignment.start,
          ),
          cursorHeight: 25,
          keyboardType: inputType,
          textInputAction: actionType,
        ),
      ),
    );
  }
}
