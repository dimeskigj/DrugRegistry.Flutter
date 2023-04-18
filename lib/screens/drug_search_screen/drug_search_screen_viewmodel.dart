import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/services/drug_service.dart';
import 'package:flutter_drug_registry/screens/view_model_base.dart';
import 'package:get_it/get_it.dart';

import '../../core/models/drug.dart';

class DrugSearchScreenViewModel extends ViewModelBase {
  final DrugService _drugService = GetIt.I.get<DrugService>();

  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _debounceTimeDuration = const Duration(milliseconds: 500);
  List<Drug> _searchResults = [];
  Timer? _debounce;
  String _lastQuery = '';
  int _page = 0;
  int _total = 0;
  int _pageSize = 8;
  bool _hasSearched = false;
  bool _isLoading = false;

  TextEditingController get textEditingController => _textEditingController;

  ScrollController get scrollController => _scrollController;

  List<Drug> get searchResults => _searchResults;

  bool get hasSearched => _hasSearched;

  bool get isLoading => _isLoading;

  bool get isAtEndOfResults => _hasSearched && !_isLoading && searchResults.isNotEmpty && !hasMoreResults();

  bool get hasNoResults => _hasSearched && !_isLoading && searchResults.isEmpty;

  @override
  void onInit() {
    super.onInit();
    _textEditingController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(_debounceTimeDuration, () async {
        await searchForDrugs(_textEditingController.value.text.trim());
      });
    });
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
        await loadNextPage();
      }
    });
  }

  Future<void> searchForDrugs(String query) async {
    if (query.isEmpty) {
      _lastQuery = query;
      _searchResults = [];
      _page = 1;
      _total = 0;
    } else if (query.length >= 3 && query != _lastQuery) {
      try {
        _isLoading = true;
        _hasSearched = true;
        _searchResults = [];
        notifyListeners();
        final pagedResult = await _drugService.searchDrugs(query, size: _pageSize);
        _lastQuery = query;
        _page = pagedResult.page;
        _pageSize = pagedResult.size;
        _total = pagedResult.totalCount;
        _searchResults = pagedResult.data.toList();
      } catch (e) {
        // ignored...
      } finally {
        _isLoading = false;
      }
    }
    notifyListeners();
  }

  Future<void> loadNextPage() async {
    if (_isLoading || !hasMoreResults()) return;
    try {
      _isLoading = true;
      notifyListeners();
      final pagedResult = await _drugService.searchDrugs(_lastQuery, page: _page + 1, size: _pageSize);
      _page = pagedResult.page;
      _searchResults.addAll(pagedResult.data);
    } catch (e) {
      // ignored...
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool hasMoreResults() => (_page + 1) * _pageSize < _total;

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _scrollController.dispose();
  }
}
