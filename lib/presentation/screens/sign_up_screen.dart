import 'package:drivolution/constants/my_colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../widgets/dropdown.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool hide_password = true;

  int dropDownValue = 19;

  var ages = List<int>.generate(100, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: MyColors.myred),
      ),

      //body
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              //main column
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //first column
                      Column(
                        children: const [
                          SizedBox(height: 15),
                          Text(
                            //first message
                            'Join Us',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: MyColors.myred),
                          ),
                          SizedBox(height: 10),
                          Text(
                            //second message
                            'Sign up and explore',
                            style:
                                TextStyle(fontSize: 16, color: MyColors.myred2),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      //second column
                      Column(
                        children: [
                          Row(
                            children: [
                              //first name TextField
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
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
                                          textAlign: TextAlign.center,
                                          controller: _firstnamecontroller,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value == '') {
                                              return 'Enter a name';
                                            }
                                          },
                                          style: const TextStyle(
                                            color: MyColors.mywhite,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'First Name',
                                            helperText: '',
                                            hintStyle: TextStyle(
                                              color: MyColors.mywhite,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 25),
                              //last name TextField
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25),
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
                                          textAlign: TextAlign.center,
                                          controller: _lastnamecontroller,
                                          style: const TextStyle(
                                            color: MyColors.mywhite,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Last Name',
                                            helperText: '',
                                            hintStyle: TextStyle(
                                              color: MyColors.mywhite,
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
                          //Dropdown button
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: MyDropdown(
                              width: 80,
                              dropdownValue: dropDownValue,
                              label: 'age',
                              items: ages
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Center(child: Text('$e')),
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
                          //Email TextField
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
                                    controller: _emailcontroller,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null ||
                                          !EmailValidator.validate(value)) {
                                        return 'Enter a valid email';
                                      }
                                    },
                                    style: const TextStyle(
                                        color: MyColors.mywhite),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Email...',
                                      hintStyle:
                                          TextStyle(color: MyColors.mywhite),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          //Password TextField
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
                                    controller: _passwordcontroller,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.length < 8) {
                                        return 'password should be 6 chrachters or more';
                                      }
                                    },
                                    style: const TextStyle(
                                        color: MyColors.mywhite),
                                    obscureText: hide_password,
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
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'password...',
                                      hintStyle: const TextStyle(
                                        color: MyColors.mywhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          //Confirm Password TextField
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
                                    controller: _confirmpasswordcontroller,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value != _passwordcontroller.text) {
                                        return 'passwords not matching';
                                      }
                                    },
                                    style: const TextStyle(
                                        color: MyColors.mywhite),
                                    obscureText: hide_password,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'confirm password...',
                                      hintStyle: TextStyle(
                                        color: MyColors.mywhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          //Signup Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: TextButton(
                                  onPressed: () async {
                                    final isValid =
                                        formKey.currentState!.validate();
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
                                    await Auth().signUp(
                                      context,
                                      _emailcontroller.text.trim(),
                                      _passwordcontroller.text.trim(),
                                      _firstnamecontroller.text.trim(),
                                      _lastnamecontroller.text.trim(),
                                      dropDownValue,
                                    );
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(70, 40)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              MyColors.myred2)),
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(color: MyColors.mywhite),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //Last Message
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Any proplem?',
                            style: TextStyle(
                              fontSize: 16,
                              color: MyColors.myred2,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            child: const Text(
                              'Contact Us',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyColors.myred2,
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
    );
  }
}
