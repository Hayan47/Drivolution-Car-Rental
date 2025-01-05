import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/data/models/car_image_model.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatelessWidget {
  final List<CarImage> images;

  const PhotoViewPage({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.jetBlack,
        // appBar: AppBar(backgroundColor: AppColors.jetBlack),
        body: Stack(
          children: [
            PhotoViewGallery.builder(
              backgroundDecoration:
                  const BoxDecoration(color: AppColors.jetBlack),
              itemCount: images.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider:
                      CachedNetworkImageProvider(images[index].imageUrl),
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 1.8,
                  initialScale: PhotoViewComputedScale.contained,
                );
              },
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.pureWhite,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
