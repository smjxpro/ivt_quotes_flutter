import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:quotes_flutter/models/quote.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableQuotes = 'quotes';
final String columnId = 'id';
final String columnText = 'text';
final String columnAuthor = 'author';

class DatabaseHelper {
  static final _databaseName = "quotes.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return database;
  }

  _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, _databaseName);

    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    var sql = '''
    CREATE TABLE $tableQuotes (
    $columnId INTEGER PRIMARY KEY,
    $columnText TEXT NOT NULL,
    $columnAuthor TEXT
    )
    ''';

    await db.execute(sql);
  }

  Future<int> insertQuote(Quote quote) async {
    Database db = await database;
    int id = await db.insert(tableQuotes, quote.toJson());
    return id;
  }

  Future<Quote> getQuote(int id) async {
    Database db = await database;

    List<Map> maps = await db.query(tableQuotes,
        columns: [columnId, columnText, columnAuthor],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Quote.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Quote>> getQuotes() async {
    Database db = await database;

    List<Quote> quotes = List();

    List<Map> maps = await db.query(
      tableQuotes,
      columns: [columnId, columnText, columnAuthor],
    );

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        var quote = Quote.fromJson(maps[i]);

        quotes.add(quote);
      }
      return quotes;
    }
    return quotes;
  }

  Future<void> deleteQuotes() async {
    Database db = await database;

    db.delete(tableQuotes);
  }
}
