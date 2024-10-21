import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final ElevatedButtonThemeData lightElevatedButtonTheme =
      //Light Theme
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: TColors.primary,
              disabledForegroundColor: Colors.grey,
              disabledBackgroundColor: Colors.grey,
              side: const BorderSide(
                color: TColors.primary,
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
              textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))));

  static final ElevatedButtonThemeData darkElevatedButtonTheme =
      //dark Theme
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: TColors.primary,
              disabledForegroundColor: Colors.grey,
              disabledBackgroundColor: Colors.grey,
              side: const BorderSide(
                color: TColors.primary,
              ),
              padding: const EdgeInsets.symmetric(vertical: 18),
              textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))));
}
