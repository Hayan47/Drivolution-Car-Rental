import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:drivolution/logic/cubit/favorite_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/car_model.dart';

class CarCard extends StatefulWidget {
  final Car car;

  const CarCard({required this.car, super.key});

  @override
  State<CarCard> createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  List<Car> favoritesCars = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, cardetailsscreen, arguments: widget.car);
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 25,
              left: 15,
              bottom: 40,
              top: 10,
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
                        sigmaX: 500,
                        sigmaY: 500,
                      ),
                      child: Container(
                          // color: Colors.black.withOpacity(0.3),
                          ),
                    ),

                    // gradiant effect

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            // MyColors.myred.withOpacity(0.6),
                            // MyColors.myred.withOpacity(0.6),
                            // MyColors.myred2.withOpacity(0.2),
                            MyColors.myBlue2.withOpacity(0.3),
                            MyColors.myBlue.withOpacity(0.7),
                            MyColors.myBlue2.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),

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
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Hero(
                                            tag: widget.car.name,
                                            child: Text(
                                              '${widget.car.name} ${widget.car.model}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: false,
                                              style: GoogleFonts.karla(
                                                decoration: TextDecoration.none,
                                                color: MyColors.mywhite,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Hero(
                                tag: widget.car.logo,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                    color: MyColors.mywhite,
                                  )),
                                  imageUrl: widget.car.logo,
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            ],
                          ),
                          FirebaseAuth.instance.currentUser == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/icons/love2.png',
                                    width: 30,
                                    height: 30,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              : widget.car.ownerid ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? Container()
                                  : BlocBuilder<FavoriteCubit,
                                      FavoriteCarsState>(
                                      builder: (context, state) {
                                        if (state is FavoriteCarsLoaded) {
                                          favoritesCars = (state).favoriteCars;
                                          return Hero(
                                            tag: widget.car.id!,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (state.favoriteCars
                                                      .contains(widget.car)) {
                                                    context
                                                        .read<FavoriteCubit>()
                                                        .removeCarFromFavorites(
                                                            widget.car,
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid);
                                                  } else {
                                                    context
                                                        .read<FavoriteCubit>()
                                                        .addCarToFavorites(
                                                            widget.car,
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid);
                                                  }
                                                },
                                                child: state.favoriteCars
                                                        .contains(widget.car)
                                                    ? Image.asset(
                                                        'assets/icons/love2.png',
                                                        width: 30,
                                                        height: 30,
                                                      )
                                                    : Image.asset(
                                                        'assets/icons/love.png',
                                                        width: 30,
                                                        height: 30,
                                                        color: Colors.white,
                                                      ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      },
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
            left: MediaQuery.sizeOf(context).width / 3,
            top: 100,
            child: Container(
              height: 120,
              width: 250,
              // color: Colors.white,
              child: Hero(
                tag: widget.car.img,
                child: CachedNetworkImage(
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: MyColors.mywhite,
                    ),
                  ),
                  imageUrl: widget.car.img,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          //!price
          Positioned(
            left: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              width: 125,
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
                    '${widget.car.rent}\$',
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
          ),
        ],
      ),
    );
  }
}
