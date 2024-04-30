import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:suaalo_diini/components/answer.dart';
import 'package:suaalo_diini/components/questionSection.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  late Database _database;
  List<String> options = [];
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String trueAnswer = '';
  int currentQuestion = 1;
  bool isOptionTappable = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('Animation has finished');
        _controller.reset();
      }
    });
    setState(() {
      initdb();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void initdb() async {
    _database = await _openDatabase();
    await setEntries(currentQuestion);
  }

  void shuffleList() {
    setState(() {
      options.shuffle();
      option1 = options[0];
      option2 = options[1];
      option3 = options[2];
    });
  }

  bool checkCorrect(String answer) {
    print('given answer is $answer and the true answer is $trueAnswer');
    if (answer == trueAnswer) {
      print('yeeeeees');
      return true;
    } else {
      // shufleList();
      return false;
    }
  }

  void blockTapping() {
    setState(() {
      isOptionTappable = true;
    });
  }

  void unBlockTapping() {
    setState(() {
      isOptionTappable = false;
    });
  }

  void nextQuestion() {
    setState(() {
      currentQuestion++;
      setEntries(currentQuestion);
    });
  }

  Future<Database> _openDatabase() async {
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
      trueAnswer = record['true_answer'];
      options = [record['true_answer'], record['false_1'], record['false_2']];
      options.shuffle();
      // Assign values to the variables
      setState(() {
        question = record['question'];
        option1 = options[0];
        option2 = options[1];
        option3 = options[2];
      });

      // option1 = record['true_answer'];
      // option2 = record['false_1'];
      // option3 = record['false_2'];
    }
  }

  void animationFadeInStart() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    void showConfettiF() {
      _showConfetti(context);
    }

    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          QuestionSection(
            quetion: question,
            currentQuestionNumber: currentQuestion,
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  onPressed: () {
                    animationFadeInStart();
                    // _showConfetti(context);
                  },
                  child: Text('Show'),
                ),

                // Answers
                AnswerSegment(
                  answer: option1,
                  onPress: checkCorrect,
                  nextQuestion: nextQuestion,
                  shuffleList: shuffleList,
                  blockTapping: blockTapping,
                  unBlockTapping: unBlockTapping,
                  showConfetti: showConfettiF,
                  animationFadeInStart: animationFadeInStart,
                ),
                AnswerSegment(
                  answer: option2,
                  onPress: checkCorrect,
                  nextQuestion: nextQuestion,
                  shuffleList: shuffleList,
                  blockTapping: blockTapping,
                  unBlockTapping: unBlockTapping,
                  showConfetti: showConfettiF,
                  animationFadeInStart: animationFadeInStart,
                ),
                AnswerSegment(
                  answer: option3,
                  onPress: checkCorrect,
                  nextQuestion: nextQuestion,
                  shuffleList: shuffleList,
                  blockTapping: blockTapping,
                  unBlockTapping: unBlockTapping,
                  showConfetti: showConfettiF,
                  animationFadeInStart: animationFadeInStart,
                ),
              ],
            ),
            Visibility(
                visible: isOptionTappable,
                child: Container(
                  color:
                      Colors.black.withOpacity(0.1), // Semi-transparent black
                ))
          ]))
        ],
      ),
    );
  }

  Future<void> _showConfetti(BuildContext context) {
    print('in Confetti Functionnnnnnnnnnnn');
    return showDialog(
        context: context,
        builder: (context) {
          return Lottie.asset(
            'assets/Animation - 1706099595761.json',
            onLoaded: (composition) async {
              await Future.delayed(Duration(seconds: 2));
              print('after waiting');
              Navigator.of(context).pop();
            },
            repeat: false,
          );
        });
  }
}
