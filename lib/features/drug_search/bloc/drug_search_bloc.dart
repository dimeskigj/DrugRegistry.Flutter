import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_drug_registry/core/models/drug.dart';
import 'package:flutter_drug_registry/core/models/drug_group.dart';
import 'package:flutter_drug_registry/core/services/drug_service.dart';

part 'drug_search_event.dart';
part 'drug_search_state.dart';

class DrugSearchBloc extends Bloc<DrugSearchEvent, DrugSearchState> {
  late final DrugService _drugService;

  DrugSearchBloc(DrugService? drugService) : super(DrugSearchInitial()) {
    _drugService = drugService ?? DrugService();

    on<DrugSearchQueryChanged>(_onDrugSearchQueryChanged);
    on<DrugSearchQuerySubmitted>(_onDrugSearchQuerySubmitted);
  }

  Future<void> _onDrugSearchQueryChanged(
    DrugSearchQueryChanged event,
    Emitter<DrugSearchState> emit,
  ) async {
    _queryDrugs(event.query, emit);
  }

  Future<void> _onDrugSearchQuerySubmitted(
    DrugSearchQuerySubmitted event,
    Emitter<DrugSearchState> emit,
  ) async {
    _queryDrugs(event.query, emit);
  }

  Future<void> _queryDrugs(String query, Emitter<DrugSearchState> emit) async {
    try {
      var results = await _drugService.searchDrugs(query, size: 50);
      emit(DrugSearchLoadSuccess(drugs: results.data.toList()));
    } catch (_) {
      emit(const DrugSearchLoadFail());
    }
  }
}
