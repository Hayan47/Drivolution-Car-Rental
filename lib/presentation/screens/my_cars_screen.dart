import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/widgets/add_car_widget.dart';
import 'package:drivolution/presentation/widgets/my_car_card.dart';
import 'package:drivolution/presentation/widgets/shimmer_all_cars.dart';
import 'package:drivolution/utils/responsive/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCars extends StatelessWidget {
  final String userID;
  const MyCars({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Cars')),
        backgroundColor: Colors.transparent,
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              if (state.cars.isEmpty) {
                return Center(child: AddCarWidget(uid: state.userInfo.userid));
              } else {
                return ResponsiveWidget(
                  mobile: ListView.builder(
                    itemCount: state.cars.length,
                    itemBuilder: (context, index) {
                      if (index == state.cars.length - 1) {
                        //? Return the last item with some padding
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 65),
                          child: MyCarCard(car: state.cars[index]),
                        );
                      } else {
                        return MyCarCard(car: state.cars[index]);
                      }
                    },
                  ),
                  tablet: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 400),
                    itemCount: state.cars.length,
                    itemBuilder: (context, index) {
                      return MyCarCard(car: state.cars[index]);
                    },
                  ),
                );
              }
            } else {
              return const ResponsiveWidget(
                mobile: AllCarsLoadingMobile(),
                tablet: AllCarsLoadingTablet(),
              );
            }
          },
        ),
      ),
    );
  }
}
