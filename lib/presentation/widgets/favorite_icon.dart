import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/favorite_bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FavoriteIcon extends StatelessWidget {
  final Car car;
  const FavoriteIcon({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authstate) {
        if (authstate is Authenticated) {
          if (car.ownerid == authstate.user.uid) {
            return Container();
          } else {
            return Hero(
              tag: car.id!,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                  buildWhen: (previous, current) {
                    if (current is AddingCarToFavorite) {
                      if (current.id == car.id) {
                        return true;
                      }
                      return false;
                    } else if (current is RemovingCarFromFavorite) {
                      if (current.id == car.id) {
                        return true;
                      }
                      return false;
                    }
                    return true;
                  },
                  builder: (context, state) {
                    if (state is FavoriteCarsLoaded) {
                      if (state.favoriteCars.contains(car)) {
                        return GestureDetector(
                          onTap: () {
                            context.read<FavoriteBloc>().add(
                                  RemoveCarFromFavorites(
                                    car: car,
                                    userid: authstate.user.uid,
                                  ),
                                );
                          },
                          child: SizedBox(
                            width: 46,
                            height: 46,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                'assets/icons/love2.png',
                              ),
                            ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            context.read<FavoriteBloc>().add(
                                  AddCarToFavorites(
                                    car: car,
                                    userid: authstate.user.uid,
                                  ),
                                );
                          },
                          child: SizedBox(
                            width: 46,
                            height: 46,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(
                                'assets/icons/love.png',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    } else if (state is AddingCarToFavorite) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Lottie.asset(
                          'assets/lottie/heart_fill.json',
                          width: 30,
                          height: 30,
                          repeat: false,
                        ),
                      );
                    } else if (state is RemovingCarFromFavorite) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Lottie.asset(
                          'assets/lottie/heart_break.json',
                          width: 30,
                          height: 30,
                          repeat: false,
                        ),
                      );
                    } else {
                      return Lottie.asset(
                        'assets/lottie/heart_loading.json',
                        width: 25,
                        height: 25,
                      );
                    }
                  },
                ),
              ),
            );
          }
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/icons/love2.png',
              width: 30,
              height: 30,
              color: Colors.grey.shade400,
            ),
          );
        }
      },
    );
  }
}
