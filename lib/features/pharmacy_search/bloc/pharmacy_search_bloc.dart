import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_drug_registry/core/models/pharmacy.dart';
import 'package:flutter_drug_registry/core/services/pharmacy_service.dart';
import 'package:flutter_drug_registry/core/utils/bloc_utils.dart';

part 'pharmacy_search_event.dart';
part 'pharmacy_search_state.dart';

class PharmacySearchBloc
    extends Bloc<PharmacySearchEvent, PharmacySearchState> {
  late final PharmacyService _pharmacyService;

  PharmacySearchBloc(
    PharmacyService? pharmacyService,
  ) : super(PharmacySearchInitial()) {
    _pharmacyService = pharmacyService ?? PharmacyService();

    on<PharmacySearchQuerySubmitted>(_onQuerySubmitted);
    on<PharmacySearchQueryChanged>(
      _onQueryChanged,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<PharamcySearchSuggestionsTapped>(_onSuggestionTapped);
  }

  Future _onQuerySubmitted(
    PharmacySearchQuerySubmitted event,
    Emitter<PharmacySearchState> emit,
  ) async {}

  Future _onQueryChanged(
    PharmacySearchQueryChanged event,
    Emitter<PharmacySearchState> emit,
  ) async {}

  void _onSuggestionTapped(
    PharamcySearchSuggestionsTapped event,
    Emitter<PharmacySearchState> emit,
  ) {}
}
