import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/constants/strings.dart';
import 'package:drivolution/services/user_services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool hide_password = true;

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
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
                          Text('Hello Again!',
                              style: GoogleFonts.roboto(
                                color: MyColors.myred,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              )),

                          const SizedBox(height: 10),
                          //!second message
                          Text(
                            'welcome back, you have been missed!',
                            style: GoogleFonts.roboto(
                              color: MyColors.myred2,
                              fontSize: 16,
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
                                    keyboardType: TextInputType.emailAddress,
                                    style: GoogleFonts.roboto(
                                      color: MyColors.mywhite,
                                      fontSize: 16,
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
                                      hintStyle: GoogleFonts.roboto(
                                        color: MyColors.mywhite,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(height: 15),
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
                                    obscureText: hide_password,
                                    style: GoogleFonts.roboto(
                                      color: MyColors.mywhite,
                                      fontSize: 16,
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
                                              hide_password = !hide_password;
                                            });
                                          },
                                          icon: Icon(
                                            hide_password
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: MyColors.mywhite,
                                          )),
                                      border: InputBorder.none,
                                      hintText: 'Password...',
                                      hintStyle: GoogleFonts.roboto(
                                        color: MyColors.mywhite,
                                        fontSize: 16,
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
                                    style: GoogleFonts.roboto(
                                      color: MyColors.myred2,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //!login Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextButton(
                                  onPressed: () async {
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(
                                    //     content: Text('dsadas'),
                                    //   ),
                                    // );
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
                                  child: Text('log in',
                                      style: GoogleFonts.roboto(
                                        color: MyColors.mywhite,
                                        fontSize: 14,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //!sign up message
                          const Text(
                            'ain\'t member yet?',
                            style:
                                TextStyle(fontSize: 16, color: MyColors.myred2),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, signupscreen),
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.myred),
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
