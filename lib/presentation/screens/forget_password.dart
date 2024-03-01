import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              Color(0xff1E1E24),
              Color(0xff243B55),
              Color(0xff1E1E24),
            ],
          ),
        ),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            // if (state is UserLoading) {
            //   showDialog(
            //     context: context,
            //     barrierDismissible: false,
            //     builder: (context) => const Center(
            //       child: CircularProgressIndicator(
            //         color: Colors.black,
            //       ),
            //     ),
            //   );
            // } else
            if (state is UserError) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                MySnackBar(
                  icon:
                      const Icon(Icons.error, color: MyColors.myred2, size: 18),
                  message: state.errorMessage,
                  margin: 5,
                ),
              );
            } else if (state is UserInitial) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'mainscreen',
                (Route<dynamic> route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                MySnackBar(
                  icon: const Icon(Icons.done, color: Colors.green, size: 18),
                  message: 'Reset Password link has been sent to your email',
                  margin: 70,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: MyColors.myred),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: MyColors.myred2,
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
                                          color: MyColors.myred2,
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
                                            hintStyle: TextStyle(
                                                color: MyColors.mywhite),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: GestureDetector(
                                        onTap: () async {
                                          final isValid =
                                              formKey3.currentState!.validate();
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
