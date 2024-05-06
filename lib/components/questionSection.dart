import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:suaalo_diini/constants.dart';
import 'package:suaalo_diini/provider/quizModel.dart';

class QuestionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFF19833)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 5, // Spread radius
              blurRadius: 7, // Blur radius
              offset: Offset(0, 3), // Offset from the container
            ),
          ],
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xFF2B2B2B),
          shape: BoxShape.rectangle,
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                '${context.watch<QuizMOdel>().currentQuestion.toString()} / 300',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              // child: Lottie.asset(
              //   'assets/Animation - 1706099595761.json',
              //   repeat: false,
              // ),
              child: Center(
                  child: Text(
                context.watch<QuizMOdel>().question,
                style: kQuestionTextStyle,
                textAlign: TextAlign.center,
              )).animate().fadeIn(duration: const Duration(seconds: 3)),
            )
          ],
        ),
      ),
    );
  }

  const QuestionSection({super.key});
}
