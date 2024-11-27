import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/add_phone_number.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNameAndPhone extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String uid;
  const UserNameAndPhone({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            '$firstName $lastName',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.pureWhite,
              fontSize: ResponsiveHelper.sp(context, 10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              const Icon(
                Icons.call,
                size: 12,
                color: AppColors.successGreen,
              ),
              const SizedBox(width: 5),
              phoneNumber == ""
                  ? GestureDetector(
                      onTap: () {
                        showDialog(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (_) {
                            return BlocProvider.value(
                              value: BlocProvider.of<UserBloc>(context),
                              child: AddPhoneNumber(id: uid),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Add Phone Number',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.pureWhite,
                          fontSize: ResponsiveHelper.sp(context, 7),
                        ),
                      ),
                    )
                  : Text(
                      phoneNumber,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.pureWhite,
                        fontSize: ResponsiveHelper.sp(context, 7),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
