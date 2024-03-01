import 'package:drivolution/constants/my_colors.dart';
import 'package:drivolution/logic/user_bloc/user_bloc.dart';
import 'package:drivolution/presentation/widgets/snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      //?body
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              MyColors.myGrey,
              MyColors.myBlue4,
              MyColors.myGrey,
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
            } else if (state is UserLoaded) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'mainscreen',
                (Route<dynamic> route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                MySnackBar(
                  icon: const Icon(Icons.done, color: Colors.green, size: 18),
                  message: 'welcome ${state.userInfo.firstName}',
                  margin: 70,
                ),
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
                  iconTheme: const IconThemeData(color: MyColors.myred2),
                ),
                Expanded(
                  child: CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          //?main column
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //?first column
                                  Column(
                                    children: [
                                      const SizedBox(height: 15),
                                      Text(
                                        //!first message
                                        'Join Us',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: MyColors.myred2,
                                              fontSize: 38,
                                            ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        //!second message
                                        'Sign up and explore',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: MyColors.myred2,
                                              fontSize: 18,
                                            ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                  //?second column
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          //!first name TextField
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: MyColors.myred2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: TextFormField(
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      textAlign:
                                                          TextAlign.center,
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
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                            color: MyColors
                                                                .mywhite,
                                                          ),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: 'First Name',
                                                        helperText: '',
                                                        hintStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                  color: MyColors
                                                                      .mywhite,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 25),
                                          //!last name TextField
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 25),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: MyColors.myred2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: TextFormField(
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      textAlign:
                                                          TextAlign.center,
                                                      controller:
                                                          _lastnamecontroller,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                            color: MyColors
                                                                .mywhite,
                                                          ),
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: 'Last Name',
                                                        helperText: '',
                                                        hintStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                  color: MyColors
                                                                      .mywhite,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      //!Dropdown button
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: MyDropdown(
                                          icon: 'assets/icons/age.png',
                                          width: 80,
                                          dropdownValue: dropDownValue,
                                          label: 'age',
                                          items: ages
                                              .map(
                                                (e) => DropdownMenuItem(
                                                  value: e,
                                                  child:
                                                      Center(child: Text('$e')),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              dropDownValue = value;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      //!Phone TextField
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
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
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: MyColors.mywhite,
                                                    ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Phone Number...',
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
                                      //!Email TextField
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
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
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: MyColors.mywhite,
                                                    ),
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
                                      //!Password TextField
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
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
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: MyColors.mywhite,
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
                                                      color: MyColors.mywhite,
                                                    ),
                                                  ),
                                                  border: InputBorder.none,
                                                  hintText: 'password...',
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
                                      //!Confirm Password TextField
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
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
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: MyColors.mywhite,
                                                    ),
                                                obscureText: hidePassword,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'confirm password...',
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
                                      //!Signup Button
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
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
                                                      email: _emailcontroller
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
                                                          _phonecontroller.text
                                                              .trim(),
                                                      age: dropDownValue,
                                                    ));
                                              },
                                              style: ButtonStyle(
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  fixedSize:
                                                      MaterialStateProperty.all(
                                                          const Size(70, 40)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          MyColors.myred2)),
                                              child: Text(
                                                'Sign Up',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: MyColors.mywhite,
                                                      fontSize: 12,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  //!Last Message
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Any proplem?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              color: MyColors.myred2,
                                            ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        child: Text(
                                          'Contact Us',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: MyColors.myred2,
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
    );
  }
}
