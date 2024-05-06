import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database _database;
  List<String> options = [];
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String trueAnswer = '';
  int currentQuestion = 1;

  void initdb() async {
    _database = await openDatabaseF();
    await setEntries(currentQuestion);
  }

  void shuffleList() {
    options.shuffle();
    option1 = options[0];
    option2 = options[1];
    option3 = options[2];
  }

  Future<Database> openDatabaseF() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "assets/quiz.db");
    var exists = await databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(url.join("assets", "quiz.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }

    // open the database
    var db = await openDatabase(path, readOnly: true);

    return db;
  }

  Future<void> setEntries(int id) async {
    // Wait for the completion of _database to get the actual Database object
    Database db = await _database;

    // Execute the query and await the result
    List<Map<String, dynamic>> records =
        await db.query('questions', where: 'id = ?', whereArgs: [id]);
    if (records.isNotEmpty) {
      // Get the first record (assuming there's only one matching record)
      Map<String, dynamic> record = records.first;
      question = record['question'];
      trueAnswer = record['true_answer'];
      options = [record['true_answer'], record['false_1'], record['false_2']];
      // Assign values to the variables
      shuffleList();
    }
  }

  void nextQuestion() {
    currentQuestion++;
    setEntries(currentQuestion);
  }
}
