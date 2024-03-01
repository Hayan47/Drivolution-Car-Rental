import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MyNumberPicker extends StatelessWidget {
  final int value;
  final ValueChanged onChanged;
  const MyNumberPicker(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: MyColors.myBlue,
            fontSize: 16,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: MyColors.myred2),
        // color: Colors.white,
      ),
      selectedTextStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: MyColors.mywhite,
            fontSize: 20,
          ),
      axis: Axis.horizontal,
      itemWidth: 30,
      haptics: false,
      value: value,
      minValue: 2,
      maxValue: 50,
      itemCount: 5,
      onChanged: onChanged,
    );
  }
}
