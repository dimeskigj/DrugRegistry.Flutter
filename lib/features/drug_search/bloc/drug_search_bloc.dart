import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_drug_registry/core/models/drug.dart';
import 'package:flutter_drug_registry/core/models/drug_group.dart';
import 'package:flutter_drug_registry/core/services/drug_service.dart';
import 'package:flutter_drug_registry/core/utils/bloc_utils.dart';

part 'drug_search_event.dart';
part 'drug_search_state.dart';

class DrugSearchBloc extends Bloc<DrugSearchEvent, DrugSearchState> {
  late final DrugService _drugService;
  String _lastQuery = '';

  DrugSearchBloc(DrugService? drugService) : super(DrugSearchInitial()) {
    _drugService = drugService ?? DrugService();

    on<DrugSearchQuerySubmitted>(_onDrugSearchQuerySubmitted);
    on<DrugSearchQueryChanged>(
      _onDrugSearchQueryChanged,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<DrugSearchSuggestionTapped>(_onDrugSearchSuggestionTapped);
  }

  Future<void> _onDrugSearchQueryChanged(
    DrugSearchQueryChanged event,
    Emitter<DrugSearchState> emit,
  ) async {
    await _queryDrugs(event.query, emit);
  }

  Future<void> _onDrugSearchQuerySubmitted(
    DrugSearchQuerySubmitted event,
    Emitter<DrugSearchState> emit,
  ) async {
    await _queryDrugs(event.query, emit, shouldReQuery: true);
  }

  Future<void> _queryDrugs(
    String query,
    Emitter<DrugSearchState> emit, {
    bool shouldReQuery = false,
  }) async {
    try {
      if (_lastQuery == query && !shouldReQuery) return;
      _lastQuery = query;

      if (query == '') {
        emit(const DrugSearchLoadSuccess(drugs: []));
        return;
      }

      emit(DrugSearchLoadInProgress());
      var results = await _drugService.searchDrugs(query, size: 50);
      emit(DrugSearchLoadSuccess(drugs: results.data.toList()));
    } catch (_) {
      emit(const DrugSearchLoadFail());
    }
  }

  void _onDrugSearchSuggestionTapped(
    DrugSearchSuggestionTapped event,
    Emitter<DrugSearchState> emit,
  ) {
    emit(DrugSearchLoadSuccess(drugs: event.drugGroup.drugs));
  }
}
