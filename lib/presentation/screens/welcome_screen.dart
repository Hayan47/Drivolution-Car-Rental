import 'package:audioplayers/audioplayers.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/app_typography.dart';
import 'package:drivolution/utils/responsive/responsive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        //! Background
        return DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/background1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          //! Items
          child: SafeArea(
            child: Padding(
              padding: ResponsiveHelper.screenPadding(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: ResponsiveHelper.hp(context, 5)),
                  //! Logo section
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: ResponsiveHelper.hp(context, 15),
                    ),
                    child: Image.asset(
                      'assets/img/logo/drivolution.png',
                      fit: BoxFit.contain,
                    ),
                  ),

                  //! Middle section with text and animation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: GradientText(
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
                              fontSize: ResponsiveHelper.wp(context, 7),
                            ),
                          ),
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
                          width: ResponsiveHelper.wp(context, 15),
                          height: ResponsiveHelper.wp(context, 15),
                          child: Lottie.asset(
                            'assets/lottie/welcome_car.zip',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  //! Bottom button
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
                      width: ResponsiveHelper.isPortrait(context)
                          ? ResponsiveHelper.wp(context, 23)
                          : ResponsiveHelper.hp(context, 23),
                      height: ResponsiveHelper.isPortrait(context)
                          ? ResponsiveHelper.wp(context, 23)
                          : ResponsiveHelper.hp(context, 23),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                      ),
                      child: Lottie.asset(
                        'assets/lottie/stop.json',
                        repeat: false,
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller.duration = composition.duration;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: ResponsiveHelper.hp(context, 5)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
