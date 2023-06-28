import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/car_model.dart';

class OwnerCard extends StatelessWidget {
  final Car car;
  OwnerCard({required this.car, super.key});

  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.pushNamed(context, cardetailsscreen, arguments: widget.car);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 25,
              left: 15,
              top: 50,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: double.infinity,
                height: 180,
                child: Stack(
                  children: [
                    //blur effect

                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: Container(),
                    ),

                    //gradiant effect

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              MyColors.myred.withOpacity(1),
                              MyColors.myred2.withOpacity(0.5),
                              MyColors.myBlue.withOpacity(0.5),
                              MyColors.myBlue2.withOpacity(1),
                            ]),
                      ),
                    ),

                    //child

                    Padding(
                      padding: const EdgeInsets.all(15),
                      //main colimn
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //price
                          Container(
                            padding: const EdgeInsets.all(6),
                            width: 125,
                            decoration: BoxDecoration(
                                color: MyColors.myred.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  //boorom right dark
                                  BoxShadow(
                                    color: MyColors.myBlue2,
                                    offset: Offset(5, 5),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                  //top left light
                                  BoxShadow(
                                    color: MyColors.myBlue,
                                    offset: Offset(-2, -2),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ]),
                            child: Row(
                              children: [
                                Text(
                                  'Price   ',
                                  style: GoogleFonts.karla(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${car.rentd}\$',
                                  style: GoogleFonts.karla(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '/D',
                                  style: GoogleFonts.karla(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                          //divider
                          Divider(
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          //main row
                          //picture
                          Expanded(
                            child: Row(
                              children: [
                                // name + number + buttons
                                SizedBox(
                                  width: 60,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          const Center(
                                              child: CircularProgressIndicator(
                                        color: MyColors.mywhite,
                                      )),
                                      imageUrl: car.img!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        car.name!,
                                        style: GoogleFonts.karla(
                                          color: MyColors.myBlue2,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 5),

                                      Text(
                                        car.id!.toString(),
                                        style: GoogleFonts.karla(
                                          color: MyColors.myBlue2,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 25),

                                      //call

                                      GestureDetector(
                                        onTap: () async {
                                          final Uri phone = Uri(
                                            scheme: 'tel',
                                            // path: userController
                                            //     .user.phoneNumber,
                                            //path: widget.car.owner!.phoneNumper,
                                          );
                                          if (await canLaunchUrl(phone)) {
                                            //dialer open
                                            await launchUrl(phone);
                                          } else {
                                            //dialer is not open
                                            print('cant launch');
                                          }
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: MyColors.myBlue2,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: const [
                                                //bottom right dark
                                                BoxShadow(
                                                  color: MyColors.myBlue,
                                                  offset: Offset(5, 5),
                                                  blurRadius: 15,
                                                  spreadRadius: 1,
                                                ),
                                                //top left light
                                                BoxShadow(
                                                  color: MyColors.myBlue2,
                                                  offset: Offset(-2, -1),
                                                  blurRadius: 5,
                                                  spreadRadius: 0.5,
                                                ),
                                              ]),
                                          child: Center(
                                            child: Text(
                                              'Call',
                                              style: GoogleFonts.karla(
                                                color: MyColors.mywhite,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(
                left: 150,
              ),
              child: Container(
                child: CachedNetworkImage(
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                    color: MyColors.mywhite,
                  )),
                  imageUrl: car.img!,
                ),
              )),
        ],
      ),
    );
  }
}
