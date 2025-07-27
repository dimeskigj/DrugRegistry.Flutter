import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'theme';
const _savedDrugsKey = 'saved-drugs';
const _savedPharmaciesKey = 'saved-pharmacies';
const _isFirstTimeKey = 'is-first-time';
const _recentPharmacySearchesKey = 'recent-pharmacy-searches';
const _recentDrugSearchesKey = 'recent-drug-searches';

class SharedPreferencesService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool? getIsLightTheme() => _prefs.getBool(_themeKey);

  Future<bool> setIsLightTheme(bool value) async =>
      await _prefs.setBool(_themeKey, value);

  List<String>? getSavedDrugsIds() => _prefs.getStringList(_savedDrugsKey);

  Future<bool> setSavedDrugsIds(List<String> value) =>
      _prefs.setStringList(_savedDrugsKey, value);

  List<String>? getSavedPharmaciesIds() =>
      _prefs.getStringList(_savedPharmaciesKey);

  Future<bool> setSavedPharmaciesIds(List<String> value) =>
      _prefs.setStringList(_savedPharmaciesKey, value);

  bool? getIsFirstTime() => _prefs.getBool(_isFirstTimeKey);

  Future<bool> setIsFirstTime(bool value) async =>
      await _prefs.setBool(_isFirstTimeKey, value);

  List<String>? getRecentPharmacySearches() =>
      _prefs.getStringList(_recentPharmacySearchesKey);

  Future<bool> setRecentPharmacySearches(List<String> value) =>
      _prefs.setStringList(_recentPharmacySearchesKey, value);

  List<String>? getRecentDrugSearches() =>
      _prefs.getStringList(_recentDrugSearchesKey);

  Future<bool> setRecentDrugSearches(List<String> value) =>
      _prefs.setStringList(_recentDrugSearchesKey, value);
}
