import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/cars_bloc/cars_bloc.dart';
import 'package:drivolution/logic/reservation_bloc/reservation_bloc.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/alert_dialog.dart';
import 'package:drivolution/presentation/widgets/car_description_widget.dart';
import 'package:drivolution/presentation/widgets/car_details_widget.dart';
import 'package:drivolution/presentation/widgets/car_features_widget.dart';
import 'package:drivolution/presentation/widgets/confirm_reservation_card.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../../data/models/car_model.dart';
import 'car_box_widget.dart';
import 'image_error_widget.dart';
import 'owner_card.dart';

class CarDetails extends StatefulWidget {
  final Car car;

  const CarDetails({required this.car, super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  DateTimeRange range =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //!car name + model
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Hero(
                      tag: widget.car.location.latitude,
                      child: CachedNetworkImage(
                        imageUrl: widget.car.logo,
                        width: 35,
                        height: 35,
                        errorWidget: (context, url, error) =>
                            ImageErrorSmallWidget(),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          widget.car.name.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: false,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.pureWhite,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                widget.car.model,
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.pureWhite,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          //!car location
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Location   ',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: false,
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.pureWhite,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Text(
                      widget.car.location.name,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'mapscreen',
                    arguments: widget.car),
                child: const Icon(
                  IconlyBroken.location,
                  color: AppColors.oceanBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          //!car price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rent',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.pureWhite,
                  fontSize: 20,
                ),
              ),
              Text(
                '${widget.car.dailyRate.toString()} \$/D',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.pureWhite,
                  fontSize: 20,
                ),
              ),
            ],
          ),

          //!car type
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Text(
                  widget.car.type.toApiString().toLowerCase(),
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.pureWhite,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Builder(
                  builder: (context) {
                    switch (widget.car.type.toApiString().toLowerCase()) {
                      case 'sedan':
                        return Image.asset(
                          'assets/icons/sedan.png',
                          color: AppColors.oceanBlue,
                          width: 40,
                          height: 40,
                        );
                      case 'pick up':
                        return Image.asset(
                          'assets/icons/pickup.png',
                          color: AppColors.oceanBlue,
                          width: 40,
                          height: 40,
                        );
                      case 'suv':
                        return Image.asset(
                          'assets/icons/suv.png',
                          color: AppColors.oceanBlue,
                          width: 40,
                          height: 40,
                        );
                      case 'sport':
                        return Image.asset(
                          'assets/icons/sport.png',
                          color: AppColors.oceanBlue,
                          width: 40,
                          height: 40,
                        );
                      case 'coupe':
                        return Image.asset(
                          'assets/icons/coupe.png',
                          color: AppColors.oceanBlue,
                          width: 40,
                          height: 40,
                        );
                      case 'convertible':
                        return Image.asset(
                          'assets/icons/convertible.png',
                          color: AppColors.oceanBlue,
                          width: 40,
                          height: 40,
                        );
                      case 'hatchback':
                        return Image.asset(
                          'assets/icons/hatchback.png',
                          color: AppColors.oceanBlue,
                          width: 40,
                          height: 40,
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ],
            ),
          ),
          ////////////////////? CAR INFO
          //!1 seats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //!1 seats
                CarBoxWidget(
                  logo: Image.asset(
                    'assets/icons/seats.png',
                    width: 32,
                    height: 32,
                    color: AppColors.oceanBlue,
                  ),
                  title: widget.car.seats.toString(),
                ),
                //!2 doors
                CarBoxWidget(
                  logo: Image.asset(
                    'assets/icons/doors.png',
                    width: 32,
                    height: 32,
                    color: AppColors.oceanBlue,
                  ),
                  title: widget.car.doors.toString(),
                ),
                //!3 fuel
                CarBoxWidget(
                  logo: Image.asset(
                    'assets/icons/${widget.car.fuel.name}.png',
                    width: 32,
                    height: 32,
                    color: AppColors.oceanBlue,
                  ),
                  title: widget.car.fuel.name,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          //!features
          CarFeaturesWidget(
            features: widget.car.features,
          ),
          const SizedBox(height: 20),
          //!Details
          CarDetailsWidget(
            color: widget.car.color,
            interiorColor: widget.car.interiorColor,
            engine: widget.car.engine,
            transmission: widget.car.transmission.toApiString().toLowerCase(),
            drivetrain: widget.car.drivetrain.toApiString().toLowerCase(),
            kilometrage: widget.car.kilometrage.toString(),
          ),
          const SizedBox(height: 20),
          //!Description
          widget.car.description.trim().isNotEmpty
              ? CarDescriptionWidget(
                  description: widget.car.description,
                )
              : Container(),
          const SizedBox(height: 20),
          //!owner
          BlocProvider.value(
            value: context.read<UserBloc>(),
            child: OwnerCard(car: widget.car),
          ),
          const SizedBox(height: 20),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                if (widget.car.owner!.id == state.userid) {
                  //*delete car
                  return BlocListener<CarsBloc, CarsState>(
                    listener: (context, state) {
                      if (state is CarDeleted) {
                        showToastMessage(
                          context,
                          state.message,
                          const Icon(Icons.done,
                              color: AppColors.successGreen, size: 18),
                        );
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'mainscreen',
                          (Route<dynamic> route) => false,
                        );
                      } else if (state is CarsError) {
                        showToastMessage(
                          context,
                          'Error Deleting Car',
                          const Icon(Icons.error,
                              color: AppColors.alertRed, size: 18),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return MyAlertDialog(
                                    onPressed: () {
                                      context.read<CarsBloc>().add(
                                          DeleteCarEvent(
                                              carid: widget.car.id!));
                                    },
                                    text:
                                        'are you sure you want to delete this car?',
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 140,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.oceanBlue),
                                borderRadius: BorderRadius.circular(10),
                                gradient: AppColors.cardGradient1,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'delete car',
                                    style: AppTypography.labelLarge.copyWith(
                                      color: AppColors.pureWhite,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Icon(
                                    IconlyBold.delete,
                                    color: AppColors.oceanBlue,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                } else {
                  return BlocBuilder<ReservationBloc, ReservationState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          //!book now
                          Text(
                            'Book Now!',
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.pureWhite,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          //!Date Pick
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'daterangepicker',
                                        arguments: widget.car.id!);
                                  },
                                  child: Container(
                                    width: 125,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.coralRed,
                                    ),
                                    child: Center(
                                      child: Text(
                                        state is RangePicked
                                            ? '${state.selectedRange.start.year.toString()} / ${state.selectedRange.start.month.toString()} / ${state.selectedRange.start.day.toString()}'
                                            : '${range.start.year.toString()} / ${range.start.month.toString()} / ${range.start.day.toString()}',
                                        style:
                                            AppTypography.labelLarge.copyWith(
                                          color: AppColors.pureWhite,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.blazingRed,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'daterangepicker',
                                        arguments: widget.car.id!);
                                  },
                                  child: Container(
                                    width: 125,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.coralRed,
                                    ),
                                    child: Center(
                                      child: Text(
                                        state is RangePicked
                                            ? '${state.selectedRange.end.year.toString()} / ${state.selectedRange.end.month.toString()} / ${state.selectedRange.end.day.toString()}'
                                            : '${range.end.year.toString()} / ${range.end.month.toString()} / ${range.end.day.toString()}',
                                        style:
                                            AppTypography.labelLarge.copyWith(
                                          color: AppColors.pureWhite,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          //!submit
                          TextButton(
                            onPressed: () {
                              showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: context.read<ReservationBloc>(),
                                      ),
                                      BlocProvider.value(
                                        value: context.read<AuthCubit>(),
                                      ),
                                    ],
                                    child: ConfirmReservation(car: widget.car),
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.coralRed),
                            ),
                            child: Text(
                              'Submit',
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColors.pureWhite,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  );
                }
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
