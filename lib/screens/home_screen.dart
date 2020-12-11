import 'dart:math';

import 'package:flutter/material.dart';
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
    return widget.quotes[rnd];
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
      body: Column(
        children: [
          Text(quoteOfTheDay().text),
          Text(quoteOfTheDay().author == null ? '' : quoteOfTheDay().author),
        ],
      ),
    );
  }
}
