import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/img/background2.jpg',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          AppBar(
            title: const Text('Favorite'),
            centerTitle: true,
            backgroundColor: MyColors.myred3,
          ),
          // Expanded(
          //   child: GetBuilder<FavoriteController>(
          //     builder: (c) => ListView.builder(
          //       itemCount: c.favoriteCars.length,
          //       itemBuilder: (context, index) {
          //         return CarCard(car: c.favoriteCars[index]);
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
