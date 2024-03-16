import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/image_bloc/image_bloc.dart';
import 'package:drivolution/logic/upload_bloc/upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../profile_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                  AppBar(
                    title: Row(
                      children: [
                        SizedBox(width: MediaQuery.sizeOf(context).width / 8),
                        Image.asset(
                          'assets/img/logo/drivolution.png',
                          width: MediaQuery.sizeOf(context).width / 2,
                        ),
                      ],
                    ),
                  ),
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
  }
}
