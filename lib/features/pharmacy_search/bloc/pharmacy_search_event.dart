part of 'pharmacy_search_bloc.dart';

sealed class PharmacySearchEvent extends Equatable {
  const PharmacySearchEvent();

  @override
  List<Object> get props => [];
}

class PharmacySearchInitialized extends PharmacySearchEvent {}

class PharmacySearchQueryChanged extends PharmacySearchEvent {
  const PharmacySearchQueryChanged(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}

class PharmacySearchQuerySubmitted extends PharmacySearchEvent {
  const PharmacySearchQuerySubmitted(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}

class PharmacySearchSuggestionTapped extends PharmacySearchEvent {
  const PharmacySearchSuggestionTapped(this.pharmacy);

  final Pharmacy pharmacy;

  @override
  List<Object> get props => [];
}

class PharmacySearchPharmacyTapped extends PharmacySearchEvent {
  const PharmacySearchPharmacyTapped(this.pharmacy);

  final Pharmacy pharmacy;

  @override
  List<Object> get props => [];
}
