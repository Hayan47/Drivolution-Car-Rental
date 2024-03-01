import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/screens/add_car_screen.dart';
import 'package:drivolution/presentation/widgets/car_card.dart';
import 'package:drivolution/presentation/widgets/my_car_card.dart';
import 'package:drivolution/presentation/widgets/shimmer_all_cars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCars extends StatelessWidget {
  final String userID;
  const MyCars({super.key, required this.userID});

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
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Cars',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: MyColors.mywhite,
                  fontSize: 22,
                ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              if (state.cars.isEmpty) {
                return AddCarScreen();
              } else {
                return ListView.builder(
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
                );
              }
            } else {
              return const AllCarsLoading();
            }
          },
        ),
      ),
    );
  }
}
