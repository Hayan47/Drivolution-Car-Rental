// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';

class MyDropdown extends StatefulWidget {
  final double? width;
  final String label;
  final Object dropdownValue;
  final List<DropdownMenuItem<Object>> items;
  final ValueChanged onChanged;
  const MyDropdown({
    Key? key,
    this.width,
    required this.label,
    required this.dropdownValue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState<T> extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: MyColors.myred2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(width: 25),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              style: const TextStyle(
                color: MyColors.myred,
                fontWeight: FontWeight.bold,
              ),
              value: widget.dropdownValue,
              items: widget.items,
              onChanged: widget.onChanged,

              //button style
              buttonStyleData: ButtonStyleData(
                height: 40,
                width: 125,
                // elevation: 2,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: MyColors.mywhite,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: MyColors.myred2,
                  ),
                ),
              ),

              //icon style
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: MyColors.myred2,
                  size: 15,
                ),
              ),

              //dropdown style
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                width: widget.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.mywhite,
                ),
                offset: const Offset(5, -3),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(6),
                  thumbColor: MaterialStateProperty.all(MyColors.myred2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
