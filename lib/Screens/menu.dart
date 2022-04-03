import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:math_champion/Widgets/animated_background.dart';
import 'package:math_champion/Widgets/menu_button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final schemeColors = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: schemeColors.background,
        body: AnimatedBackgroundWidget(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MenuButtonWidget(
                    text: 'Easy Mode', newRoutName: '/singleplayerEasy'),
                const SizedBox(height: 8),
                MenuButtonWidget(
                    text: 'Hard Mode', newRoutName: '/singleplayerHard'),
                const SizedBox(height: 8),
                MenuButtonWidget(
                  text: 'Two Players (soon)',
                  newRoutName: '/',
                  disabled: true,
                ),
              ],
            ),
          ),
        ));
  }
}
