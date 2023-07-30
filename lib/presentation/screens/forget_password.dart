// ignore_for_file: use_build_context_synchronously

import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:drivolution/services/user_services.dart';
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
                    Text(
                      'Enter Your Email',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: MyColors.myred2,
                            fontSize: 32,
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
                                return null;
                              },
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: MyColors.mywhite,
                                    fontSize: 16,
                                  ),
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
                          child: GestureDetector(
                            onTap: () async {
                              final isValid = formKey3.currentState!.validate();
                              if (!isValid) return;
                              await UserServices().resetPassword(
                                context,
                                _forgotpasswordcontroller.text.trim(),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(MySnackBar(
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                title: 'Done',
                                message: 'Password reset successfuly',
                                margin: 0,
                              ));
                            },
                            child: Container(
                              width: 140,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: MyColors.myred2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Reset Password',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: MyColors.myred2,
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
    );
  }
}
