// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';

class MyDropdown extends StatelessWidget {
  final double? width;
  final String label;
  final Object? dropdownValue;
  final List<DropdownMenuItem<Object>> items;
  final ValueChanged onChanged;
  final String icon;
  final String hint;
  const MyDropdown({
    Key? key,
    this.width,
    required this.label,
    this.dropdownValue,
    required this.items,
    required this.onChanged,
    required this.icon,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                icon,
                color: // MyColors.myBlue,
                    icon == 'assets/icons/age.png' ? null : MyColors.myBlue,
                width: 25,
                height: 25,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: MyColors.myred2,
                      fontSize: 15,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // const SizedBox(width: 25),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.myred2,
                    fontSize: 14,
                  ),
              value: dropdownValue,
              items: items,
              onChanged: onChanged,
              hint: Text(hint),

              //button style
              buttonStyleData: ButtonStyleData(
                height: 40,
                width: MediaQuery.sizeOf(context).width * 0.4,
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
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.mywhite,
                ),
                offset: const Offset(5, -3),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: WidgetStateProperty.all(6),
                  thumbColor: WidgetStateProperty.all(MyColors.myred2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
