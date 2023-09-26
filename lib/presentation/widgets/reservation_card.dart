// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:drivolution/constants/my_colors.dart';
import '../../data/models/car_model.dart';
import '../../data/models/reservation_model.dart';

class ReservationCard extends StatelessWidget {
  final Car car;
  final List<Reservation> carReservations;
  const ReservationCard({
    Key? key,
    required this.car,
    required this.carReservations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                //!blur
                BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 50,
                    sigmaY: 50,
                  ),
                  child: Container(),
                ),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CachedNetworkImage(
                          imageUrl: car.img,
                          fit: BoxFit.fitWidth,
                          height: 55,
                        ),
                        SizedBox(
                          height: 35,
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          child: ListView(
                            shrinkWrap: true,
                            children: List.generate(
                              carReservations.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          MyColors.myBlue2.withOpacity(0.3),
                                          MyColors.myBlue.withOpacity(0.7),
                                          MyColors.myBlue2.withOpacity(0.3),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${carReservations[index].startDate.day.toString()}-${carReservations[index].startDate.month.toString()} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: MyColors.mywhite,
                                                  fontSize: 14,
                                                ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 12,
                                            ),
                                          ),
                                          Text(
                                            '${carReservations[index].endDate.day.toString()}-${carReservations[index].endDate.month.toString()} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: MyColors.mywhite,
                                                  fontSize: 14,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
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
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: MyColors.myred4,
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  MyColors.myred.withOpacity(0.6),
                  MyColors.myred2.withOpacity(1),
                  MyColors.myred.withOpacity(0.6),
                ],
              ),
            ),
            child: Text(
              car.name.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.mywhite,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
