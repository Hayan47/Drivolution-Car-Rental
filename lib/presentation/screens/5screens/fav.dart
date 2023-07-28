// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drivolution/presentation/widgets/shimmer_all_cars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/cubit/favorite_cubit.dart';
import 'package:drivolution/logic/cubit/usr_cubit.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<String> favCarsIds = [];
  List<Car> favCars = [];

  @override
  void initState() {
    super.initState();
    getFavoriteCars();
  }

  Future<void> getFavoriteCars() async {
    if (FirebaseAuth.instance.currentUser != null) {
      String id = FirebaseAuth.instance.currentUser!.uid;
      final usr = await context.read<UsrCubit>().getUserInfo(id);
      //?get favorite cars
      if (usr!.favoriteCars != null) {
        favCarsIds = usr.favoriteCars!;
        favCars =
            await context.read<FavoriteCubit>().getFavoriteCars(favCarsIds);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const ProfileScreen();
    }
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
            child: BlocBuilder<FavoriteCubit, FavoriteCarsState>(
              builder: (context, state) {
                if (state is FavoriteCarsLoaded) {
                  return ListView.builder(
                    itemCount: favCars.length,
                    itemBuilder: (context, index) {
                      return CarCard(car: favCars[index]);
                    },
                  );
                } else {
                  return const AllCarsLoading();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
