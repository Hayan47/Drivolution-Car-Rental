import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/presentation/widgets/car_images_widget.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:drivolution/utils/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/car_details.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';

class CarDetailsScreen extends StatelessWidget {
  final Car car;

  const CarDetailsScreen({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepNavy,
      body: ResponsiveWidget(
        mobile: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.deepNavy,
              pinned: true,
              expandedHeight: 225,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(8),
                title: Hero(
                  tag: car.location.longitude,
                  child: Text(
                    textAlign: TextAlign.center,
                    car.name,
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.pureWhite,
                      fontSize: 18,
                    ),
                  ),
                ),
                centerTitle: true,
                background: CarImagesWidget(
                  carImage: car.images[0],
                  carImages: car.images,
                ),
              ),
            ),

            //sliver items
            SliverToBoxAdapter(
              child: CarDetails(car: car),
            ),
          ],
        ),
        tablet: SafeArea(
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: ResponsiveHelper.wp(context, 50),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      CarImagesWidget(
                        carImage: car.images[0],
                        carImages: car.images,
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.pureWhite,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Hero(
                          tag: car.location.longitude,
                          child: Text(
                            textAlign: TextAlign.center,
                            car.name,
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.pureWhite,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: ResponsiveHelper.wp(context, 50),
                  ),
                  child: SingleChildScrollView(child: CarDetails(car: car))),
            ],
          ),
        ),
      ),
    );
  }
}
