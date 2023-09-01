// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.55,
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
                  //!pic
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: MyColors.myBlue2.withOpacity(0.3),
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
                          color: MyColors.myBlue2,
                        ),
                  ),
                  //!car info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 107,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: MyColors.myBlue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2,
                        ),
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(),
                                bottom: BorderSide(),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'From',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: MyColors.myBlue2,
                                      fontSize: 18,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'To',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: MyColors.myBlue2,
                                      fontSize: 18,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(),
                                bottom: BorderSide(),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Rent',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: MyColors.myBlue2,
                                      fontSize: 18,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${range.start.day.toString()}/${range.start.month.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: MyColors.mywhite,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${range.end.day.toString()}/${range.end.month.toString()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: MyColors.mywhite,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$price \$',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: MyColors.mywhite,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // //!rent info
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: MyColors.myBlue.withOpacity(0.5),
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         //!first row
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               Text(
                  //                 'From',
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .bodyMedium!
                  //                     .copyWith(
                  //                       color: MyColors.myBlue2,
                  //                       fontSize: 18,
                  //                     ),
                  //               ),
                  //               Text(
                  //                 'To',
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .bodyMedium!
                  //                     .copyWith(
                  //                       color: MyColors.myBlue2,
                  //                       fontSize: 18,
                  //                     ),
                  //               ),
                  //               Text(
                  //                 'Rent',
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .bodyMedium!
                  //                     .copyWith(
                  //                       color: MyColors.myBlue2,
                  //                       fontSize: 18,
                  //                     ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         //!second row
                  //         Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: [
                  //               Text(
                  //                 '${range.start.day.toString()}/${range.start.month.toString()}',
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .bodySmall!
                  //                     .copyWith(
                  //                       color: MyColors.mywhite,
                  //                     ),
                  //               ),
                  //               Text(
                  //                 '${range.end.day.toString()}/${range.end.month.toString()}',
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .bodySmall!
                  //                     .copyWith(
                  //                       color: MyColors.mywhite,
                  //                     ),
                  //               ),
                  //               Text(
                  //                 '$price \$',
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .bodySmall!
                  //                     .copyWith(
                  //                       color: MyColors.mywhite,
                  //                     ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  //!confirm
                  GestureDetector(
                    onTap: confirm,
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
