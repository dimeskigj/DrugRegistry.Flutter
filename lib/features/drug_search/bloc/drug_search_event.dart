part of 'drug_search_bloc.dart';

sealed class DrugSearchEvent extends Equatable {
  const DrugSearchEvent();

  @override
  List<Object> get props => [];
}

class DrugSearchQueryChanged extends DrugSearchEvent {
  final String query;

  const DrugSearchQueryChanged({required this.query});

  @override
  List<Object> get props => [query];
}

class DrugSearchQuerySubmitted extends DrugSearchEvent {
  final String query;

  const DrugSearchQuerySubmitted({required this.query});

  @override
  List<Object> get props => [query];
}

class DrugSearchSuggestionTapped extends DrugSearchEvent {
  final DrugGroup drugGroup;

  const DrugSearchSuggestionTapped({required this.drugGroup});

  @override
  List<Object> get props => [drugGroup];
}

class DrugSearchDrugTapped extends DrugSearchEvent {
  final Drug drug;

  const DrugSearchDrugTapped({required this.drug});

  @override
  List<Object> get props => [drug.id];
}
