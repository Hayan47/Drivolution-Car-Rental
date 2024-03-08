import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/reservation_bloc/reservation_bloc.dart';
import 'package:drivolution/presentation/widgets/reservation_card.dart';
import 'package:drivolution/presentation/widgets/shimmer_reservations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyReservations extends StatelessWidget {
  final String userID;
  const MyReservations({super.key, required this.userID});

  @override
  Widget build(BuildContext context) {
    context.read<ReservationBloc>().add(GetUserReservations(userID: userID));
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            MyColors.myGrey,
            MyColors.myBlue4,
            MyColors.myGrey,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('My Reservations')),
        body: BlocBuilder<ReservationBloc, ReservationState>(
          builder: (context, state) {
            if (state is ReservationsLoaded) {
              return ListView.builder(
                itemCount: state.reservations.length,
                itemBuilder: (context, index) {
                  return ReservationCard(
                    reservation: state.reservations[index],
                  );
                },
              );
            } else {
              return const ReservationLoading();
            }
          },
        ),
      ),
    );
  }
}
