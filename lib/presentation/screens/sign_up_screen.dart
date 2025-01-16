import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:drivolution/utils/responsive/screen_size.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../widgets/dropdown.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  int dropDownValue = 19;

  var ages = List<int>.generate(100, (i) => i + 1);

  @override
  void dispose() {
    _firstnamecontroller.dispose();
    _lastnamecontroller.dispose();
    _phonecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.backgroundGradient,
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
                  'welcome ${state.userInfo.firstName}',
                  const Icon(Icons.done,
                      color: AppColors.successGreen, size: 18),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: AppColors.pureWhite,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      //!first message
                                      'Join Us',
                                      style: AppTypography.labelLarge.copyWith(
                                        color: AppColors.coralRed,
                                        fontSize: 38,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      //!second message
                                      'Sign up and explore',
                                      style: AppTypography.labelLarge.copyWith(
                                        color: AppColors.coralRed,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        //!first name TextField
                                        Stack(
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                maxWidth:
                                                ResponsiveHelper.isPortrait(
                                                    context)
                                                    ? ResponsiveHelper.wp(
                                                    context, 35)
                                                    : 238,
                                              ),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: AppColors.coralRed,
                                                borderRadius:
                                                BorderRadius.circular(12),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: ResponsiveHelper
                                                      .isPortrait(context)
                                                      ? ResponsiveHelper.wp(
                                                      context, 30)
                                                      : 218,
                                                ),
                                                child: TextFormField(
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                  _firstnamecontroller,
                                                  autovalidateMode:
                                                  AutovalidateMode
                                                      .onUserInteraction,
                                                  validator: (value) {
                                                    if (value == '') {
                                                      return 'Enter a name';
                                                    }
                                                    return null;
                                                  },
                                                  style: AppTypography
                                                      .labelLarge
                                                      .copyWith(
                                                    color: AppColors.pureWhite,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'First Name',
                                                    helperText: '',
                                                    hintStyle: AppTypography
                                                        .labelLarge
                                                        .copyWith(
                                                      color:
                                                      AppColors.pureWhite,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 25),
                                        //!last name TextField
                                        Stack(
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                maxWidth:
                                                ResponsiveHelper.isPortrait(
                                                    context)
                                                    ? ResponsiveHelper.wp(
                                                    context, 35)
                                                    : 238,
                                              ),
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: AppColors.coralRed,
                                                borderRadius:
                                                BorderRadius.circular(12),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: ResponsiveHelper
                                                      .isPortrait(context)
                                                      ? ResponsiveHelper.wp(
                                                      context, 30)
                                                      : 218,
                                                ),
                                                child: TextFormField(
                                                  textInputAction:
                                                  TextInputAction.next,
                                                  textAlign: TextAlign.center,
                                                  controller:
                                                  _lastnamecontroller,
                                                  style: AppTypography
                                                      .labelLarge
                                                      .copyWith(
                                                    color: AppColors.pureWhite,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Last Name',
                                                    helperText: '',
                                                    hintStyle: AppTypography
                                                        .labelLarge
                                                        .copyWith(
                                                      color:
                                                      AppColors.pureWhite,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    //!Phone TextField
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 50,
                                            constraints: BoxConstraints(
                                              maxWidth: 520,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.coralRed,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 500,
                                              ),
                                              child: TextFormField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.phone,
                                                controller: _phonecontroller,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.length < 10) {
                                                    return 'Enter a valid phone number';
                                                  }
                                                  return null;
                                                },
                                                style: AppTypography.labelLarge
                                                    .copyWith(
                                                  color: AppColors.pureWhite,
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Phone Number...',
                                                  hintStyle: AppTypography
                                                      .labelLarge
                                                      .copyWith(
                                                    color: AppColors.pureWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    //!Email TextField
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 50,
                                            constraints: BoxConstraints(
                                              maxWidth: 520,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.coralRed,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 500,
                                              ),
                                              child: TextFormField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: _emailcontroller,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  if (value == null ||
                                                      !EmailValidator.validate(
                                                          value)) {
                                                    return 'Enter a valid email';
                                                  }
                                                  return null;
                                                },
                                                style: AppTypography.labelLarge
                                                    .copyWith(
                                                  color: AppColors.pureWhite,
                                                ),
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
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    //!Password TextField
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 50,
                                            constraints: BoxConstraints(
                                              maxWidth: 520,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.coralRed,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 500,
                                              ),
                                              child: TextFormField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                controller: _passwordcontroller,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.length < 8) {
                                                    return 'password should be 6 chrachters or more';
                                                  }
                                                  return null;
                                                },
                                                style: AppTypography.labelLarge
                                                    .copyWith(
                                                  color: AppColors.pureWhite,
                                                ),
                                                obscureText: hidePassword,
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
                                                    ),
                                                  ),
                                                  border: InputBorder.none,
                                                  hintText: 'password...',
                                                  hintStyle: AppTypography
                                                      .labelLarge
                                                      .copyWith(
                                                    color: AppColors.pureWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    //!Confirm Password TextField
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 50,
                                            constraints: BoxConstraints(
                                              maxWidth: 520,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.coralRed,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                maxWidth: 500,
                                              ),
                                              child: TextFormField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                controller:
                                                    _confirmpasswordcontroller,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                validator: (value) {
                                                  if (value !=
                                                      _passwordcontroller
                                                          .text) {
                                                    return 'passwords not matching';
                                                  }
                                                  return null;
                                                },
                                                style: AppTypography.labelLarge
                                                    .copyWith(
                                                  color: AppColors.pureWhite,
                                                ),
                                                obscureText: hidePassword,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'confirm password...',
                                                  hintStyle: AppTypography
                                                      .labelLarge
                                                      .copyWith(
                                                    color: AppColors.pureWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),

                                    //!Signup Button
                                    state is UserLoading
                                        ? Row(
                                            mainAxisAlignment:
                                                ResponsiveHelper.getScreenSize(
                                                            context) ==
                                                        ScreenSize.small
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.center,
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
                                                ResponsiveHelper.getScreenSize(
                                                            context) ==
                                                        ScreenSize.small
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40),
                                                child: TextButton(
                                                  onPressed: () async {
                                                    final isValid = formKey
                                                        .currentState!
                                                        .validate();
                                                    if (!isValid) return;

                                                    context
                                                        .read<UserBloc>()
                                                        .add(SignUp(
                                                          email:
                                                              _emailcontroller
                                                                  .text
                                                                  .trim(),
                                                          password:
                                                              _passwordcontroller
                                                                  .text
                                                                  .trim(),
                                                          firstName:
                                                              _firstnamecontroller
                                                                  .text
                                                                  .trim(),
                                                          lastName:
                                                              _lastnamecontroller
                                                                  .text
                                                                  .trim(),
                                                          phoneNumber:
                                                              _phonecontroller
                                                                  .text
                                                                  .trim(),
                                                          age: dropDownValue,
                                                        ));
                                                  },
                                                  style: ButtonStyle(
                                                      shape: WidgetStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                      fixedSize:
                                                          WidgetStateProperty.all(
                                                              const Size(
                                                                  70, 40)),
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all(AppColors
                                                                  .coralRed)),
                                                  child: Text(
                                                    'Sign Up',
                                                    style: AppTypography.h4
                                                        .copyWith(
                                                      color:
                                                          AppColors.pureWhite,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    //!Last Message
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Any proplem?',
                                          style:
                                              AppTypography.labelLarge.copyWith(
                                            color: AppColors.coralRed,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          child: Text(
                                            'Contact Us',
                                            style: AppTypography.h4.copyWith(
                                              color: AppColors.coralRed,
                                              fontSize: 18,
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
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
