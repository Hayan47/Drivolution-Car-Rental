// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/favorite_bloc/favorite_bloc.dart';
import 'package:drivolution/presentation/widgets/shimmer_all_cars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drivolution/presentation/screens/5screens/prof.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteCarsLoaded) {
                if (state.favoriteCars.isEmpty) {
                  return Column(
                    children: [
                      Image.asset('assets/lottie/favorite_cars.png'),
                      Text(
                        'add cars to your favorite list!',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyColors.myBlue,
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: state.favoriteCars.length,
                    itemBuilder: (context, index) {
                      if (index == state.favoriteCars.length - 1) {
                        //? Return the last item with some padding
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 65),
                          child: CarCard(car: state.favoriteCars[index]),
                        );
                      } else {
                        return CarCard(car: state.favoriteCars[index]);
                      }
                    },
                  );
                }
              } else {
                return const Column(
                  children: [AllCarsLoading()],
                );
              }
            },
          );
        } else {
          return const ProfileScreen();
        }
      },
    );
  }
}
