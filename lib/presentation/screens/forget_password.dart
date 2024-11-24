import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final _forgotpasswordcontroller = TextEditingController();
  final formKey3 = GlobalKey<FormState>();
  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.charcoal,
              AppColors.twilightBlue,
              AppColors.charcoal,
            ],
          ),
        ),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              showToastMessage(
                context,
                state.errorMessage,
                const Icon(Icons.error, color: AppColors.alertRed, size: 18),
              );
            } else if (state is UserInitial) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'mainscreen',
                (Route<dynamic> route) => false,
              );
              showToastMessage(
                context,
                'Reset Password link has been sent to your email',
                const Icon(Icons.done, color: AppColors.successGreen, size: 18),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: AppColors.blazingRed),
                ),
                Expanded(
                  child: CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Form(
                            key: formKey3,
                            child: Column(
                              children: [
                                Text(
                                  'Enter Your Email',
                                  style: AppTypography.labelLarge.copyWith(
                                    color: AppColors.coralRed,
                                    fontSize: 32,
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: AppColors.coralRed,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextFormField(
                                          controller: _forgotpasswordcontroller,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value == null ||
                                                !EmailValidator.validate(
                                                    value)) {
                                              return 'Enter a valid email';
                                            }
                                            return null;
                                          },
                                          style:
                                              AppTypography.labelLarge.copyWith(
                                            color: AppColors.pureWhite,
                                            fontSize: 16,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Email...',
                                            hintStyle: TextStyle(
                                                color: AppColors.pureWhite),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                state is UserLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            height: 40,
                                            child: Lottie.asset(
                                                'assets/lottie/SplashyLoader.json'),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: GestureDetector(
                                              onTap: () async {
                                                final isValid = formKey3
                                                    .currentState!
                                                    .validate();
                                                if (!isValid) return;
                                                context.read<UserBloc>().add(
                                                      ResetPassword(
                                                        email:
                                                            _forgotpasswordcontroller
                                                                .text
                                                                .trim(),
                                                      ),
                                                    );
                                              },
                                              child: Container(
                                                width: 140,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: AppColors.coralRed,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Reset Password',
                                                    style: AppTypography.h4
                                                        .copyWith(
                                                      color: AppColors.coralRed,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
