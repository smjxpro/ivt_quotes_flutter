import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quotes_flutter/helpers/database_helper.dart';
import 'package:quotes_flutter/models/quote.dart';
import 'package:quotes_flutter/screens/author_screen.dart';
import 'package:quotes_flutter/screens/stats_screen.dart';
import 'package:quotes_flutter/services/quotes_service.dart';
import 'package:share/share.dart';

class HomeScreen extends StatefulWidget {
  final List<Quote> quotes;

  HomeScreen({this.quotes});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int rnd = 0;

  var enteredDate;
  var currentDate;

  void compareDate() {
    if (enteredDate.difference(currentDate).inHours > 24) {}
  }

  List<String> authors = List();

  void generateRandom() {
    var rng = Random();

    rnd = rng.nextInt(widget.quotes.length);
  }

  QuoteService quoteService = QuoteService();

  _save(Quote quote) async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    int id = await databaseHelper.insertQuote(quote);
  }

  _delete() async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    await databaseHelper.deleteQuotes();
  }

  void refresh() async {
    var quotes = await quoteService.getQuotes();

    _delete();
    for (int i = 0; i < quotes.length; i++) {
      _save(quotes[i]);
    }
  }

  Quote quoteOfTheDay() {
    if (widget.quotes.length > 0) {
      return widget.quotes[rnd];
    }
    return null;
  }

  Future<Quote> getQuoteFromDbById(int id) async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    Quote quote = await databaseHelper.getQuoteById(id);

    return quote;
  }

  Future<List<String>> getAuthors() async {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;

    List<String> authors = await databaseHelper.getAuthors();

    return authors;
  }

  @override
  void initState() {
    enteredDate = DateTime.now();

    print('ED: ' + enteredDate.toString());

    generateRandom();

    quoteOfTheDay();

    getAuthors().then((value) {
      authors = value;
    });

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
                  refresh();
                });
              })
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  Icon(
                    Icons.format_quote_sharp,
                    size: 100,
                  ),
                  Text(
                    'Quotes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.format_quote_rounded),
              title: Text('Quotes by Author'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        AuthorScreen(
                          quotes: widget.quotes,
                          authors: authors,
                        ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.pie_chart),
              title: Text('Statistics'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        StatsScreen(
                          quotes: widget.quotes,
                          authors: authors,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Padding(
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.share),
                        Text('Share'),
                      ],
                    ),
                    onPressed: () {
                      Share.share(
                          quoteOfTheDay().text +
                              '\n - ' +
                              quoteOfTheDay().author,
                          subject: 'Quote of the Day');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh),
                        Text('Refresh'),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        generateRandom();

                        currentDate = DateTime.now();

                        print('CD: ' + currentDate.toString());
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
