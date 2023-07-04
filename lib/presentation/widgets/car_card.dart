import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/car_model.dart';

class CarCard extends StatelessWidget {
  final Car car;

  const CarCard({required this.car, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, cardetailsscreen, arguments: car);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 25,
              left: 15,
              bottom: 50,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: double.infinity,
                height: 180,
                child: Stack(
                  children: [
                    //blur effect

                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 50,
                        sigmaY: 50,
                      ),
                      child: Container(),
                    ),

                    //gradiant effect

                    // Container(
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //         begin: Alignment.topLeft,
                    //         end: Alignment.bottomRight,
                    //         colors: [
                    //           MyColors.myred.withOpacity(1),
                    //           MyColors.myred2.withOpacity(1),
                    //           MyColors.myBlue.withOpacity(1),
                    //           MyColors.myBlue2.withOpacity(1),
                    //         ]),
                    //   ),
                    // ),

                    //!child

                    Padding(
                      padding: const EdgeInsets.all(15),
                      //?main colimn

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Hero(
                                        tag: car.name,
                                        child: Text(
                                          '${car.name} ${car.model}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          softWrap: false,
                                          style: GoogleFonts.karla(
                                              decoration: TextDecoration.none,
                                              color: MyColors.mywhite,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Hero(
                                tag: car.logo,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                    color: MyColors.mywhite,
                                  )),
                                  imageUrl: car.logo,
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            ],
                          ),
                          //price
                          Container(
                            padding: const EdgeInsets.all(6),
                            width: 125,
                            decoration: BoxDecoration(
                              color: MyColors.myred.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
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
                                  '${car.rent}\$',
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
                          Hero(
                            // tag: car.id!,
                            tag: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/icons/love.png',
                                width: 30,
                                height: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            height: 225,
            width: 250,
            left: MediaQuery.sizeOf(context).width / 3,
            top: 30,
            child: Hero(
              tag: car.img,
              child: CachedNetworkImage(
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                  color: MyColors.mywhite,
                )),
                imageUrl: car.img,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
