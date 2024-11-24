import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MyDropdown extends StatelessWidget {
  final double? width;
  final String label;
  final Object? dropdownValue;
  final List<DropdownMenuItem<Object>> items;
  final ValueChanged onChanged;
  final String icon;
  final String hint;
  const MyDropdown({
    super.key,
    this.width,
    required this.label,
    this.dropdownValue,
    required this.items,
    required this.onChanged,
    required this.icon,
    required this.hint,
  });

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
                color:
                    icon == 'assets/icons/age.png' ? null : AppColors.oceanBlue,
                width: 25,
                height: 25,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.coralRed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.coralRed,
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
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.coralRed,
                  ),
                ),
              ),

              //icon style
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.coralRed,
                  size: 15,
                ),
              ),

              //dropdown style
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.pureWhite,
                ),
                offset: const Offset(5, -3),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: WidgetStateProperty.all(6),
                  thumbColor: WidgetStateProperty.all(AppColors.coralRed),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
