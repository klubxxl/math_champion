import 'package:flutter/material.dart';
import 'package:math_champion/Constants/colors_and_themes.dart';

class AnswerButton extends StatelessWidget {
  AnswerButton(this.answer, this.index, this.tapFuciotn, {Key? key})
      : super(key: key);

  String answer;
  int index;
  Function tapFuciotn;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width / 2 - 20;
    final _height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () => tapFuciotn(index),
        child: Card(
          elevation: 4,
          color: AppColors.cardColor,
          child: SizedBox(
            height: _height / 4 - 16,
            width: _width,
            child: Center(
              child: FittedBox(
                child: Text(
                  answer,
                  style: TextStyle(
                      fontSize: _height / 6,
                      fontFamily: 'Ramaraja',
                      color: AppColors.onColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
