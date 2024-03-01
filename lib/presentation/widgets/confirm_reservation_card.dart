import 'dart:ui';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/reservation_bloc/reservation_bloc.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/my_colors.dart';

@immutable
class ConfirmReservation extends StatelessWidget {
  final Car car;

  const ConfirmReservation({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationBloc, ReservationState>(
      listener: (context, state) {
        if (state is ReservationsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            MySnackBar(
              icon: const Icon(Icons.error, color: MyColors.myred2, size: 18),
              message: state.message,
              margin: 5,
            ),
          );
        } else if (state is ReservationsInitial) {
          ScaffoldMessenger.of(context).showSnackBar(
            MySnackBar(
              icon: const Icon(Icons.done, color: Colors.green, size: 18),
              message: 'Reservation made successfully',
              margin: 5,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is RangePicked) {
          int price = (state.duration + 1) * car.rent;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.3,
                  width: double.infinity,
                  //?blur effect
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 30,
                      sigmaY: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //!car name
                        Text(
                          car.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: MyColors.mywhite, fontSize: 26),
                        ),
                        //! car info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${state.selectedRange.start.day.toString()}/${state.selectedRange.start.month.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: MyColors.mywhite,
                                      fontSize: 20,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 30,
                                color: MyColors.mywhite,
                              ),
                              Text(
                                '${state.selectedRange.end.day.toString()}/${state.selectedRange.end.month.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: MyColors.mywhite,
                                      fontSize: 20,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '$price \$',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 20,
                                  ),
                          textAlign: TextAlign.center,
                        ),

                        //!confirm
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, authState) {
                            if (authState is Authenticated) {
                              return GestureDetector(
                                onTap: () {
                                  context.read<ReservationBloc>().add(
                                        MakeReservation(
                                          reservation: Reservation(
                                            carId: car.id!,
                                            customerId: authState.user.uid,
                                            startDate:
                                                state.selectedRange.start,
                                            endDate: state.selectedRange.end,
                                          ),
                                        ),
                                      );
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  decoration: BoxDecoration(
                                    color: MyColors.myBlue2.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Confirm',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              color: MyColors.mywhite,
                                              fontSize: 20,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
