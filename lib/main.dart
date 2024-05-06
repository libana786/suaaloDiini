import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suaalo_diini/provider/quizModel.dart';

import 'screens/homeScreen.dart';
import 'screens/quizesHome.dart';

// void main() {
//   runApp(const MyApp());
// }

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => QuizMOdel())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(scaffoldBackgroundColor: Colors.black45),
      routes: {
        'home': (context) => HomePage(),
        'quizesHome': (context) => QuizesHome()
      },
      initialRoute: 'quizesHome',
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ))
          ],
        ),
        body: HomeBody());
  }
}
