import 'package:flutter_drug_registry/core/providers/saved_items_provider.dart';
import 'package:flutter_drug_registry/screens/view_model_base.dart';

class SavedItemsScreenViewModel extends ViewModelBase {
  late final SavedItemsProvider _savedItemsProvider;

  SavedItemsScreenViewModel(SavedItemsProvider savedItemsProvider) {
    _savedItemsProvider = savedItemsProvider;
  }
}