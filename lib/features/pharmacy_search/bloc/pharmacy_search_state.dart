part of 'pharmacy_search_bloc.dart';

sealed class PharmacySearchState extends Equatable {
  const PharmacySearchState();

  @override
  List<Object> get props => [];
}

final class PharmacySearchInitial extends PharmacySearchState {}

final class PharmacySearchLoadInProgress extends PharmacySearchState {}

final class PharmacySearchLoadFail extends PharmacySearchState {}

final class PharmacySearchLoadSuccess extends PharmacySearchState {
  const PharmacySearchLoadSuccess(this.pharmacies);

  final List<Pharmacy> pharmacies;

  @override
  List<Object> get props => [pharmacies];
}
