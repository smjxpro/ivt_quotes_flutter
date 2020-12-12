import 'package:flutter/material.dart';
import 'package:quotes_flutter/models/quote.dart';
import 'package:quotes_flutter/screens/single_quote_screen.dart';

class AuthorScreen extends StatefulWidget {
  final List<Quote> quotes;
  final List<String> authors;

  AuthorScreen({this.quotes, this.authors});

  @override
  _AuthorScreenState createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  // Future<List<Quote>> getQuotesFromDbByAuthor({String author}) async {
  //   DatabaseHelper databaseHelper = DatabaseHelper.instance;
  //
  //   List<Quote> quotes = await databaseHelper.getQuotesByAuthor(author: author);
  //
  //   return quotes;
  // }

  List<String> authors = List();

  List<Quote> getQuotesByAuthor({String author}) {
    List<Quote> authorQuotes = List();

    for (var q in widget.quotes) {
      if (q.author == author) {
        authorQuotes.add(q);
      }
    }

    return authorQuotes;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.authors.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quotes by Author'),
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,
            tabs: tabBuilder(widget.authors),
          ),
        ),
        body: TabBarView(
          children: buildTabView(widget.authors),
        ),
      ),
    );
  }

  List<ListView> buildTabView(List<String> authors) {
    List<ListView> listViews = List();
    for (int i = 0; i < widget.authors.length; i++) {
      var listView = buildListView(author: authors[i]);

      listViews.add(listView);
    }
    return listViews;
  }

  ListView buildListView({String author}) {
    List<Quote> authorQuotes = getQuotesByAuthor(author: author);
    return ListView.builder(
      itemCount: authorQuotes.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    SingleQuoteScreen(quote: authorQuotes[index]),
              ),
            );
          },
          child: ListTile(
            leading: Text(
              (index + 1).toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: Text(
              authorQuotes[index].text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Tab> tabBuilder(List<String> authors) {
    List<Tab> tabs = List();

    for (int i = 0; i < widget.authors.length; i++) {
      var tab = Tab(
        icon: Icon(Icons.person),
        text: authors[i] == null ? 'Unknown' : authors[i],
      );

      tabs.add(tab);
    }
    return tabs;
  }
}
