import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quotes_flutter/services/quotes_service.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  QuoteService quoteService = QuoteService();

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: Icons.format_quote_rounded,
      screenFunction: () async {
        var quotes = await quoteService.getQuotes();

        return Home(
          quotes: quotes,
        );
      },
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.scale,
    );
  }
}
