import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/providers/saved_items_provider.dart';
import 'package:flutter_drug_registry/core/services/location_service.dart';
import 'package:flutter_drug_registry/core/services/shared_preferences_service.dart';
import 'package:flutter_drug_registry/screens/view_model_base.dart';
import 'package:get_it/get_it.dart';

import '../../core/models/location.dart';
import '../../core/models/paged_result.dart';
import '../../core/models/pharmacy.dart';
import '../../core/services/pharmacy_service.dart';

class PharmacySearchScreenViewModel extends ViewModelBase {
  final PharmacyService _pharmacyService = GetIt.I.get<PharmacyService>();
  final SharedPreferencesService _sharedPreferencesService = GetIt.I.get<SharedPreferencesService>();
  late final SavedItemsProvider _savedItemsProvider;

  late final double _longitude;
  late final double _latitude;
  late final Location _userLocation;
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _debounceTimeDuration = const Duration(milliseconds: 500);
  List<Pharmacy> _searchResults = [];
  Timer? _debounce;
  String _lastQuery = '';
  int _page = 0;
  int _total = 0;
  int _pageSize = 8;
  bool _hasSearched = false;
  bool _isLoading = false;
  bool _hasError = false;

  TextEditingController get textEditingController => _textEditingController;

  ScrollController get scrollController => _scrollController;

  List<Pharmacy> get searchResults => _searchResults;

  Location get userLocation => _userLocation;

  bool get hasSearched => _hasSearched;

  bool get isLoading => _isLoading;

  bool get isAtEndOfResults => _hasSearched && !_isLoading && searchResults.isNotEmpty && !hasMoreResults;

  bool get hasNoResults => _hasSearched && !_isLoading && searchResults.isEmpty && !_hasError;

  bool get hasError => _hasError;

  bool get hasMoreResults => (_page + 1) * _pageSize < _total;

  PharmacySearchScreenViewModel(SavedItemsProvider savedItemsProvider) {
    _savedItemsProvider = savedItemsProvider;
  }

  @override
  void onInit() {
    super.onInit();
    _textEditingController.addListener(() {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(_debounceTimeDuration, () async {
        await searchForPharmacies(_textEditingController.value.text.trim());
      });
    });
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
        await loadNextPage();
      }
    });
  }

  @override
  Future<void> onInitAsync() async {
    _isLoading = true;
    try {
      _userLocation = await GetIt.I.get<LocationService>().getCurrentLocation();
      _longitude = _userLocation.longitude;
      _latitude = _userLocation.latitude;
      notifyListeners();
      searchForPharmacies('');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> searchForPharmacies(String query) async {
    try {
      _hasError = false;
      _isLoading = true;
      _hasSearched = true;
      _searchResults = [];
      _lastQuery = query;
      notifyListeners();
      PagedResult<Pharmacy> pagedResult;
      if (query.isNotEmpty) {
        pagedResult = await _pharmacyService.searchPharmacies(query, size: _pageSize);
      } else {
        pagedResult = await _pharmacyService.searchPharmaciesByLocation(_latitude, _longitude, size: _pageSize);
      }
      _page = pagedResult.page;
      _pageSize = pagedResult.size;
      _total = pagedResult.totalCount;
      _searchResults = pagedResult.data.toList();
      checkBookmarks();
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadNextPage() async {
    if (_isLoading || !hasMoreResults) return;
    try {
      _hasError = false;
      _isLoading = true;
      notifyListeners();
      PagedResult<Pharmacy> pagedResult;
      if (_lastQuery.isNotEmpty) {
        pagedResult = await _pharmacyService.searchPharmacies(_lastQuery, page: _page + 1, size: _pageSize);
      } else {
        pagedResult = await _pharmacyService.searchPharmaciesByLocation(_latitude, _longitude, page: _page + 1, size: _pageSize);
      }
      _page = pagedResult.page;
      _searchResults.addAll(pagedResult.data);
      checkBookmarks();
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> retry() async {
    if (_searchResults.isEmpty) {
      await searchForPharmacies(_lastQuery);
    } else {
      await loadNextPage();
    }
  }

  void togglePharmacyBookmark(String id) {
    final pharmacyToBookmark = searchResults.firstWhere((element) => element.id == id);

    if (!pharmacyToBookmark.isBookmarked) {
      _savedItemsProvider.addPharmacy(pharmacyToBookmark);
    } else {
      _savedItemsProvider.removePharmacy(id);
    }

    pharmacyToBookmark.isBookmarked = !pharmacyToBookmark.isBookmarked;
    notifyListeners();
  }

  void checkBookmarks() {
    final savedPharmaciesIds = _sharedPreferencesService.getSavedPharmaciesIds() ?? [];
    final bookmarkedPharmacies  = searchResults.where((pharmacy) => savedPharmaciesIds.indexWhere((id) => pharmacy.id == id) >= 0);
    for (var pharmacy in bookmarkedPharmacies) {
      pharmacy.isBookmarked = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _scrollController.dispose();
  }
}
