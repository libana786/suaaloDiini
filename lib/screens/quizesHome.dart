import 'package:flutter/material.dart';

class QuizesHome extends StatelessWidget {
  QuizesHome({super.key});
  List<int> listOfSections = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2B2B2B),
        title: const Text(
          'Suaalo Diini',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, 'home'),
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  QuizSection(
                    icon: const Icon(
                      Icons.school,
                      color: Colors.blue,
                      size: 70.0,
                    ),
                    stageName: 'Beginner',
                    range: '1 - 50',
                  ),
                  QuizSection(
                    icon: const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 70.0,
                    ),
                    stageName: 'Novice',
                    range: '51 - 100',
                  ),
                  QuizSection(
                    icon: const Icon(
                      Icons.layers,
                      color: Colors.green,
                      size: 70.0,
                    ),
                    stageName: 'Intermediate',
                    range: '101 - 150',
                  ),
                  QuizSection(
                    icon: const Icon(
                      Icons.lightbulb,
                      color: Colors.yellow,
                      size: 70.0,
                    ),
                    stageName: 'Proficient',
                    range: '151 - 200',
                  ),
                  QuizSection(
                    icon: const Icon(
                      Icons.extension,
                      color: Colors.red,
                      size: 70.0,
                    ),
                    stageName: 'Advanced',
                    range: '201 - 250',
                  ),
                  QuizSection(
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.purple,
                      size: 70.0,
                    ),
                    stageName: 'Expert',
                    range: '251 - 300',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizSection extends StatelessWidget {
  final String stageName;
  final String range;
  final Icon icon;

  QuizSection(
      {super.key,
      required this.stageName,
      required this.range,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => print('Tapped ########'),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B2B2B),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    backgroundBlendMode: BlendMode.modulate,
                  ),
                  margin: EdgeInsets.only(bottom: 10.0),
                  height: 100.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        icon,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              stageName,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            Text(
                              range,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned.fill(
          child: Visibility(
            visible: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: const Icon(
                      Icons.lock,
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
