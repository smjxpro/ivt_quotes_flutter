import 'package:quotes_flutter/helpers/database_helper.dart';

/// text : "Genius is one percent inspiration and ninety-nine percent perspiration."
/// author : "Thomas Edison"

class Quote {
  int _id;
  String _text;
  String _author;

  int get id => _id;

  String get text => _text;

  String get author => _author;

  Quote({int id, String text, String author}) {
    _id = id;
    _text = text;
    _author = author;
  }

  Quote.fromJson(Map<String, dynamic> json) {
    _id = json[columnId];
    _text = json[columnText];
    _author = json[columnAuthor];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map[columnText] = _text;
    map[columnAuthor] = _author;

    if (_id != null) {
      map[columnId] = _id;
    }
    return map;
  }
}
