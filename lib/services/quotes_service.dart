import 'dart:convert';

import 'package:quotes_flutter/interfaces/i_quote_service.dart';
import 'package:quotes_flutter/models/quote.dart';
import 'package:http/http.dart' as http;

class QuoteService implements IQuoteService {
  var url = 'https://type.fit/api/quotes';

  var _client = http.Client();

  set client(http.Client client) {
    _client = client;
  }

  @override
  Future<List<Quote>> getQuotes() async {
    List<Quote> quotes = List();

    var response = await _client.get(url);

    if (response.statusCode == 200) {
      var quoteMap = jsonDecode(response.body);

      print(quoteMap);

      if (quoteMap.length > 0) {
        for (int i = 0; i < quoteMap.length; i++) {
          var quote = Quote.fromJson(quoteMap[i]);
          quotes.add(quote);
        }
      }
    }

    print(quotes);
    return quotes;
  }
}
