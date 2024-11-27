import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:flutter/material.dart';

class CarFeaturesWidget extends StatefulWidget {
  final List<String> features;

  const CarFeaturesWidget({super.key, required this.features});

  @override
  State<CarFeaturesWidget> createState() => _CarFeaturesWidgetState();
}

class _CarFeaturesWidgetState extends State<CarFeaturesWidget> {
  final ValueNotifier<bool> _showAllFeatures = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _showAllFeatures.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _showAllFeatures,
        builder: (context, value, child) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.charcoal,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      'Features',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.oceanBlue,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: AppColors.charcoal,
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOutCubicEmphasized,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.features.length >= 3
                        ? _showAllFeatures.value
                            ? widget.features.length
                            : 3
                        : widget.features.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppColors.oceanBlue,
                              foregroundColor: AppColors.deepNavy,
                              child: Text('${index + 1}'),
                            ),
                            title: Text(
                              widget.features[index],
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColors.pureWhite,
                              ),
                            ),
                          ),
                          widget.features.length - 1 == index
                              ? Container()
                              : const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(
                                    color: AppColors.oceanBlue,
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              !_showAllFeatures.value
                  ? Container(
                      decoration: const BoxDecoration(
                        color: AppColors.charcoal,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(24),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => _showAllFeatures.value = true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.pureWhite,
                              ),
                              Text(
                                'Show all features',
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.pureWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        color: AppColors.charcoal,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(24),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => _showAllFeatures.value = false,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.arrow_drop_up,
                                color: AppColors.pureWhite,
                              ),
                              Text(
                                'Show less',
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.pureWhite,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ],
          );
        });
  }
}
