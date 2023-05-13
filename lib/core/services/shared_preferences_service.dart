import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'theme';
const _savedDrugsKey = 'saved-drugs';
const _savedPharmaciesKey = 'saved-pharmacies';

class SharedPreferencesService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool? getIsLightTheme() => _prefs.getBool(_themeKey);

  Future<bool> setIsLightTheme(bool value) async => await _prefs.setBool(_themeKey, value);

  List<String>? getSavedDrugsIds() => _prefs.getStringList(_savedDrugsKey);

  Future<bool> setSavedDrugsIds(List<String> value) => _prefs.setStringList(_savedDrugsKey, value);

  List<String>? getSavedPharmaciesIds() => _prefs.getStringList(_savedPharmaciesKey);

  Future<bool> setSavedPharmaciesIds(List<String> value) => _prefs.setStringList(_savedPharmaciesKey, value);
}
