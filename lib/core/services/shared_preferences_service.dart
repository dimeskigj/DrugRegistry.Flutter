import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'theme';

class SharedPreferencesService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool? getIsLightTheme() => _prefs.get(_themeKey) as bool?;

  Future setIsLightTheme(bool value) async => await _prefs.setBool(_themeKey, value);
}
