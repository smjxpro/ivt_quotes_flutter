/// text : "Genius is one percent inspiration and ninety-nine percent perspiration."
/// author : "Thomas Edison"

class Quote {
  String _text;
  String _author;

  String get text => _text;

  String get author => _author;

  Quote({String text, String author}) {
    _text = text;
    _author = author;
  }

  Quote.fromJson(Map<String, dynamic> json) {
    _text = json["text"];
    _author = json["author"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["text"] = _text;
    map["author"] = _author;
    return map;
  }
}
