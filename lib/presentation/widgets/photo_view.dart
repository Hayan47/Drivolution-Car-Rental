import 'package:cached_network_image/cached_network_image.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: PhotoViewGallery.builder(
        backgroundDecoration: const BoxDecoration(color: Colors.black),
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
