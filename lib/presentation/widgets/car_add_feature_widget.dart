import 'package:drivolution/logic/car_form_bloc/car_form_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarAddFeatureWidget extends StatelessWidget {
  final _featureController = TextEditingController();
  final List<String> features;
  CarAddFeatureWidget({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Add Features',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.oceanBlue,
            fontSize: 18,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 350,
            ),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: features.length,
              itemBuilder: (context, index) {
                return Card(
                  color: AppColors.charcoal,
                  child: ListTile(
                    dense: true,
                    title: Text(
                      features[index],
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 15,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: AppColors.oceanBlue,
                      ),
                      onPressed: () {
                        context
                            .read<CarFormBloc>()
                            .add(FeatureRemoved(feature: features[index]));
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 450,
            ),
            child: Row(
              children: [
                const SizedBox(width: 50),
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.steelGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                      controller: _featureController,
                      cursorColor: AppColors.pureWhite,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Android Auto',
                        hintStyle: AppTypography.labelLarge.copyWith(
                          color: AppColors.pureWhite.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.oceanBlue,
                    ),
                    onPressed: () {
                      if (_featureController.text.isEmpty) return;
                      context
                          .read<CarFormBloc>()
                          .add(FeatureAdded(feature: _featureController.text));
                      _featureController.clear();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
