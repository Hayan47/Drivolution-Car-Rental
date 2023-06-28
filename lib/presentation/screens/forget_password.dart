import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _forgotpasswordcontroller = TextEditingController();
  final formKey3 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.myred),
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Form(
                key: formKey3,
                child: Column(
                  children: [
                    const Text(
                      'Enter Your Email',
                      style: TextStyle(
                        fontSize: 32,
                        color: MyColors.myred,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: _forgotpasswordcontroller,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null ||
                                    !EmailValidator.validate(value)) {
                                  return 'Enter a valid email';
                                }
                              },
                              style: const TextStyle(color: MyColors.mywhite),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email...',
                                hintStyle: TextStyle(color: MyColors.mywhite),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: OutlinedButton(
                            onPressed: () async {
                              final isValid = formKey3.currentState!.validate();
                              if (!isValid) return;
                              await Auth().resetPassword(
                                context,
                                _forgotpasswordcontroller.text.trim(),
                              );
                              // Get.snackbar(
                              //   '',
                              //   'reset password email sent',
                              //   snackPosition: SnackPosition.BOTTOM,
                              // );
                            },
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: MyColors.myred)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(140, 40)),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).secondaryHeaderColor)),
                            child: const Text(
                              'Reset Password',
                              style: TextStyle(color: MyColors.myred),
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
    );
  }
}
