part of 'drug_search_bloc.dart';

sealed class DrugSearchState extends Equatable {
  const DrugSearchState();

  @override
  List<Object> get props => [];
}

final class DrugSearchInitial extends DrugSearchState {
  final List<String> recentSearches;

  const DrugSearchInitial({this.recentSearches = const []});

  @override
  List<Object> get props => [recentSearches];
}

final class DrugSearchLoadInProgress extends DrugSearchState {}

final class DrugSearchLoadSuccess extends DrugSearchState {
  final List<Drug> drugs;

  const DrugSearchLoadSuccess({required this.drugs});

  @override
  List<Object> get props => [drugs];
}

final class DrugSearchLoadFail extends DrugSearchState {
  final String? message;

  const DrugSearchLoadFail({this.message});

  @override
  List<Object> get props => [message ?? ''];
}
