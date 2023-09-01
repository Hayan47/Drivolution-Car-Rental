// ignore_for_file: use_build_context_synchronously

import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:drivolution/services/user_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool hidePassword = true;

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //?app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.myred),
      ),
      body: SafeArea(
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
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: MyColors.myred,
                                      fontSize: 38,
                                    ),
                          ),

                          const SizedBox(height: 10),
                          //!second message
                          Text(
                            'welcome back, you have been missed!',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: MyColors.myred2,
                                      fontSize: 18,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          //!email TextField
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Stack(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: MyColors.myred2,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: MyColors.mywhite,
                                        ),
                                    controller: _emailcontroller,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null ||
                                          !EmailValidator.validate(value)) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email...',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.mywhite,
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
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Stack(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: MyColors.myred2,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: hidePassword,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: MyColors.mywhite,
                                        ),
                                    controller: _passwordcontroller,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.length < 8) {
                                        return 'password is short';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              hidePassword = !hidePassword;
                                            });
                                          },
                                          icon: Icon(
                                            hidePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: MyColors.mywhite,
                                          )),
                                      border: InputBorder.none,
                                      hintText: 'Password...',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: MyColors.mywhite,
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
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, forgetpasswordscreen),
                                  child: Text(
                                    'Forget password?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: MyColors.myred2,
                                          fontSize: 14,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          //!login Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextButton(
                                  onPressed: () async {
                                    final isValid =
                                        formKey2.currentState!.validate();
                                    if (!isValid) return;
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                    await UserServices().signIn(
                                      context,
                                      _emailcontroller.text.trim(),
                                      _passwordcontroller.text.trim(),
                                    );
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    fixedSize: MaterialStateProperty.all(
                                        const Size(70, 40)),
                                    backgroundColor: MaterialStateProperty.all(
                                      MyColors.myred2,
                                    ),
                                  ),
                                  child: Text(
                                    'log in',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: MyColors.mywhite,
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              'or continue with',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: MyColors.myred2,
                                    fontSize: 14,
                                  ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await UserServices().signInWithGoogle(context);
                            },
                            child: Container(
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
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: MyColors.myred2,
                                    ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, signupscreen),
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: MyColors.myred,
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
    );
  }
}
