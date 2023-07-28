// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:drivolution/data/models/car_model.dart';

import '../../constants/my_colors.dart';

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
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MyColors.mywhite,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.myred2,
                ),
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: CachedNetworkImage(
                  imageUrl: car.img,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Text(
                car.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.karla(
                  color: MyColors.myred2,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColors.myred2.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'From',
                              style: GoogleFonts.karla(
                                color: MyColors.myBlue2,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${range.start.year.toString()} / ${range.start.month.toString()} / ${range.start.day.toString()}',
                              style: GoogleFonts.karla(
                                color: MyColors.myBlue2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'To',
                              style: GoogleFonts.karla(
                                color: MyColors.myBlue2,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${range.end.year.toString()} / ${range.end.month.toString()} / ${range.end.day.toString()}',
                              style: GoogleFonts.karla(
                                color: MyColors.myBlue2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Rent',
                              style: GoogleFonts.karla(
                                color: MyColors.myBlue2,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '$price \$',
                              style: GoogleFonts.karla(
                                color: MyColors.myBlue2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: confirm,
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  decoration: BoxDecoration(
                    color: MyColors.myred2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.karla(
                          color: MyColors.mywhite,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
