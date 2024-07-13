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
  String _lastQuery = '';

  PharmacySearchBloc(
    PharmacyService? pharmacyService,
  ) : super(PharmacySearchInitial()) {
    _pharmacyService = pharmacyService ?? PharmacyService();

    on<PharmacySearchQuerySubmitted>(_onQuerySubmitted);
    on<PharmacySearchQueryChanged>(
      _onQueryChanged,
      transformer: debounce(
        const Duration(
          milliseconds: 300,
        ),
      ),
    );
    on<PharmacySearchSuggestionTapped>(_onSuggestionTapped);
  }

  Future<void> _onQuerySubmitted(
    PharmacySearchQuerySubmitted event,
    Emitter<PharmacySearchState> emit,
  ) async {
    await _queryPharmacies(event.query, emit);
  }

  Future<void> _onQueryChanged(
    PharmacySearchQueryChanged event,
    Emitter<PharmacySearchState> emit,
  ) async {
    await _queryPharmacies(event.query, emit);
  }

  void _onSuggestionTapped(
    PharmacySearchSuggestionTapped event,
    Emitter<PharmacySearchState> emit,
  ) {
    emit(PharmacySearchLoadSuccess([event.pharmacy]));
  }

  Future<void> _queryPharmacies(
      String query, Emitter<PharmacySearchState> emit) async {
    try {
      if (_lastQuery == query) return;
      _lastQuery = query;

      if (query == '') {
        emit(const PharmacySearchLoadSuccess([]));
        return;
      }

      emit(PharmacySearchLoadInProgress());
      var results = await _pharmacyService.searchPharmacies(query, size: 50);
      emit(PharmacySearchLoadSuccess(results.data.toList()));
    } catch (_) {
      emit(PharmacySearchLoadFail());
    }
  }
}
