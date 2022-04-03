import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_champion/Constants/colors_and_themes.dart';
import 'package:math_champion/Helper/record.dart';

class ScoreDialog extends StatelessWidget {
  ScoreDialog(this.score, {required this.isHard, Key? key}) : super(key: key);

  int score;
  bool isHard;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: const FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          'YOU LOST!',
          style: TextStyle(
              color: AppColors.secondaryColor, fontFamily: 'Ramaraja'),
        ),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: DefaultTextStyle(
          style: TextStyle(
              fontFamily: 'Ramaraja',
              fontSize: MediaQuery.of(context).size.height / 30,
              color: AppColors.onColor),
          child: Column(
            children: [
              Text('Your score:  $score'),
              FutureBuilder(
                  future: RecordHelper.fetchAndGetRecord(score, isHard),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Your record: ...');
                    } else {
                      int record =
                          snapshot.hasData ? (snapshot.data as int) : score;
                      return Text('Your record: $record');
                    }
                  })),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            SizedBox(
              width: _width * 0.11,
            ),
            SizedBox(
              width: _width * 0.2,
              child: FittedBox(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).popAndPushNamed('/');
                    },
                    child: const Text('Menu')),
              ),
            ),
            SizedBox(
              width: _width * 0.1,
            ),
            SizedBox(
              width: _width * 0.2,
              child: FittedBox(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      isHard
                          ? Navigator.of(context)
                              .popAndPushNamed('/singleplayerHard')
                          : Navigator.of(context)
                              .popAndPushNamed('/singleplayerHard');
                    },
                    child: const Text('Retry')),
              ),
            ),
            SizedBox(
              width: _width * 0.11,
            ),
          ],
        )
      ],
      elevation: 8,
      backgroundColor: AppColors.cardColor,
      alignment: Alignment.center,
    );
  }
}
