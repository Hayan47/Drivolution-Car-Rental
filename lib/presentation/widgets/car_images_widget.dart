import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/widgets/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarImagesWidget extends StatelessWidget {
  final _controller = PageController();
  final String carImage;
  final List<String> carImages;
  CarImagesWidget({super.key, required this.carImage, required this.carImages});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: carImage,
          child: PageView(
            controller: _controller,
            children: List.generate(
              carImages.length,
              (index) => GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'photoview',
                    arguments: carImages),
                child: CachedNetworkImage(
                  imageUrl: carImages[index],
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
              activeDotColor: AppColors.deepNavy,
              dotColor: Colors.white,
              dotHeight: 5,
              dotWidth: 5,
            ),
            count: carImages.length,
            controller: _controller,
          ),
        ),
      ],
    );
  }
}
