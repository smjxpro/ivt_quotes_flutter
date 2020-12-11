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

    print('Save: inserted with id: $id');
  }

  _delete() async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    await databaseHelper.deleteQuotes();

    print('Deleted');
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
        var quotes = await quoteService.getQuotes();

        List<Quote> quotesFromDb = await getQuotesFromDb();

        if (quotes.length > 0 && quotesFromDb.length != quotes.length) {
          _delete();
          for (int i = 0; i < quotes.length; i++) {
            _save(quotes[i]);
          }
        }

        return Home(
          quotes: quotesFromDb,
        );
      },
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.scale,
    );
  }
}
