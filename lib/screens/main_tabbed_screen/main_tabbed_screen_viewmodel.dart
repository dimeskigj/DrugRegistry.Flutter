import 'package:flutter/material.dart';

class MainTabbedScreenViewModel extends ChangeNotifier {
  int _currentScreenIndex = 0;

  int get currentScreenIndex => _currentScreenIndex;

  void changeScreen(int index) {
    _currentScreenIndex = index;
    notifyListeners();
  }
}
