import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/services/shared_preferences_service.dart';
import 'package:get_it/get_it.dart';

import '../models/drug.dart';
import '../models/pharmacy.dart';

class SavedItemsProvider extends ChangeNotifier {
  final SharedPreferencesService _sharedPreferencesService = GetIt.I.get<SharedPreferencesService>();

  List<Drug> savedDrugs = [];
  List<Pharmacy> savedPharmacies = [];

  void setDrugs(List<Drug> drugs) {
    savedDrugs = drugs;
    notifyListeners();
  }

  void setPharmacies(List<Pharmacy> pharmacies) {
    savedPharmacies = pharmacies;
    notifyListeners();
  }

  void addDrug(Drug drug) {
    savedDrugs.add(drug);
    notifyListeners();
    unawaited(_addDrugToPreferences(drug.id));
  }

  void addPharmacy(Pharmacy pharmacy) {
    savedPharmacies.add(pharmacy);
    notifyListeners();
    unawaited(_addPharmacyToPreferences(pharmacy.id));
  }

  void removeDrug(String id) {
    savedDrugs.removeAt(savedDrugs.indexWhere((element) => element.id == id));
    notifyListeners();
    unawaited(_removeDrugFromPreferences(id));
  }

  void removePharmacy(String id) {
    savedPharmacies.removeAt(savedPharmacies.indexWhere((element) => element.id == id));
    notifyListeners();
    unawaited(_removePharmacyFromPreferences(id));
  }

  Future<void> _addDrugToPreferences(String id) async {
    final currentPrefs = _sharedPreferencesService.getSavedDrugsIds() ?? [];
    currentPrefs.add(id);
    await _sharedPreferencesService.setSavedDrugsIds(currentPrefs);
  }

  Future<void> _removeDrugFromPreferences(String id) async {
    final currentPrefs = _sharedPreferencesService.getSavedDrugsIds() ?? [];
    currentPrefs.where((currentId) => currentId != id);
    await _sharedPreferencesService.setSavedDrugsIds(currentPrefs);
  }

  Future<void> _addPharmacyToPreferences(String id) async {
    final currentPrefs = _sharedPreferencesService.getSavedPharmaciesIds() ?? [];
    currentPrefs.add(id);
    await _sharedPreferencesService.setSavedPharmaciesIds(currentPrefs);
  }

  Future<void> _removePharmacyFromPreferences(String id) async {
    final currentPrefs = _sharedPreferencesService.getSavedPharmaciesIds() ?? [];
    currentPrefs.where((currentId) => currentId != id);
    await _sharedPreferencesService.setSavedPharmaciesIds(currentPrefs);
  }
}
