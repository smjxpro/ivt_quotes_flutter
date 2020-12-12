import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quotes_flutter/helpers/database_helper.dart';
import 'package:quotes_flutter/models/quote.dart';
import 'package:quotes_flutter/services/quotes_service.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  final QuoteService quoteService = QuoteService();

  _save(Quote quote) async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    int id = await databaseHelper.insertQuote(quote);
  }

  Future<List<Quote>> getQuotesFromDb() async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    List<Quote> quotes = await databaseHelper.getQuotes();

    return quotes;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: Icons.format_quote_rounded,
      screenFunction: () async {
        List<Quote> quotesFromDb;

        quotesFromDb = await getQuotesFromDb();

        if (quotesFromDb == null || quotesFromDb.length <= 0) {
          var quotes = await quoteService.getQuotes();
          for (int i = 0; i < quotes.length; i++) {
            _save(quotes[i]);
          }
        }

        quotesFromDb = await getQuotesFromDb();

        return HomeScreen(
          quotes: quotesFromDb,
        );
      },
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.scale,
    );
  }
}
