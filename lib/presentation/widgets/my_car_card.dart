import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/favorite_bloc/favorite_bloc.dart';
import 'package:drivolution/presentation/widgets/favorite_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../data/models/car_model.dart';

class MyCarCard extends StatefulWidget {
  final Car car;

  const MyCarCard({required this.car, super.key});

  @override
  State<MyCarCard> createState() => _MyCarCardState();
}

class _MyCarCardState extends State<MyCarCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'cardetailsscreen', arguments: widget.car);
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
                  tag: widget.car.logo,
                  child: CachedNetworkImage(
                    imageUrl: widget.car.logo,
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 120,
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: Hero(
                    tag: widget.car.img,
                    child: CachedNetworkImage(
                      imageUrl: widget.car.img,
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
