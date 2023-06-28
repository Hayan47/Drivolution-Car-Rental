import 'package:drivolution/business-logic/cubit/usr_cubit.dart';
import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:drivolution/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../profile_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myred3,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else if (snapshot.hasData) {
            // final user = FirebaseAuth.instance.currentUser!;
            // print("BBBBBBBBBBBBBBBBBBBBBBBBBB" + user.uid);
            // Auth().getUserInfo(user.uid);
            // print("AAAAAAAAAAAAAAAAAAAAAAAAAA" + user.toString());
            // Container();
            return BlocProvider.value(
              value: UsrCubit(),
              child: const ProfileDetailsScreen(),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Make Your Account Now!',
                  style: GoogleFonts.karla(
                    color: MyColors.myred2,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Lottie.asset('assets/lottie/register.zip'),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, loginscreen),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(MyColors.myred),
                      fixedSize:
                          MaterialStateProperty.all(const Size(100, 20))),
                  child: const Text('LogIn'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
