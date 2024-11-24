import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/favorite_icon.dart';
import 'package:flutter/material.dart';
import '../../data/models/car_model.dart';

class CarCard extends StatelessWidget {
  final Car car;

  const CarCard({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'cardetailsscreen', arguments: car);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 25,
              left: 15,
              bottom: 40,
              top: 10,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: double.infinity,
                height: 180,
                child: Stack(
                  children: [
                    Container(color: AppColors.charcoal),
                    //?child
                    Padding(
                      padding: const EdgeInsets.all(15),
                      //?main colimn
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Hero(
                                            tag: car.name,
                                            child: Text(
                                              '${car.name} ${car.model}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: false,
                                              style: AppTypography.labelLarge
                                                  .copyWith(
                                                color: AppColors.pureWhite,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Hero(
                                tag: car.geoPoint,
                                child: CachedNetworkImage(
                                  imageUrl: car.logo,
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            ],
                          ),
                          FavoriteIcon(car: car),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.sizeOf(context).width / 3,
            top: 100,
            child: SizedBox(
              height: 120,
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Hero(
                tag: car.img,
                child: CachedNetworkImage(
                  imageUrl: car.img,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          //!price
          Positioned(
            left: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              // width: 138,
              decoration: BoxDecoration(
                color: AppColors.coralRed,
                borderRadius: BorderRadius.circular(12),
                gradient: AppColors.cardGradient1,
              ),
              child: Row(
                children: [
                  Text(
                    'Price   ',
                    style: AppTypography.h4.copyWith(
                      color: AppColors.pureWhite,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${car.rent.toString().substring(0, min(4, car.rent.toString().length))} \$',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                  Text(
                    '/D',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
