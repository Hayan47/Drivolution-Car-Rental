import 'package:audioplayers/audioplayers.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
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

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _toggle = false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
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
                        AppColors.deepNavy.withOpacity(1),
                        AppColors.oceanBlue.withOpacity(1),
                        AppColors.coralRed.withOpacity(1),
                        AppColors.blazingRed.withOpacity(1),
                      ],
                      style: AppTypography.title.copyWith(
                        decoration: TextDecoration.none,
                        color: AppColors.blazingRed,
                        fontSize: MediaQuery.sizeOf(context).width * 0.07,
                      ),
                    ),
                    Animate(
                      target: _toggle ? 1 : 0,
                      effects: const [
                        MoveEffect(
                          begin: Offset(0, 0),
                          end: Offset(250, 0),
                          duration: Duration(milliseconds: 1500),
                        )
                      ],
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.2,
                        height: MediaQuery.sizeOf(context).width * 0.2,
                        child: Lottie.asset(
                          'assets/lottie/welcome_car.zip',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () async {
                      await player.play(AssetSource('sounds/start.mp3'));
                      _controller.forward();
                      await Future.delayed(const Duration(seconds: 2));
                      setState(() {
                        _toggle = true;
                      });
                      await Future.delayed(const Duration(seconds: 1));
                      Navigator.pushReplacementNamed(context, 'mainscreen');
                    },
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            spreadRadius: 2,
                            color: AppColors.obsidian,
                          )
                        ],
                      ),
                      child: Lottie.asset(
                        'assets/lottie/stop.json',
                        repeat: false,
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller.duration = composition.duration;
                        },
                      ),
                    )),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
