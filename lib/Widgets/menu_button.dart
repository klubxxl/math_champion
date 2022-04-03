import 'package:flutter/material.dart';
import 'package:math_champion/Constants/colors_and_themes.dart';

class MenuButtonWidget extends StatelessWidget {
  MenuButtonWidget(
      {required this.text,
      required this.newRoutName,
      this.disabled = false,
      Key? key})
      : super(key: key);

  String text, newRoutName;
  bool disabled;

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: !disabled
                  ? AppColors.primaryColor.withGreen(150)
                  : AppColors.secondaryColor,
              blurRadius: 10),
        ]),
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).popAndPushNamed(newRoutName),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
            !disabled ? AppColors.primaryColor : AppColors.cardColor,
          )),
          child: SizedBox(
            width: _width / 8 * 5,
            height: 50,
            child: Center(
              child: FittedBox(
                child: Text(text,
                    style:
                        const TextStyle(fontSize: 52, fontFamily: 'Ramaraja')),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
