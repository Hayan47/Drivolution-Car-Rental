import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/album_bloc/album_bloc.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCar4 extends StatelessWidget {
  const AddCar4({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'pick an album',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: MyColors.mywhite,
              ),
        ),
        const SizedBox(height: 15),
        GestureDetector(
          onLongPress: () => context.read<AlbumBloc>().add(RemoveAlbumEvent()),
          onTap: () => context.read<AlbumBloc>().add(AddAlbumEvent()),
          child: BlocConsumer<AlbumBloc, AlbumState>(
            listener: (context, state) {
              if (state is AlbumError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  MySnackBar(
                    icon: const Icon(Icons.error,
                        color: MyColors.myred2, size: 18),
                    message: state.errorMessage,
                    margin: 5,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AlbumChanged) {
                return GridView.count(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  crossAxisCount: 3,
                  children: List.generate(
                    state.images.length,
                    (index) => Card(
                      child: Image.memory(state.images[index]),
                    ),
                  ),
                );
              } else if (state is AlbumLoading) {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: MyColors.myred,
                    ),
                  ),
                );
              } else {
                return GridView.count(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  crossAxisCount: 3,
                  children: List.generate(
                    9,
                    (index) => Card(
                      child: Image.asset('assets/img/cars/carholder2.jpg'),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 15),
        ///////////////////////////////////!///////////////////////
        // loadin?
        // Center(
        //   child: CircularPercentIndicator(
        //     radius: 40,
        //     lineWidth: 7,
        //     backgroundColor: MyColors.myBlue2,
        //     percent: percent / 100,
        //     progressColor: MyColors.myred,
        //     curve: Curves.bounceIn,
        //     center: Text(
        //       '$percent %',
        //       style: const TextStyle(
        //           color: Colors.white, fontSize: 10),
        //     ),
        //   ),
        // ),
        // Center(
        //   child: LinearPercentIndicator(
        //     backgroundColor: MyColors.mywhite,
        //     lineHeight: 7,
        //     percent: percent / 100,
        //     progressColor: MyColors.myred,
        //     curve: Curves.bounceIn,
        //     center: Text(
        //       '$percent %',
        //       style: const TextStyle(color: Colors.white, fontSize: 10),
        //     ),
        //   ),
        // ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(
        //       'uploading image ', // $imageNum',
        //       style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //             color: MyColors.mywhite,
        //             fontSize: 16,
        //           ),
        //     ),
        //     const SizedBox(width: 5),
        //     const SizedBox(
        //       width: 12,
        //       height: 12,
        //       child: CircularProgressIndicator(
        //         color: MyColors.mywhite,
        //         strokeWidth: 2,
        //       ),
        //     ),
        //   ],
        // ),
        // :
        // Center(
        //   child: TextButton(
        //       onPressed: () async {
        //         setState(() {
        //           loading = true;
        //         });
        //         //*upload main image
        //         // await uploadImage(
        //         //     carImage!,
        //         //     '${_carNameController.text}_main_image.jpg',
        //         //     0);
        //         //*upload images
        //         for (int i = 0; i < carImages.length; i++) {
        //           await _imageService.uploadImage(
        //             file: carImages[i],
        //             folderName: _carNameController.text,
        //             imageName:
        //                 '${_carNameController.text}$i.jpg',
        //             id: id,
        //             i: i + 2,
        //             context: context,
        //           );
        //         }
        //         // setState(() {
        //         //   loading = false;
        //         // });
        //       },
        //       child: Text('TEST')),
        // ),

        //////////////////////////////////////////////////////////
        //!submit
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              // onPressed: addCar,
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors.myred),
                fixedSize: MaterialStateProperty.all(
                  const Size(100, 20),
                ),
              ),
              child: Text(
                'Submit',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: MyColors.mywhite,
                      fontSize: 18,
                    ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
