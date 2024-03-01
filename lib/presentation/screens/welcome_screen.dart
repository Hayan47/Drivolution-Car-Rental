import 'package:drivolution/constants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _toggle = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/img/background1.jpg'), fit: BoxFit.cover),
      ),
      //items
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                Image.asset('assets/img/logo/drivolution.png'),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientText(
                      'lets go for a ride',
                      colors: [
                        MyColors.myBlue2.withOpacity(1),
                        MyColors.myBlue.withOpacity(1),
                        MyColors.myred2.withOpacity(1),
                        MyColors.myred.withOpacity(1),
                      ],
                      style: GoogleFonts.amiri(
                        decoration: TextDecoration.none,
                        color: MyColors.myred,
                        fontSize: MediaQuery.sizeOf(context).width * 0.07,
                      ),
                    ),
                    Animate(
                      target: _toggle ? 1 : 0,
                      // ignore: prefer_const_literals_to_create_immutables
                      effects: [
                        const MoveEffect(
                          begin: Offset(0, 0),
                          end: Offset(250, 0),
                          duration: Duration(milliseconds: 1500),
                        )
                      ],
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        height: MediaQuery.sizeOf(context).width * 0.2,
                        child: Lottie.asset(
                          'assets/lottie/4.zip',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: MediaQuery.sizeOf(context).width / 2,
              child: Stack(
                children: [
                  Positioned(
                    // right: 25,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'continue',
                        style: GoogleFonts.amiri(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: MyColors.mywhite,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 78,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          _toggle = true;
                        });
                        // await CarServices().getAllCars();
                        await Future.delayed(const Duration(seconds: 1));
                        Navigator.pushReplacementNamed(context, 'mainscreen');
                      },
                      child: Image.asset(
                        'assets/icons/arrow_right2.png',
                        // scale: 0.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
