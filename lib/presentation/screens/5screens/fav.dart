import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/cubit/favorite_cubit.dart';
import 'package:drivolution/logic/cubit/usr_cubit.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late String id;
  List<String> favoriteCars = [];

  // @override
  // void initState() {
  //   super.initState();
  //   context.read<UsrCubit>().getUserInfo(user.uid);
  // }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const ProfileScreen();
    }
    id = FirebaseAuth.instance.currentUser!.uid;
    context.read<UsrCubit>().getUserInfo(id);
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
          // Expanded(
          //   child: BlocBuilder<FavoriteCubit, FavoriteState>(
          //     builder: (context, state) {
          //       return ListView.builder(
          //         itemCount: state.favoriteCars.length,
          //         itemBuilder: (context, index) {
          //           return CarCard(car: state.favoriteCars[index]);
          //         },
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: BlocBuilder<UsrCubit, UsrState>(
              builder: (context, state) {
                if (state is UsrLoaded) {
                  favoriteCars = (state).userInfo.favoriteCars!;
                  if (favoriteCars.isNotEmpty) {
                    final List<Car> favCars = context
                        .read<FavoriteCubit>()
                        .getFavoriteCars(favoriteCars);
                    return BlocBuilder<FavoriteCubit, FavoriteCarsState>(
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: favCars.length,
                          itemBuilder: (context, index) {
                            return CarCard(car: favCars[index]);
                          },
                        );
                      },
                    );
                  }
                  return const Center(child: Text('Start Adding favorites'));
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
