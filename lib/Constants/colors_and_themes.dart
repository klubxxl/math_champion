import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 255, 251, 0);
  static const Color onPrimaryColor = Color.fromARGB(255, 2, 2, 2);
  static const Color secondaryColor = Color.fromARGB(255, 255, 126, 6);
  static const Color onSecondaryColor = Color.fromARGB(255, 236, 138, 138);
  static const Color backgroundColor = Color.fromARGB(255, 22, 22, 20);
  static const Color cardColor = Color.fromARGB(255, 29, 29, 29);
  static const Color onColor = Color.fromARGB(255, 214, 214, 214);
}

abstract class AppShemes {
  static ColorScheme lightSheme = const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.onPrimaryColor,
      secondary: AppColors.secondaryColor,
      onSecondary: AppColors.onSecondaryColor,
      error: Colors.red,
      onError: Colors.black,
      background: AppColors.backgroundColor,
      onBackground: AppColors.onColor,
      surface: AppColors.cardColor,
      onSurface: AppColors.onColor);
}
