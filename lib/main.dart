import 'package:flutter/material.dart';
import 'package:math_champion/Constants/colors_and_themes.dart';
import 'package:math_champion/Screens/menu.dart';
import 'package:math_champion/Screens/singleplayer_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Chapmion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: AppShemes.lightSheme),
      home: const MenuScreen(),
      routes: {
        '/singleplayerHard': (context) => SingleplayerScreen(true),
        '/singleplayerEasy': (context) => SingleplayerScreen(false),
      },
    );
  }
}
