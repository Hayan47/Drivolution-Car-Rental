import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/logic/reservation_bloc/reservation_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/widgets/reservation_calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class MyReservations extends StatelessWidget {
  final int userid;
  const MyReservations({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    context.read<ReservationBloc>().add(GetUserReservations(userid: userid));
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: PopScope(
        onPopInvoked: (didPop) {
          context.read<CarsBloc>().add(GetAllCarsEvent());
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: const Text('My Reservations')),
          body: BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
              if (state is ReservationsLoaded) {
                return BlocBuilder<CarsBloc, CarsState>(
                  builder: (context, carsState) {
                    if (carsState is CarsLoaded) {
                      return ReservationCalender(
                        reservations: state.reservations,
                        reservedDays: state.disabledDates,
                        cars: carsState.cars,
                      );
                    } else {
                      return Center(
                        child: SizedBox(
                          width: 150,
                          child:
                              Lottie.asset('assets/lottie/SplashyLoader.json'),
                        ),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: SizedBox(
                    width: 150,
                    child: Lottie.asset('assets/lottie/SplashyLoader.json'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
