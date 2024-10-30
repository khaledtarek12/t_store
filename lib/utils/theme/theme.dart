import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/theme/custom/appbar_theme.dart';
import 'package:t_store/utils/theme/custom/bottom_sheet_theme.dart';
import 'package:t_store/utils/theme/custom/checkbox_theme.dart';
import 'package:t_store/utils/theme/custom/chip_theme.dart';
import 'package:t_store/utils/theme/custom/elevated_button_theme.dart';
import 'package:t_store/utils/theme/custom/outlined_button_theme.dart';
import 'package:t_store/utils/theme/custom/text_field_theme.dart';
import 'package:t_store/utils/theme/custom/text_themes.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextThemes.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppbarTheme.lightAppbarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckBoxTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFieldTheme.lightInputDecorationTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: TColors.black,
    textTheme: TTextThemes.dartTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppbarTheme.darkAppbarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckBoxTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFieldTheme.darkInputDecorationTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
  );
}
