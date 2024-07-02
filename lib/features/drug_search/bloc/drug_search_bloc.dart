import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_drug_registry/core/models/drug.dart';
import 'package:flutter_drug_registry/core/models/drug_group.dart';
import 'package:flutter_drug_registry/core/services/drug_service.dart';
import 'package:rxdart/transformers.dart';

part 'drug_search_event.dart';
part 'drug_search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

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
    await _queryDrugs(event.query, emit);
  }

  Future<void> _queryDrugs(String query, Emitter<DrugSearchState> emit) async {
    try {
      if (_lastQuery == query) return;
      _lastQuery = query;
      emit(DrugSearchLoadInProgress());
      var results = await _drugService.searchDrugs(query, size: 50);
      emit(DrugSearchLoadSuccess(drugs: results.data.toList()));
    } catch (_) {
      emit(const DrugSearchLoadFail());
    }
  }
}
