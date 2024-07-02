part of 'drug_search_bloc.dart';

sealed class DrugSearchState extends Equatable {
  const DrugSearchState();
  
  @override
  List<Object> get props => [];
}

final class DrugSearchInitial extends DrugSearchState {}
