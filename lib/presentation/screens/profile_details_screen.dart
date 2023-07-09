// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivolution/logic/cubit/usr_cubit.dart';
import 'package:drivolution/data/models/usr_model.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:drivolution/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/my_colors.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  Usr usr = Usr();
  Uint8List? _image;
  @override
  void initState() {
    super.initState();
    context.read<UsrCubit>().getUserInfo(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<UsrCubit, UsrState>(
              builder: (context, state) {
                if (state is UsrLoaded) {
                  usr = (state).userInfo;
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            MyColors.myred.withOpacity(1),
                            MyColors.myred2.withOpacity(0.5),
                            MyColors.myBlue2.withOpacity(1),
                          ]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipOval(
                                child: Material(
                                  color: MyColors.myred2,
                                  child: GestureDetector(
                                    onTap: () async {
                                      try {
                                        XFile? image = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        if (image == null) return;
                                        final imageTemporary =
                                            await image.readAsBytes();
                                        setState(() {
                                          _image = imageTemporary;
                                        });
                                        final path =
                                            'profile pictures/${user.email}';
                                        final ref = FirebaseStorage.instance
                                            .ref()
                                            .child(path);
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                        await ref.putData(_image!);
                                        Navigator.pop(context);
                                        final url = await ref.getDownloadURL();
                                        await Auth()
                                            .addImage(context, url, user.uid);
                                        await context
                                            .read<UsrCubit>()
                                            .getUserInfo(user.uid);
                                        //!usrController.getUserInfo();
                                      } on PlatformException {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(MySnackBar(
                                          icon: const Icon(
                                            Icons.error,
                                            color: MyColors.myred,
                                            size: 20,
                                          ),
                                          title: 'Error',
                                          message: 'failed to pick image',
                                        ));
                                      }
                                    },
                                    child: SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: (usr.img != null || _image != null)
                                          ? CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                color: MyColors.mywhite,
                                              )),
                                              imageUrl: usr.img!,
                                              fit: BoxFit.cover,
                                            )
                                          : CachedNetworkImage(
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                color: MyColors.mywhite,
                                              )),
                                              imageUrl:
                                                  'https://i.imgur.com/sWmIhUZ.png',
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                    color: Colors.blue,
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 20),
                          RichText(
                            text: TextSpan(
                                style: GoogleFonts.karla(
                                  color: MyColors.myred2,
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: usr.firstName,
                                  ),
                                  const TextSpan(text: '\n \t'),
                                  TextSpan(
                                    text: usr.lastName,
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator(
                    color: Colors.black,
                  );
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.black,
              ),
            ),
            // Text(usrController.currentuser.uid.toString()),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(MyColors.myred),
                  fixedSize: MaterialStateProperty.all(const Size(100, 20))),
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
