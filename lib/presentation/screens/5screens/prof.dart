import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/image_bloc/image_bloc.dart';
import 'package:drivolution/logic/upload_bloc/upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../profile_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ImageBloc()),
              BlocProvider(create: (context) => UploadBloc()),
            ],
            child: const ProfileDetailsScreen(),
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.4,
                    child: Lottie.asset('assets/lottie/register.zip'),
                  ),
                  Text(
                    'Make Your Account Now!',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyColors.myBlue,
                          fontSize: 26,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushNamed(context, 'loginscreen');
                  },
                  backgroundColor: MyColors.myBlue,
                  label: const Text("log in"),
                ),
              ),
            ],
          );
        }
      },
    );
    // Column(
    //   children: [
    //     StreamBuilder<User?>(
    //       stream: FirebaseAuth.instance.authStateChanges(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const Center(
    //               child: CircularProgressIndicator(
    //             color: MyColors.mywhite,
    //           ));
    //         } else if (snapshot.hasError) {
    //           return const Center(child: Text('Something went wrong'));
    //         } else if (snapshot.hasData) {
    //           return const ProfileDetailsScreen();
    //           // Navigator.pushNamed(context, profiledetailsscreen);
    //           // return Container(); // or any other widget
    //         } else {
    //           return Expanded(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Column(
    //                   children: [
    //                     SizedBox(
    //                       height: MediaQuery.sizeOf(context).height * 0.4,
    //                       child: Lottie.asset('assets/lottie/register.zip'),
    //                     ),
    //                     Text(
    //                       'Make Your Account Now!',
    //                       style:
    //                           Theme.of(context).textTheme.bodySmall!.copyWith(
    //                                 color: MyColors.myBlue,
    //                                 fontSize: 26,
    //                               ),
    //                     ),
    //                   ],
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(bottom: 100),
    //                   child: FloatingActionButton.extended(
    //                     onPressed: () {
    //                       Navigator.pushNamed(context, 'loginscreen');
    //                     },
    //                     backgroundColor: MyColors.myBlue,
    //                     label: const Text("log in"),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         }
    //       },
    //     ),
    //   ],
    // );
  }
}
