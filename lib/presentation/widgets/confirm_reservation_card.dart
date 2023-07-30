// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:drivolution/data/models/car_model.dart';

import '../../constants/my_colors.dart';

@immutable
class ConfirmReservation extends StatelessWidget {
  Car car;
  DateTimeRange range;
  int price;
  void Function() confirm;
  ConfirmReservation({
    Key? key,
    required this.car,
    required this.range,
    required this.price,
    required this.confirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child:
            // Container(
            //   height: MediaQuery.sizeOf(context).height * 0.5,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     // gradient: SweepGradient(
            //     //   colors: [
            //     //     // MyColors.myBlue,
            //     //     // MyColors.myBlue2,
            //     //     // MyColors.myBlue,
            //     //     // MyColors.myBlue2,
            //     //     // MyColors.myred2,
            //     //     // MyColors.myred3,
            //     //     MyColors.myBlue2.withOpacity(1),
            //     //     MyColors.myBlue.withOpacity(1),
            //     //   ],
            //     // ),

            //   ),

            ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.55,
            width: double.infinity,
            decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     // MyColors.myred3.withOpacity(0.3),
                //     MyColors.myred2.withOpacity(0.3),
                //     MyColors.myBlue2.withOpacity(0.3),
                //     // MyColors.myBlue.withOpacity(0.3),
                //     // MyColors.myBlue2.withOpacity(0.3),
                //     // MyColors.myBlue.withOpacity(0.3),
                //   ],
                // ),
                // color: MyColors.myred2.withOpacity(0.5),
                ),
            //?blur effect
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //!pic
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: MyColors.mywhite.withOpacity(0.5),
                    ),
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    height: MediaQuery.sizeOf(context).width * 0.5,
                    child: CachedNetworkImage(
                      imageUrl: car.img,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  //!car name
                  Text(
                    car.name.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: MyColors.mywhite.withOpacity(0.7),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: MyColors.mywhite.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          //!first row
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'From',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: MyColors.myBlue2,
                                        fontSize: 18,
                                      ),
                                ),
                                Text(
                                  'To',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: MyColors.myBlue2,
                                        fontSize: 18,
                                      ),
                                ),
                                Text(
                                  'Rent',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: MyColors.myBlue2,
                                        fontSize: 18,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          //!second row
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '${range.start.month.toString()} / ${range.start.day.toString()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: MyColors.mywhite,
                                      ),
                                ),
                                Text(
                                  '${range.end.month.toString()} / ${range.end.day.toString()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: MyColors.mywhite,
                                      ),
                                ),
                                Text(
                                  '$price \$',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: MyColors.mywhite,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //!confirm
                  GestureDetector(
                    onTap: confirm,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      decoration: BoxDecoration(
                        color: MyColors.mywhite.withOpacity(0.5),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
