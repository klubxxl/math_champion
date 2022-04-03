import 'package:flutter/material.dart';
import 'package:math_champion/Constants/colors_and_themes.dart';
import 'package:math_champion/Helper/game_engine.dart';
import 'package:math_champion/Widgets/answer_card_button.dart';
import 'package:math_champion/Widgets/score_dialog.dart';
import 'package:math_champion/Widgets/timer_widget.dart';

class SingleplayerScreen extends StatefulWidget {
  SingleplayerScreen(this.hardGame, {Key? key}) : super(key: key);

  bool hardGame;

  int timeToStart = 3;
  bool isScoreShowing = false, isTheEnd = false;
  GameEngine game = GameEngine();
  Map<String, Object> map = {};

  @override
  State<SingleplayerScreen> createState() => _SingleplayerScreenState();
}

class _SingleplayerScreenState extends State<SingleplayerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _loseGameController;
  List<Animation> cardAnswer = [];
  //int correctAnswer = -1;

  Future<void> timeDecrementation() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    setState(() {
      widget.timeToStart--;
    });
  }

  void selectAnswer(int selected) {
    if (widget.isTheEnd) return;
    int correct = int.parse(widget.map['correctIndex'].toString());
    bool isHard = widget.hardGame;
    // print('$selected / $correct');
    if (correct == selected) {
      setState(() {
        widget.map = widget.game.getGameData(isHard);
      });
    } else if (!widget.isScoreShowing && selected >= 0) {
      widget.isTheEnd = true;
      widget.isScoreShowing = true;

      cardAnswer[selected] =
          ColorTween(begin: Colors.white, end: Colors.red[300])
              .animate(_loseGameController);
      cardAnswer[widget.map['correctIndex'] as int] =
          ColorTween(begin: Colors.white, end: Colors.lightGreen[700])
              .animate(_loseGameController);
      _loseGameController.forward();
      showScoreBoxAfterDuration(isHard);
    } else if (!widget.isScoreShowing) {
      widget.isTheEnd = true;
      widget.isScoreShowing = true;

      cardAnswer[widget.map['correctIndex'] as int] =
          ColorTween(begin: Colors.white, end: Colors.lightGreen[700])
              .animate(_loseGameController);
      _loseGameController.forward();
      showScoreBoxAfterDuration(isHard);
    }
  }

  Future<void> showScoreBoxAfterDuration(bool isHard) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    int score = widget.map['round'] as int;
    showDialog(
        context: context,
        builder: (ctx) => ScoreDialog(
              score,
              isHard: isHard,
            ),
        barrierDismissible: false);
  }

  @override
  void initState() {
    super.initState();
    widget.map = widget.game.getGameData(null);
    // animation controllers
    _loseGameController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    cardAnswer.add(ColorTween(begin: Colors.white, end: Colors.white)
        .animate(_loseGameController));
    cardAnswer.add(ColorTween(begin: Colors.white, end: Colors.white)
        .animate(_loseGameController));
    cardAnswer.add(ColorTween(begin: Colors.white, end: Colors.white)
        .animate(_loseGameController));
    cardAnswer.add(ColorTween(begin: Colors.white, end: Colors.white)
        .animate(_loseGameController));
  }

  @override
  void dispose() {
    super.dispose();
    _loseGameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final schemeColors = Theme.of(context).colorScheme;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: schemeColors.background,
      body: widget.timeToStart <= 0
          ? SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: _width,
                    height: 78,
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(widget.map['round'].toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontFamily: 'Ramaraja',
                            fontSize: 64)),
                  ),
                  line(_width),
                  TimerWidget(
                    selectAnswer,
                    widget.map['duration'] as int,
                    key: UniqueKey(),
                  ),
                  line(_width),
                  Container(
                    width: _width,
                    height: _height / 4,
                    color: AppColors.cardColor,
                    child: FittedBox(
                      child: Text(widget.map['task'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.onColor,
                              fontFamily: 'Ramaraja',
                              fontSize: (_height / 5))),
                    ),
                  ),
                  line(_width),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  Container(
                    width: _width - 4,
                    height: _height * 0.5,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(children: [
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: _loseGameController,
                            builder: (ctx, _) => ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  cardAnswer[0].value, BlendMode.modulate),
                              child: AnswerButton(
                                widget.map['answer0'].toString(),
                                0,
                                selectAnswer,
                              ),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _loseGameController,
                            builder: (ctx, _) => ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  cardAnswer[1].value, BlendMode.modulate),
                              child: AnswerButton(
                                widget.map['answer1'].toString(),
                                1,
                                selectAnswer,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: _loseGameController,
                            builder: (ctx, _) => ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  cardAnswer[2].value, BlendMode.modulate),
                              child: AnswerButton(
                                widget.map['answer2'].toString(),
                                2,
                                selectAnswer,
                              ),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _loseGameController,
                            builder: (ctx, _) => ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  cardAnswer[3].value, BlendMode.modulate),
                              child: AnswerButton(
                                widget.map['answer3'].toString(),
                                3,
                                selectAnswer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            )
          : FutureBuilder(
              future: timeDecrementation(),
              builder: (ctx, _) => Center(
                    child: Text(
                      widget.timeToStart.toString(),
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 100,
                        fontFamily: 'Ramaraja',
                      ),
                    ),
                  )),
    );
  }
}

class line extends StatelessWidget {
  const line(this._width, {Key? key}) : super(key: key);

  final double _width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: 0.2,
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withAlpha(20),
          boxShadow: [BoxShadow(color: AppColors.onColor.withAlpha(40))]),
    );
  }
}
