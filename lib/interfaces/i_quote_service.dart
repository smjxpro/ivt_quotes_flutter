import 'package:quotes_flutter/models/quote.dart';

abstract class IQuoteService {
  Future<List<Quote>> getQuotes();
}
