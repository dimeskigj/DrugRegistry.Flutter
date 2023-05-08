import 'package:flutter_drug_registry/core/services/shared_preferences_service.dart';
import 'package:flutter_drug_registry/screens/view_model_base.dart';
import 'package:get_it/get_it.dart';

import '../../core/providers/theme_provider.dart';

class SettingsScreenViewModel extends ViewModelBase {
  final SharedPreferencesService _sharedPreferencesService = GetIt.I.get<SharedPreferencesService>();
  late final ThemeProvider _themeProvider;

  SettingsScreenViewModel(ThemeProvider themeProvider) {
    _themeProvider = themeProvider;
  }

  bool get isLightTheme => _sharedPreferencesService.getIsLightTheme() ?? true;

  void toggleTheme(bool isLightTheme) {
    _themeProvider.setTheme(isLightTheme);
    notifyListeners();
  }
}
