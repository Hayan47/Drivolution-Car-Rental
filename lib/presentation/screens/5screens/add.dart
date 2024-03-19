import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/auth_cubit/auth_cubit.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is NotAuthenticated) {
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
        } else {
          return CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/lottie/add_car.png'),
                        Text(
                          'add your cars for others to rent!',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: MyColors.myBlue,
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 100),
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              if (userState is UserLoaded) {
                                if (userState.userInfo.phoneNumber == '') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    MySnackBar(
                                      icon: const Icon(Icons.error,
                                          color: MyColors.myred2, size: 18),
                                      message:
                                          'You need to add your phone number first',
                                      margin: 70,
                                    ),
                                  );
                                } else {
                                  Navigator.pushNamed(context, 'addcarscreen');
                                }
                              } else {
                                context.read<UserBloc>().add(GetUserInfo(
                                    userID: (state as Authenticated).user.uid));
                              }
                            },
                            backgroundColor: MyColors.myBlue,
                            label: const Text("Add Car"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
