import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/services/drug_service.dart';
import 'package:flutter_drug_registry/screens/view_model_base.dart';
import 'package:get_it/get_it.dart';

import '../../core/models/drug.dart';

class DrugSearchScreenViewModel extends ViewModelBase {
  final DrugService _drugService = GetIt.I.get<DrugService>();

  final TextEditingController _textEditingController = TextEditingController();
  final _debounceTimeDuration = const Duration(milliseconds: 2000);
  final int _pageSize = 10;
  List<Drug> _searchResults = [];
  Timer? _debounce;
  String _lastQuery = '';
  int _page = 1;
  int _total = 0;

  get textEditingController => _textEditingController;

  get searchResults => _searchResults;

  @override
  void onInit() {
    super.onInit();
    _textEditingController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(_debounceTimeDuration, () async {
        await searchForDrugs(_textEditingController.value.text.trim());
      });
    });
  }

  Future<void> searchForDrugs(String query) async {
    if (query.length < 3) return;
    final pagedResult = await _drugService.searchDrugs(query, size: _pageSize);
    _lastQuery = query;
    _page = pagedResult.page;
    _total = pagedResult.totalCount;
    _searchResults = pagedResult.data.toList();
    notifyListeners();
  }

  Future<void> loadNextPage() async {
    if (!hasMoreResults()) return;
    final pagedResult = await _drugService.searchDrugs(_lastQuery, page: _page + 1, size: _pageSize);
    _page = pagedResult.page;
    _searchResults.addAll(pagedResult.data);
    notifyListeners();
  }

  bool hasMoreResults() => _page * _pageSize < _total;

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }
}
