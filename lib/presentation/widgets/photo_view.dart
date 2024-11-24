import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatelessWidget {
  final List<String> imagesUrl;
  final int imagesCount;

  const PhotoViewPage({
    super.key,
    required this.imagesUrl,
    required this.imagesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.jetBlack,
      appBar: AppBar(backgroundColor: AppColors.jetBlack),
      body: PhotoViewGallery.builder(
        backgroundDecoration: const BoxDecoration(color: AppColors.jetBlack),
        itemCount: imagesCount,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(imagesUrl[index]),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.8,
            initialScale: PhotoViewComputedScale.contained,
          );
        },
      ),
    );
  }
}
