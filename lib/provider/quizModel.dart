import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:suaalo_diini/database.dart';

class QuizMOdel extends ChangeNotifier {
  late Database _database;
  List<String> options = [];
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String trueAnswer = '';
  int currentQuestion = 1;

  void initdb() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    _database = await databaseHelper.openDatabaseF();
    await setEntries(currentQuestion);
    notifyListeners();
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
    notifyListeners();
  }

  void shuffleList() {
    options.shuffle();
    option1 = options[0];
    option2 = options[1];
    option3 = options[2];
    notifyListeners();
  }

  void nextQuestion() {
    currentQuestion++;
    setEntries(currentQuestion);
    notifyListeners();
  }
}
