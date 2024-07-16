import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_drug_registry/core/services/shared_preferences_service.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenCubitState> {
  MainScreenCubit(
    SharedPreferencesService? sharedPreferencesService,
  ) : super(
          MainScreenInitial(),
        ) {
    _sharedPreferencesService =
        sharedPreferencesService ?? SharedPreferencesService();
  }

  late final SharedPreferencesService _sharedPreferencesService;

  void checkIsFirstTime() {
    var isFirstTime = _sharedPreferencesService.getIsFirstTime() ?? true;

    if (!isFirstTime) return;

    emit(MainScreenFirstTime());
    emit(MainScreenInitial());
  }

  Future<void> confirmFirstTimeDialog() async {
    await _sharedPreferencesService.setIsFirstTime(false);
  }
}
