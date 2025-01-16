import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/data/models/car_image_model.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'image_error_widget.dart';

class CarImagesWidget extends StatelessWidget {
  final _controller = PageController();
  final CarImage carImage;
  final List<CarImage> carImages;
  CarImagesWidget({super.key, required this.carImage, required this.carImages});

  @override
  Widget build(BuildContext context) {
    final filteredCarImages =
        carImages.where((image) => !image.isPrimary).toList();
    return Stack(
      children: [
        Hero(
          tag: carImage,
          child: PageView(
            controller: _controller,
            children: List.generate(
              filteredCarImages.length,
              (index) => GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'photoview',
                    arguments: filteredCarImages),
                child: CachedNetworkImage(
                  imageUrl: filteredCarImages[index].imageUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => ImageErrorBigWidget(),
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
            count: filteredCarImages.length,
            controller: _controller,
          ),
        ),
      ],
    );
  }
}
