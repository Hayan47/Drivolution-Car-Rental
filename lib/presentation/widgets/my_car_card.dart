import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';
import '../../data/models/car_model.dart';

class MyCarCard extends StatelessWidget {
  final Car car;

  const MyCarCard({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'cardetailsscreen', arguments: car);
      },
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: const BoxDecoration(
              color: MyColors.myGrey,
              shape: BoxShape.circle,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: car.logo,
                  child: CachedNetworkImage(
                    imageUrl: car.logo,
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
