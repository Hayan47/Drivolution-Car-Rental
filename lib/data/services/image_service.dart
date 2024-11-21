import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image/image.dart' as IMG;

class ImageService {
  final FirebaseStorage firebaseStorage;

  ImageService({required this.firebaseStorage});

  //? remove img background
  Future<Uint8List> removeBackground(Uint8List imageFile) async {
    final response = await http.post(
      Uri.parse('https://api.remove.bg/v1.0/removebg'),
      headers: {
        'X-Api-Key': dotenv.env['REMOVE_BG_API_KEY'].toString(),
      },
      body: {
        'image_file_b64': base64.encode(imageFile),
      },
    );
    Uint8List imageBytes = response.bodyBytes;
    return imageBytes;
  }

  //?upload Image
  Future<List<String>> uploadImages({
    required List<Uint8List> images,
    required String path,
  }) async {
    final uploadedUrls = <String>[];
    for (int i = 0; i < images.length; i++) {
      // final String imageName = imagesName + i.toString();
      final ref = firebaseStorage.ref().child('$path$i');

      final uploadTask = ref.putData(images[i]);
      // Calculate progress
      // final progress = (uploadTask.snapshot.bytesTransferred /
      //         uploadTask.snapshot.totalBytes *
      //         100)
      //     .toInt();

      // Trigger event with updated progress and uploaded URLs
      // context.read<UploadBloc>().add(UploadProgressEvent(progress: progress, uploadedUrls: uploadedUrls));

      final url = await (await uploadTask).ref.getDownloadURL();
      uploadedUrls.add(url);
    }
    return uploadedUrls;
    // .snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
    //   switch (taskSnapshot.state) {
    //     case TaskState.running:
    //       final progress =
    //           100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
    //       print("Upload $i is $progress% complete.");
    //       break;
    //     case TaskState.paused:
    //       print("Upload is paused.");
    //       break;
    //     case TaskState.canceled:
    //       print("Upload was canceled");
    //       break;
    //     case TaskState.error:
    //       break;
    //     case TaskState.success:
    //       final imageUrl = ref.getDownloadURL();
    //       print('Uploaded image $i: $imageUrl');
    //   }
    // });
  }

  //? compress img
  Uint8List compressImage(
      Uint8List imageBytes, int targetWidth, int targetHeight) {
    // Decode the image
    img.Image? image = img.decodeImage(imageBytes);
    // Resize the image
    img.Image resizedImage =
        img.copyResize(image!, width: targetWidth, height: targetHeight);
    // Compress the image and return it as a Uint8List
    return img.encodeJpg(resizedImage, quality: 50);
  }

  //? resize image
  Uint8List? resizeImage(Uint8List data, width, height) {
    Uint8List? resizedData = data;
    IMG.Image? img = IMG.decodeImage(data);
    IMG.Image resized = IMG.copyResize(img!, width: width, height: height);
    resizedData = Uint8List.fromList(IMG.encodePng(resized));
    return resizedData;
  }

  //? featch Logos
  Future<List<String>> fetchCarLogos() async {
    List<String> photoUrls = [];
    try {
      Reference directoryRef =
          firebaseStorage.ref().child('myfiles').child('logos');

      ListResult result = await directoryRef.listAll();

      for (Reference ref in result.items) {
        String imageUrl = await ref.getDownloadURL();
        photoUrls.add(imageUrl);
      }
      return photoUrls;
    } catch (e) {
      return [];
    }
  }
}
