import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Icons.format_quote_rounded,
      nextScreen: Home(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.scale,
    );
  }
}
