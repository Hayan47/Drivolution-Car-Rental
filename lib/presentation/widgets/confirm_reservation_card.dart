import 'dart:ui';
import 'package:drivolution/data/models/reservation_model.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/reservation_bloc/reservation_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class ConfirmReservation extends StatelessWidget {
  final Car car;

  const ConfirmReservation({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationBloc, ReservationState>(
      listener: (context, state) {
        if (state is ReservationsError) {
          showToastMessage(
            context,
            state.message,
            const Icon(Icons.error, color: AppColors.alertRed, size: 18),
          );
        } else if (state is ReservationsInitial) {
          showToastMessage(
            context,
            'Reservation made successfully',
            const Icon(Icons.done, color: AppColors.successGreen, size: 18),
          );
        }
      },
      builder: (context, state) {
        if (state is RangePicked) {
          double price = (state.duration + 1) * car.dailyRate;
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
                          style: AppTypography.labelLarge.copyWith(
                              color: AppColors.pureWhite, fontSize: 26),
                        ),
                        //! car info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                '${state.selectedRange.start.day.toString()}/${state.selectedRange.start.month.toString()}',
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.pureWhite,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 30,
                                color: AppColors.pureWhite,
                              ),
                              Text(
                                '${state.selectedRange.end.day.toString()}/${state.selectedRange.end.month.toString()}',
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.pureWhite,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '$price \$',
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.pureWhite,
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
                                            car: car.id!,
                                            renter: authState.userid,
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
                                    color: AppColors.deepNavy.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Confirm',
                                        style:
                                            AppTypography.labelLarge.copyWith(
                                          color: AppColors.pureWhite,
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
