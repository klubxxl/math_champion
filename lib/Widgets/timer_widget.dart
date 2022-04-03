import 'package:flutter/material.dart';
import 'package:math_champion/Constants/colors_and_themes.dart';

class TimerWidget extends StatefulWidget {
  TimerWidget(this._endOfTime, this._duration, {Key? key}) : super(key: key);

  int _duration;
  Function _endOfTime;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _timerAnimationController;

  @override
  void initState() {
    super.initState();
    _timerAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget._duration));
    _timerAnimationController.addListener(() {
      if (_timerAnimationController.value == 1) {
        widget._endOfTime(-99);
      }
    });
    _timerAnimationController.forward();
  }

  @override
  void dispose() {
    _timerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width,
      height: 10,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 15, 15, 15),
          border: Border.all(color: Colors.black, width: 1)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedBuilder(
          animation: _timerAnimationController,
          builder: (ctx, _) {
            return Container(
              width: _width * _timerAnimationController.value,
              color: AppColors.primaryColor,
            );
          },
        ),
      ),
    );
  }
}
