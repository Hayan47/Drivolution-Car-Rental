import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarAddDescriptionWidget extends StatelessWidget {
  const CarAddDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'description',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.oceanBlue,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.charcoal.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.pureWhite,
              width: 0.4,
            ),
          ),
          child: TextField(
            maxLines: 4,
            textAlign: TextAlign.center,
            cursorColor: AppColors.pureWhite,
            cursorRadius: const Radius.circular(50),
            cursorWidth: 1,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.multiline,
            autofocus: false,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.pureWhite,
            ),
            onChanged: (value) => context.read<CarFormBloc>().add(
                  DescriptionChanged(description: value),
                ),
          ),
        ),
      ],
    );
  }
}
