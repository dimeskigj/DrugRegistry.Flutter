// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';

class DrugRegistryBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('#### BLOC #### onEvent $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('#### BLOC #### onChange $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('#### BLOC #### onTransition $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('#### BLOC #### onError $error');
    super.onError(bloc, error, stackTrace);
  }
}
