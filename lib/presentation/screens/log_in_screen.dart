import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../themes/app_typography.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool hidePassword = true;

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final formKey2 = GlobalKey<FormState>();

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
            } else if (state is UserLoaded) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'mainscreen',
                (Route<dynamic> route) => false,
              );
              showToastMessage(
                context,
                'welcome back  ${state.userInfo.firstName}',
                const Icon(Icons.done, color: AppColors.successGreen, size: 18),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                //?app bar
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: AppColors.coralRed),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          //?main column
                          child: Form(
                            key: formKey2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    //!first message
                                    Text(
                                      'Hello Again!',
                                      style: AppTypography.labelLarge.copyWith(
                                        color: AppColors.coralRed,
                                        fontSize: 38,
                                      ),
                                    ),

                                    const SizedBox(height: 10),
                                    //!second message
                                    Text(
                                      'welcome back, you have been missed!',
                                      style: AppTypography.labelLarge.copyWith(
                                        color: AppColors.coralRed,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    //!email TextField
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
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              style: AppTypography.labelLarge
                                                  .copyWith(
                                                color: AppColors.pureWhite,
                                              ),
                                              controller: _emailcontroller,
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
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Email...',
                                                hintStyle: AppTypography
                                                    .labelLarge
                                                    .copyWith(
                                                  color: AppColors.pureWhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    //!password TextField
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
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: hidePassword,
                                              style: AppTypography.labelLarge
                                                  .copyWith(
                                                color: AppColors.pureWhite,
                                              ),
                                              controller: _passwordcontroller,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.length < 8) {
                                                  return 'password is short';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        hidePassword =
                                                            !hidePassword;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      hidePassword
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color:
                                                          AppColors.pureWhite,
                                                    )),
                                                border: InputBorder.none,
                                                hintText: 'Password...',
                                                hintStyle: AppTypography
                                                    .labelLarge
                                                    .copyWith(
                                                  color: AppColors.pureWhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    //!forget password
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () => Navigator.pushNamed(
                                                context,
                                                'forgetpasswordscreen'),
                                            child: Text(
                                              'Forget password?',
                                              style: AppTypography.labelLarge
                                                  .copyWith(
                                                color: AppColors.coralRed,
                                                fontSize: 14,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    //!login Button
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                child: TextButton(
                                                  onPressed: () async {
                                                    final isValid = formKey2
                                                        .currentState!
                                                        .validate();
                                                    if (!isValid) return;
                                                    context
                                                        .read<UserBloc>()
                                                        .add(SignIn(
                                                            email:
                                                                _emailcontroller
                                                                    .text,
                                                            password:
                                                                _passwordcontroller
                                                                    .text));
                                                  },
                                                  style: ButtonStyle(
                                                    shape: MaterialStateProperty
                                                        .all(RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10))),
                                                    fixedSize:
                                                        MaterialStateProperty
                                                            .all(const Size(
                                                                70, 40)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      AppColors.coralRed,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'log in',
                                                    style: AppTypography.h4
                                                        .copyWith(
                                                      color:
                                                          AppColors.pureWhite,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Text(
                                        'or continue with',
                                        style: AppTypography.h4.copyWith(
                                          color: AppColors.coralRed,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        context
                                            .read<UserBloc>()
                                            .add(SignInWithGoogle());
                                      },
                                      child: SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: Image.asset(
                                          'assets/img/logo/google.png',
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //!sign up message
                                    Text(
                                      'ain\'t member yet?',
                                      style: AppTypography.labelLarge.copyWith(
                                        color: AppColors.coralRed,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, 'signupscreen'),
                                      child: Text(
                                        'Sign Up',
                                        style: AppTypography.h4.copyWith(
                                          color: AppColors.coralRed,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
