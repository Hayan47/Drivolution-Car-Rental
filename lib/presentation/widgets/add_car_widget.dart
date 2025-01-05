import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:drivolution/utils/responsive/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCarWidget extends StatelessWidget {
  final int userid;
  const AddCarWidget({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/lottie/add_car.png',
          height: ResponsiveHelper.hp(context, 40),
        ),
        Text(
          'add your cars for others to rent!',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.oceanBlue,
            fontSize: 22,
          ),
        ),
        Spacer(),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: ResponsiveHelper.getScreenSize(context) ==
                          ScreenSize.small
                      ? 100
                      : 40),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (userState is UserLoaded) {
                    if (userState.userInfo.phoneNumber == '') {
                      showToastMessage(
                        context,
                        'You need to add your phone number first',
                        const Icon(Icons.error,
                            color: AppColors.coralRed, size: 18),
                      );
                    } else {
                      Navigator.pushNamed(context, 'addcarscreen');
                    }
                  } else {
                    context.read<UserBloc>().add(GetUserInfo());
                  }
                },
                backgroundColor: AppColors.oceanBlue,
                label: const Text("Add Car"),
              ),
            );
          },
        ),
      ],
    );
  }
}
