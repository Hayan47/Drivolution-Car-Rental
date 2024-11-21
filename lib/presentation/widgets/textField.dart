import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  // final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction actionType;
  final void Function(String)? onChanged;

  const MyTextField({
    super.key,
    required this.hint,
    // required this.controller,
    required this.inputType,
    required this.actionType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: 44,
        width: MediaQuery.sizeOf(context).width * 0.4,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: MyColors.mywhite,
            width: 0.4,
          ),
        ),
        child: SingleChildScrollView(
          child: TextField(
            onChanged: onChanged,
            maxLines: null,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: MyColors.mywhite,
                ),
            // controller: controller,
            decoration: InputDecoration(
              //!hint style
              hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.mywhite.withOpacity(0.5),
                    fontSize: 14,
                  ),
              //!1 enabled border
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: const BorderSide(
              //     color: MyColors.mywhite,
              //     width: 0.2,
              //   ),
              // ),
              //!2 focused border
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(12),
              //   borderSide: const BorderSide(
              //     color: Colors.blue,
              //     width: 1,
              //   ),
              // ),
              //!hint
              hintText: hint,
              floatingLabelStyle: const TextStyle(color: MyColors.myBlue2),
              labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.mywhite,
                  ),
              floatingLabelAlignment: FloatingLabelAlignment.start,
            ),
            cursorHeight: 18,
            keyboardType: inputType,
            textInputAction: actionType,
          ),
        ),
      ),
    );
  }
}
