import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quotes_flutter/helpers/database_helper.dart';
import 'package:quotes_flutter/models/quote.dart';

class Home extends StatefulWidget {
  final List<Quote> quotes;

  Home({this.quotes});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int rnd = 0;

  void generateRandom() {
    var rng = Random();

    rnd = rng.nextInt(widget.quotes.length);
  }

  Quote quoteOfTheDay() {
    if (widget.quotes.length > 0) {
      return widget.quotes[rnd];
    }
    return null;
  }

  Future<Quote> getQuoteFromDb(int id) async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    Quote quote = await databaseHelper.getQuote(id);

    return quote;
  }

  @override
  void initState() {
    generateRandom();

    quoteOfTheDay();

    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quote of the day'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  generateRandom();
                });
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              quoteOfTheDay().text == null
                  ? ''
                  : '"' + quoteOfTheDay().text + '"',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  quoteOfTheDay().author == null
                      ? ''
                      : '- ' + quoteOfTheDay().author,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
