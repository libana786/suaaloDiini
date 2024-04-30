import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:suaalo_diini/constants.dart';

class AnswerSegment extends StatefulWidget {
  final String answer;
  final Function onPress;
  final Function nextQuestion;
  final Function shuffleList;
  final Function blockTapping;
  final Function unBlockTapping;
  final Function showConfetti;
  final Function animationFadeInStart;
  const AnswerSegment({
    required this.answer,
    super.key,
    required this.onPress,
    required this.nextQuestion,
    required this.shuffleList,
    required this.blockTapping,
    required this.unBlockTapping,
    required this.showConfetti,
    required this.animationFadeInStart,
  });
  @override
  State<AnswerSegment> createState() => _AnswerSegmentState();
}

class _AnswerSegmentState extends State<AnswerSegment>
    with SingleTickerProviderStateMixin {
  bool? _isCorrect = null;
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void playsound() async {
    final player = AudioPlayer();
    await player.play(AssetSource('assets_sound_0201.mp3'),
        mode: PlayerMode.lowLatency, position: Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: OutlinedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(10.0),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Color(0xFFF19833), width: 2.0),
              ),
            ),
            shadowColor: MaterialStateProperty.all(Color(0xFFF19833)),
            backgroundColor: MaterialStateProperty.all(_isCorrect == null
                ? Color(0xFF2B2B2B)
                : (_isCorrect! ? Colors.green : Colors.red)),
          ),
          onPressed: () async {
            widget.blockTapping();
            setState(() {
              _isCorrect = widget.onPress(widget.answer);
              if (_isCorrect!) {
                widget.showConfetti();
                playsound();
              } else {
                _controller.repeat(reverse: true);
              }
            });
            await Future.delayed(Duration(seconds: 1));
            setState(() {
              _isCorrect! ? widget.nextQuestion() : widget.shuffleList();
              _controller.reset();
            });
            widget.unBlockTapping();
            setState(() {
              _isCorrect = null;
            });
            _isCorrect! ? widget.animationFadeInStart() : null;
          },
          child: Text(
            widget.answer,
            style: _isCorrect == null
                ? kAnswerTextStyle
                : kAnswerTextStyle.copyWith(color: Colors.black),
          ).animate().fadeIn(duration: const Duration(seconds: 2)),
        ).animate(controller: _controller).shakeX(),
      ),
    );
  }
}
