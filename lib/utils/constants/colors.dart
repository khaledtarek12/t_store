import 'package:flutter/material.dart';

class TColors {
  TColors._();
//App Basics Colors
  static const Color primary = Color(0xff4b68ff);
  static const Color secondey = Color(0xffffe24b);
  static const Color accent = Color(0xff4b68ff);

  //gradient Colors
  static const Gradient linearGrident = LinearGradient(
      begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
        Color(0xffff9a9e),
        Color(0xfffad0c4),
        Color(0xfffad0c4),
      ]);

  //Text Colors
  static const Color textPrimary = Color(0xff333333);
  static const Color textSecondey = Color(0xff6c7570);
  static const Color textWhite = Colors.white;

  //Background Colors
  static const Color light = Color(0xfff6f6f6);
  static const Color dark = Color(0xff272727);
  static const Color primaryBackground = Color(0xfff3f5ff);

  //Background Containers Colors
  static const Color lightContainer = Color(0xfff6f6f6);
  static Color darkContainer = TColors.white.withOpacity(0.1);

  //Button Colors
  static const Color buttonPrimary = Color(0xff4b68ff);
  static const Color buttonSecondey = Color(0xff6c7570);
  static const Color buttonDisabled = Color(0xffc4c4c4);

  //Border Colors
  static const Color borderPrimary = Color(0xffd9d9d9);
  static const Color borderSecondey = Color(0xffE6E6E6);

  //Error And Validation Colors
  static const Color error = Color(0xffd32f2f);
  static const Color success = Color(0xff388e3c);
  static const Color warrning = Color(0xfff57c00);
  static const Color info = Color(0xff1976d2);

  //Nautral Shades
  static const Color black = Color(0xff232323);
  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color darkGrey = Color(0xff939393);
  static const Color grey = Color(0xffe0e0e0);
  static const Color softGrey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Color(0xffffffff);
}
