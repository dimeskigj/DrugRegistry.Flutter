import 'package:flutter/material.dart';

const _primaryColor = Color(0xFF0D98BA);
const _secondaryColor = Color(0xFF0D42BA);
const _backgroundColor = Color(0xFFFFFFFF);
const _scaffoldBackgroundColor = Color(0xFFF2F2F2);
const _errorColor = Color(0xFFBA2F0D);
const _textColor = Color(0xFF0D0D0D);
const _secondaryTextColor = Color(0xFF757575);

final _baseTheme = ThemeData.light();

final _colorScheme = ColorScheme.fromSeed(seedColor: _primaryColor, brightness: Brightness.light)
    .copyWith(background: _backgroundColor, error: _errorColor, secondary: _secondaryColor);

final lightTheme = ThemeData(
  primaryColor: _primaryColor,
  primaryColorLight: _primaryColor.withOpacity(0.8),
  primaryColorDark: _primaryColor.withOpacity(0.6),
  scaffoldBackgroundColor: _scaffoldBackgroundColor,
  colorScheme: _colorScheme,
  appBarTheme: AppBarTheme(
    color: _primaryColor,
    iconTheme: const IconThemeData(color: Colors.white),
    toolbarTextStyle: _baseTheme.textTheme
        .copyWith(
          titleLarge: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        )
        .bodyMedium,
    titleTextStyle: _baseTheme.textTheme
        .copyWith(
          titleLarge: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        )
        .titleLarge,
  ),
  textTheme: _baseTheme.textTheme.copyWith(
    displayLarge: _baseTheme.textTheme.displayLarge!.copyWith(color: _textColor),
    displayMedium: _baseTheme.textTheme.displayMedium!.copyWith(color: _textColor),
    displaySmall: _baseTheme.textTheme.displaySmall!.copyWith(color: _textColor),
    headlineLarge: _baseTheme.textTheme.headlineLarge!.copyWith(color: _textColor),
    headlineMedium: _baseTheme.textTheme.headlineMedium!.copyWith(color: _textColor),
    headlineSmall: _baseTheme.textTheme.headlineSmall!.copyWith(color: _textColor),
    titleLarge: _baseTheme.textTheme.titleLarge!.copyWith(color: _textColor),
    titleMedium: _baseTheme.textTheme.titleMedium!.copyWith(color: _textColor),
    titleSmall: _baseTheme.textTheme.titleSmall!.copyWith(color: _secondaryTextColor),
    bodyLarge: _baseTheme.textTheme.bodyLarge!.copyWith(color: _textColor),
    bodyMedium: _baseTheme.textTheme.bodyMedium!.copyWith(color: _textColor),
    bodySmall: _baseTheme.textTheme.bodySmall!.copyWith(color: _secondaryTextColor),
    labelLarge: _baseTheme.textTheme.labelLarge!.copyWith(color: _secondaryTextColor),
    labelMedium: _baseTheme.textTheme.labelMedium!.copyWith(color: _secondaryTextColor),
    labelSmall: _baseTheme.textTheme.labelSmall!.copyWith(color: _secondaryTextColor),
  ),
  iconTheme: const IconThemeData(color: _textColor),
  primaryIconTheme: const IconThemeData(color: Colors.white),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: _primaryColor),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: _primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: _primaryColor,
    foregroundColor: Colors.white,
  ),
  sliderTheme: _baseTheme.sliderTheme.copyWith(
    activeTrackColor: _primaryColor,
    inactiveTrackColor: _primaryColor.withOpacity(0.3),
    thumbColor: _primaryColor,
    overlayColor: _primaryColor.withOpacity(0.2),
    valueIndicatorColor: _primaryColor,
    activeTickMarkColor: _primaryColor.withOpacity(0.8),
    inactiveTickMarkColor: _primaryColor.withOpacity(0.4),
  ),
  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: _primaryColor,
    ),
    unselectedLabelColor: _secondaryTextColor,
    labelColor: _primaryColor,
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) return _primaryColor;
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) return _primaryColor;
      return null;
    }),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) return _primaryColor;
      return null;
    }),
    trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) return _primaryColor.withOpacity(0.5);
      return _primaryColor.withOpacity(0.1);
    }),
  ),
);
