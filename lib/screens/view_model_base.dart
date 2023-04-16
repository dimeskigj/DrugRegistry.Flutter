import 'package:flutter/foundation.dart';

class ViewModelBase extends ChangeNotifier {
  ViewModelBase() {
    onInit();
    onInitAsync().then((_) => notifyListeners());
  }

  void onInit() {}

  Future<void> onInitAsync() async {}
}
