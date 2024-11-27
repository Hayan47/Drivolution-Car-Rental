import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/favorite_bloc/favorite_bloc.dart';
import 'package:drivolution/presentation/widgets/login_widget.dart';
import 'package:drivolution/presentation/widgets/shimmer_all_cars.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:drivolution/utils/responsive/responsive_widget.dart';
import 'package:drivolution/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
import 'package:lottie/lottie.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: ResponsiveHelper.getHeight(context) * 0.5,
                        ),
                        child: Image.asset('assets/lottie/favorite_cars.png'),
                      ),
                      Text(
                        'add cars to your favorite list!',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.oceanBlue,
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  );
                } else {
                  return ResponsiveWidget(
                    mobile: ListView.builder(
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
                    ),
                    tablet: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 420,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 220,
                      ),
                      itemCount: state.favoriteCars.length,
                      itemBuilder: (context, index) {
                        return CarCard(car: state.favoriteCars[index]);
                      },
                    ),
                  );
                }
              } else {
                return const Column(
                  children: [
                    SizedBox(height: 10),
                    ResponsiveWidget(
                      mobile: AllCarsLoadingMobile(),
                      tablet: AllCarsLoadingTablet(),
                    )
                  ],
                );
              }
            },
          );
        } else {
          return LoginWidget();
        }
      },
    );
  }
}
