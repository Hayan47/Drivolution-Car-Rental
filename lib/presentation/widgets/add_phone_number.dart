import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPhoneNumber extends StatelessWidget {
  final String id;
  AddPhoneNumber({super.key, required this.id});

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserInitial) {
          Navigator.pop(context);
          showToastMessage(
            context,
            'Phone Number added successfully',
            const Icon(Icons.done, color: AppColors.successGreen, size: 18),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: AppColors.coralRed,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 25),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          content: SizedBox(
            height: 120,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    'Add Your Number',
                    style: AppTypography.h4.copyWith(
                      color: AppColors.pureWhite,
                      fontSize: 19,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.deepNavy,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.pureWhite,
                        ),
                        controller: _phoneController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.length < 10) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone Number...',
                          hintStyle: AppTypography.labelLarge.copyWith(
                            color: AppColors.pureWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 15),
              child: GestureDetector(
                onTap: () async {
                  context.read<UserBloc>().add(
                        AddUserPhoneNumber(
                            phoneNumber: _phoneController.text, userID: id),
                      );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.deepNavy,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.charcoal,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      'submit',
                      style: AppTypography.h4.copyWith(
                        color: AppColors.pureWhite,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
