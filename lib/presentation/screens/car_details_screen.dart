import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/logic/cubit/favorite_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/car_details.dart';

class CarDetailsScreen extends StatefulWidget {
  final Car car;

  const CarDetailsScreen({required this.car, super.key});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  final _controller = PageController();
  List<Car> favoritesCars = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myBlue2,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: MyColors.myBlue2,
            actions: [
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
                  : widget.car.ownerid == FirebaseAuth.instance.currentUser!.uid
                      ? Container()
                      : BlocBuilder<FavoriteCubit, FavoriteCarsState>(
                          builder: (context, state) {
                            if (state is FavoriteCarsLoaded) {
                              favoritesCars = (state).favoriteCars;
                              return Hero(
                                tag: widget.car.id!,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (state.favoriteCars
                                          .contains(widget.car)) {
                                        context
                                            .read<FavoriteCubit>()
                                            .removeCarFromFavorites(
                                                widget.car,
                                                FirebaseAuth
                                                    .instance.currentUser!.uid);
                                      } else {
                                        context
                                            .read<FavoriteCubit>()
                                            .addCarToFavorites(
                                                widget.car,
                                                FirebaseAuth
                                                    .instance.currentUser!.uid);
                                      }
                                    },
                                    child: (state.favoriteCars
                                            .contains(widget.car))
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
                              return Container();
                            }
                          },
                        )
            ],
            pinned: true,
            expandedHeight: 225,
            flexibleSpace: FlexibleSpaceBar(
              title: Hero(
                tag: widget.car.name,
                child: Text(
                  textAlign: TextAlign.center,
                  widget.car.name,
                  style: GoogleFonts.karla(),
                ),
              ),
              centerTitle: true,
              background: Stack(
                children: [
                  Hero(
                    tag: widget.car.img,
                    child: PageView(
                      controller: _controller,
                      children: List.generate(
                        widget.car.images.length,
                        (index) => CachedNetworkImage(
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(
                              color: MyColors.mywhite,
                            ),
                          ),
                          imageUrl: widget.car.images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: const Alignment(0, 0.95),
                    child: SmoothPageIndicator(
                      effect: const ExpandingDotsEffect(
                        activeDotColor: MyColors.myBlue2,
                        dotColor: Colors.white,
                        dotHeight: 5,
                        dotWidth: 5,
                      ),
                      count: widget.car.images.length,
                      controller: _controller,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //sliver items
          SliverToBoxAdapter(
            child: CarDetails(car: widget.car),
          ),
        ],
      ),
    );
  }
}
