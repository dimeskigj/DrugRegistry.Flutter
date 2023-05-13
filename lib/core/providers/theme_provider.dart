import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/services/shared_preferences_service.dart';
import 'package:get_it/get_it.dart';

import '../../themes/dark_theme.dart';
import '../../themes/light_theme.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPreferencesService _sharedPreferencesService = GetIt.I.get<SharedPreferencesService>();

  ThemeData get currentTheme => (_sharedPreferencesService.getIsLightTheme() ?? true) ? lightTheme : darkTheme;

  Future<void> setTheme(bool isLightTheme) async {
    if (_sharedPreferencesService.getIsLightTheme() == isLightTheme) return;
    await _sharedPreferencesService.setIsLightTheme(isLightTheme);
    notifyListeners();
  }
}
