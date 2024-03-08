// //?upload car album
//   uploadCarAlbum() async {

//     for (int i = 0; i < carImages.length; i++) {
//       final file = carImages[i];
//       final imageName = '${_carNameController.text}$i.jpg';
//       final ref = FirebaseStorage.instance
//           .ref()
//           .child('cars')
//           .child(id)
//           .child(_carNameController.text)
//           .child(imageName);
//       try {
//         ref
//             .putData(file)
//             .snapshotEvents
//             .listen((TaskSnapshot taskSnapshot) async {
//           switch (taskSnapshot.state) {
//             case TaskState.running:
//               final progress = 100.0 *
//                   (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
//               setState(() {
//                 percent = progress.toInt();
//               });
//               print("Upload $i is $progress% complete.");
//               break;
//             case TaskState.paused:
//               print("Upload is paused.");
//               break;
//             case TaskState.canceled:
//               print("Upload was canceled");
//               break;
//             case TaskState.error:
//               // Handle unsuccessful uploads
//               break;
//             case TaskState.success:
//               // print('finised');
//               // Handle successful uploads on complete
//               // ...
//               final imageUrl = await ref.getDownloadURL();
//               carImagesLinks.add(imageUrl);
//               print('Uploaded image $i: $imageUrl');
//               break;
//           }
//         });
//       } on FirebaseException {
//         showError('upload images failed');
//       }
//     }
//   }

// showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Center(
//         child: CircularPercentIndicator(
//           radius: 50,
//           lineWidth: 10,
//           backgroundColor: Colors.white,
//           percent: percent / 100,
//           progressColor: Colors.black,
//           center: Text('$percent %'),
//         ),
//       ),
//     );

import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: TextButton(
          onPressed: () {
            showToast(
              'Toast Message',
              context: context,
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: MyColors.mywhite,
                  ),
              textPadding: const EdgeInsets.all(23),
              // fullWidth: true,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: MyColors.myBlue2,
              animation: StyledToastAnimation.fade,
              // alignment: Alignment.bottomCenter
              // position: StyledToastPosition.top,
            );

            // ScaffoldMessenger.of(context).showMaterialBanner(
            //   MaterialBanner(
            //     backgroundColor: Colors.red,

            //     content: Text('Content'),
            //     actions: [
            //       Text("action1"),
            //       Text("action2"),
            //     ],
            //   ),
            // );
          },
          child: Text("Show Toast"),
        ),
      ),
    );
  }
}
