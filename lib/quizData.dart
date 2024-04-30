// import 'package:provider/provider.dart';
//
// class QuizData extends ChangeNotifier {
//   int currentQuestion = 1;
//   String question = '';
//   List<String> options = [];
//   String trueAnswer = '';
//   void setEntries(int id, Database db) async {
//     List<Map<String, dynamic>> records = await db.query(
//       'questions',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//     if (records.isNotEmpty) {
//       Map<String, dynamic> record = records.first;
//       trueAnswer = record['true_answer'];
//       options = [record['true_answer'], record['false_1'], record['false_2']];
//       options.shuffle();
//       question = record['question'];
//       notifyListeners(); // Notify listeners about changes
//     }
//   }
//
//   void nextQuestion(Database db) async {
//     currentQuestion++;
//     await setEntries(currentQuestion, db);
//   }
//
//   bool checkCorrect(String answer) {
//     if (answer == trueAnswer) {
//       nextQuestion(db); // Update question using provider method
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
// }
