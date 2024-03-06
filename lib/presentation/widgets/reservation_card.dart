import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/presentation/widgets/shimmer_reservations.dart';
import 'package:flutter/material.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/reservation_model.dart';

class ReservationCard extends StatelessWidget {
  final Reservation reservation;
  const ReservationCard({
    Key? key,
    required this.reservation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CarsBloc>().add(GetCarInfo(carID: reservation.carId));
    return BlocBuilder<CarsBloc, CarsState>(
      builder: (context, state) {
        if (state is CarLoaded) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      //!child
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              MyColors.mywhite.withOpacity(0.3),
                              MyColors.mywhite.withOpacity(0.9),
                              MyColors.mywhite.withOpacity(0.3),
                              // MyColors.myred,
                            ],
                          ),
                        ),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${reservation.startDate.year.toString()} / ${reservation.startDate.month.toString()} / ${reservation.startDate.day.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: MyColors.myGrey),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: MyColors.myred,
                              ),
                              Text(
                                '${reservation.endDate.year.toString()} / ${reservation.endDate.month.toString()} / ${reservation.endDate.day.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: MyColors.myGrey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.myred2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    state.car.name.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.mywhite,
                        ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const ReservationLoading();
        }
      },
    );
  }
}
