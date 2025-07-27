import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_drug_registry/core/models/pharmacy.dart';
import 'package:flutter_drug_registry/core/services/pharmacy_service.dart';
import 'package:flutter_drug_registry/core/services/shared_preferences_service.dart';
import 'package:flutter_drug_registry/core/utils/bloc_utils.dart';

part 'pharmacy_search_event.dart';
part 'pharmacy_search_state.dart';

class PharmacySearchBloc
    extends Bloc<PharmacySearchEvent, PharmacySearchState> {
  late final PharmacyService _pharmacyService;
  late final SharedPreferencesService _sharedPreferencesService;
  String _lastQuery = '';
  List<String> _recentSearches = [];

  PharmacySearchBloc(
    PharmacyService? pharmacyService,
    SharedPreferencesService? sharedPreferencesService,
  ) : super(const PharmacySearchInitial()) {
    _pharmacyService = pharmacyService ?? PharmacyService();
    _sharedPreferencesService =
        sharedPreferencesService ?? SharedPreferencesService();

    on<PharmacySearchInitialized>(_onPharmacySearchScreenInitialized);
    on<PharmacySearchQuerySubmitted>(_onQuerySubmitted);
    on<PharmacySearchQueryChanged>(
      _onQueryChanged,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<PharmacySearchSuggestionTapped>(_onSuggestionTapped);
  }

  Future<void> _onPharmacySearchScreenInitialized(
    PharmacySearchInitialized event,
    Emitter<PharmacySearchState> emit,
  ) async {
    var sharedPreferencesRecentSearches =
        _sharedPreferencesService.getRecentPharmacySearches() ?? [];

    if (sharedPreferencesRecentSearches.equals(_recentSearches)) return;

    _recentSearches = sharedPreferencesRecentSearches;
    emit(PharmacySearchInitial(recentSearches: _recentSearches));
  }

  Future<void> _onQuerySubmitted(
    PharmacySearchQuerySubmitted event,
    Emitter<PharmacySearchState> emit,
  ) async {
    await _queryPharmacies(event.query, emit, shouldReQuery: true);
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
    updateRecentSearches(query: event.pharmacy.name?.toLowerCase() ?? '');
  }

  Future<void> _queryPharmacies(
    String query,
    Emitter<PharmacySearchState> emit, {
    bool shouldReQuery = false,
  }) async {
    try {
      if (_lastQuery == query && !shouldReQuery) return;
      _lastQuery = query;

      if (query == '') {
        emit(const PharmacySearchLoadSuccess([]));
        return;
      }

      emit(PharmacySearchLoadInProgress());
      var results = await _pharmacyService.searchPharmacies(query, size: 50);
      emit(PharmacySearchLoadSuccess(results.data.toList()));

      if (shouldReQuery && results.data.isNotEmpty) {
        await updateRecentSearches(query: query);
      }
    } catch (_) {
      emit(PharmacySearchLoadFail());
    }
  }

  Future<void> updateRecentSearches({String query = ''}) async {
    if (query.isEmpty) return;

    _recentSearches.remove(query);
    _recentSearches.insert(0, query);

    if (_recentSearches.length > 5) {
      _recentSearches = _recentSearches.take(5).toList();
    }

    await _sharedPreferencesService.setRecentPharmacySearches(_recentSearches);
  }
}
