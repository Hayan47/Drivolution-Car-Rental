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
    return
        // Scaffold(
        //   extendBodyBehindAppBar: true,
        //   appBar: AppBar(
        //     iconTheme: const IconThemeData(color: Colors.white),
        //     elevation: 0,
        //     backgroundColor: Colors.transparent,
        //   ),
        //   body:
        AlertDialog(
      content: PhotoViewGallery.builder(
        backgroundDecoration: BoxDecoration(color: Colors.black),
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
      //),
    );
  }
}
