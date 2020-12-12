import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes_flutter/models/quote.dart';
import 'package:share/share.dart';

class SingleQuoteScreen extends StatelessWidget {
  final Quote quote;

  SingleQuoteScreen({this.quote});

  String getAuthor() {
    if (quote.author == null) {
      return 'Unknown';
    }
    return quote.author;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getAuthor()),
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
                      quote.text == null ? '' : '"' + quote.text + '"',
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
                          getAuthor(),
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
            ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.share), Text('Share')],
              ),
              onPressed: () {
                Share.share(quote.text + '\n - ' + getAuthor(),
                    subject: 'Quote of the Day');
              },
            )
          ],
        ),
      ),
    );
  }
}
