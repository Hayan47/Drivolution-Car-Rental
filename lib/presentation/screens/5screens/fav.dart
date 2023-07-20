import 'package:drivolution/logic/cubit/favorite_cubit.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff1E1E24),
            Color(0xff243B55),
            Color(0xff1E1E24),
          ],
        ),
      ),
      child: Column(
        children: [
          AppBar(
            title: Row(
              children: [
                SizedBox(width: MediaQuery.sizeOf(context).width / 8),
                const Text(
                  'Favorites',
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.favoriteCars.length,
                  itemBuilder: (context, index) {
                    return CarCard(car: state.favoriteCars[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
