import 'package:flutter_drug_registry/screens/view_model_base.dart';

class MainTabbedScreenViewModel extends ViewModelBase {
  int _currentScreenIndex = 0;

  int get currentScreenIndex => _currentScreenIndex;

  void changeScreen(int index) {
    if (_currentScreenIndex == index) return;
    _currentScreenIndex = index;
    notifyListeners();
  }
}
