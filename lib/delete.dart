import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Flutter code sample for [showDialog].

void main() => runApp(const ShowDialogExampleApp());

class ShowDialogExampleApp extends StatelessWidget {
  const ShowDialogExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DialogExample(),
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('showDialog Sample')),
      body: Center(
        child: OutlinedButton(
          onPressed: () => _dialogBuilder(context),
          child: const Text('Open Dialog'),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class MyDialog extends StatefulWidget {
  final Function() onAnimationCompleted;

  const MyDialog({Key? key, required this.onAnimationCompleted})
      : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Notify the parent when the animation is completed
        widget.onAnimationCompleted();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Lottie.asset(
        'assets/Animation - 1706099595761.json',
        controller: _controller,
        onLoaded: (composition) {
          _controller.forward();
        },
      ),
    );
  }
}
