import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:suaalo_diini/components/answer.dart';
import 'package:suaalo_diini/components/questionSection.dart';
import 'package:suaalo_diini/database.dart';
import 'package:suaalo_diini/provider/quizModel.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  late DatabaseHelper databaseHelper;

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
      }
    });
    _controller.addListener(() {
      setState(() {});
    });
    setState(() {
      databaseHelper = DatabaseHelper();
      databaseHelper.initdb();
      context.read<QuizMOdel>().initdb();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  bool checkCorrect(String answer) {
    print(
        'given answer is $answer and the true answer is ${databaseHelper.trueAnswer}');
    if (answer == databaseHelper.trueAnswer) {
      print('yeeeeees');
      return true;
    } else {
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

  void animationFadeInStart() {
    _controller.reset();
    _controller.forward(from: 0.2);
  }

  @override
  Widget build(BuildContext context) {
    void showConfettiF() {
      _showConfetti(context);
    }

    return AnimatedBuilder(
        animation: _controller,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              QuestionSection(),
              const SizedBox(
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
                        // animationFadeInStart();
                        // // _showConfetti(context);
                      },
                      child: Text(context.watch<QuizMOdel>().question),
                    ),
                    // Answers
                    AnswerSegment(
                      answer: databaseHelper.option1,
                      onPress: checkCorrect,
                      nextQuestion: databaseHelper.nextQuestion,
                      shuffleList: databaseHelper.shuffleList,
                      blockTapping: blockTapping,
                      unBlockTapping: unBlockTapping,
                      showConfetti: showConfettiF,
                      animationFadeInStart: animationFadeInStart,
                    ),
                    AnswerSegment(
                      answer: databaseHelper.option2,
                      onPress: checkCorrect,
                      nextQuestion: databaseHelper.nextQuestion,
                      shuffleList: databaseHelper.shuffleList,
                      blockTapping: blockTapping,
                      unBlockTapping: unBlockTapping,
                      showConfetti: showConfettiF,
                      animationFadeInStart: animationFadeInStart,
                    ),
                    AnswerSegment(
                      answer: databaseHelper.option3,
                      onPress: checkCorrect,
                      nextQuestion: databaseHelper.nextQuestion,
                      shuffleList: databaseHelper.shuffleList,
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
                      color: Colors.black
                          .withOpacity(0.1), // Semi-transparent black
                    ))
              ]))
            ],
          ),
        ),
        builder: (context, child) {
          return Opacity(opacity: _controller.value, child: child);
        });
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
