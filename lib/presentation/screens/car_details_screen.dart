import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/data/models/car_model.dart';
import 'package:drivolution/presentation/widgets/favorite_icon.dart';
import 'package:drivolution/presentation/widgets/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/car_details.dart';

class CarDetailsScreen extends StatelessWidget {
  final Car car;

  CarDetailsScreen({required this.car, super.key});

  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myBlue2,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: MyColors.myBlue2,
            // actions: [FavoriteIcon(car: car)],
            pinned: true,
            expandedHeight: 225,

            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(8),
              title: Hero(
                tag: car.name,
                child: Text(
                  textAlign: TextAlign.center,
                  car.name,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: MyColors.mywhite,
                        fontSize: 18,
                      ),
                ),
              ),
              centerTitle: true,
              background: Stack(
                children: [
                  Hero(
                    tag: car.img,
                    child: PageView(
                      controller: _controller,
                      children: List.generate(
                        car.images.length,
                        (index) => GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return PhotoViewPage(
                                  imagesUrl: car.images,
                                  imagesCount: car.images.length,
                                );
                              },
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: car.images[index],
                            fit: BoxFit.cover,
                          ),
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
                      count: car.images.length,
                      controller: _controller,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //sliver items
          SliverToBoxAdapter(
            child: CarDetails(car: car),
          ),
        ],
      ),
    );
  }
}
