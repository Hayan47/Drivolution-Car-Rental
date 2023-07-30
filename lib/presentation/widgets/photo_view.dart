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
    return AlertDialog(
      content: PhotoViewGallery.builder(
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        itemCount: imagesCount,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: AssetImage(imagesUrl[index]),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.8,
            initialScale: PhotoViewComputedScale.contained,
          );
        },
      ),
    );
  }
}
