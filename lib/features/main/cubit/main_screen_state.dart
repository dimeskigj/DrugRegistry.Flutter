part of 'main_screen_cubit.dart';

sealed class MainScreenCubitState extends Equatable {
  const MainScreenCubitState();

  @override
  List<Object> get props => [];
}

final class MainScreenInitial extends MainScreenCubitState {}
final class MainScreenFirstTime extends MainScreenCubitState {}
