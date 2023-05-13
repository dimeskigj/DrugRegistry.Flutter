import 'package:flutter_drug_registry/core/models/bookmark_type.dart';
import 'package:flutter_drug_registry/core/providers/saved_items_provider.dart';
import 'package:flutter_drug_registry/core/services/drug_service.dart';
import 'package:flutter_drug_registry/core/services/shared_preferences_service.dart';
import 'package:flutter_drug_registry/screens/view_model_base.dart';
import 'package:get_it/get_it.dart';

import '../../core/services/pharmacy_service.dart';

class SavedItemsScreenViewModel extends ViewModelBase {
  final DrugService _drugService = GetIt.I.get<DrugService>();
  final PharmacyService _pharmacyService = GetIt.I.get<PharmacyService>();
  final SharedPreferencesService _sharedPreferencesService = GetIt.I.get<SharedPreferencesService>();
  late final SavedItemsProvider _savedItemsProvider;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool get hasNoSavedDrugs => !_isLoading && _savedItemsProvider.savedDrugs.isEmpty;

  bool get hasNoSavedPharmacies => !_isLoading && _savedItemsProvider.savedPharmacies.isEmpty;

  SavedItemsScreenViewModel(SavedItemsProvider savedItemsProvider) {
    _savedItemsProvider = savedItemsProvider;
  }

  @override
  Future<void> onInitAsync() async {
    try {
      _isLoading = true;
      notifyListeners();

      final savedDrugsIds = _sharedPreferencesService.getSavedDrugsIds() ?? [];
      final savedPharmaciesIds = _sharedPreferencesService.getSavedPharmaciesIds() ?? [];

      final savedDrugs = await _drugService.getDrugsByIds(savedDrugsIds);
      final savedPharmacies = await _pharmacyService.getPharmaciesByIds(savedPharmaciesIds);

      _savedItemsProvider.appendDrugs(savedDrugs);
      _savedItemsProvider.appendPharmacies(savedPharmacies);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void removeBookmark(String id, BookmarkType type) {
    switch (type) {
      case BookmarkType.drugBookmark:
        _savedItemsProvider.removeDrug(id);
        break;
      case BookmarkType.pharmacyBookmark:
        _savedItemsProvider.removePharmacy(id);
        break;
    }
  }
}
