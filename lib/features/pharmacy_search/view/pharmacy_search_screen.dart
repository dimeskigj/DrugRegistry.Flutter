import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drug_registry/features/pharmacy_details/pharmacy_deatils.dart';
import 'package:flutter_drug_registry/features/pharmacy_search/bloc/pharmacy_search_bloc.dart';
import 'package:flutter_drug_registry/features/pharmacy_search/pharmacy_search.dart';
import 'package:flutter_drug_registry/features/pharmacy_search/view/pharmacy_card.dart';
import 'package:flutter_drug_registry/features/pharmacy_search/view/pharmacy_suggestion_list.dart';

class PharmacySearchScreen extends StatefulWidget {
  const PharmacySearchScreen({super.key});

  @override
  State<PharmacySearchScreen> createState() => _PharmacySearchScreenState();
}

class _PharmacySearchScreenState extends State<PharmacySearchScreen> {
  final _searchController = SearchController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pharmacySearchBloc = context.read<PharmacySearchBloc>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SearchAnchor(
              searchController: _searchController,
              viewOnChanged:
                  (value) =>
                      pharmacySearchBloc.add(PharmacySearchQueryChanged(value)),
              viewOnSubmitted: (value) {
                pharmacySearchBloc.add(PharmacySearchQuerySubmitted(value));
                _searchController.closeView(null);
                _focusNode.unfocus();
              },
              viewLeading: IconButton(
                onPressed: () {
                  _searchController.closeView(null);
                  _focusNode.unfocus();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              dividerColor: Theme.of(
                context,
              ).colorScheme.onSurface.withOpacity(0.5),
              builder: (_, __) {
                return Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SearchBar(
                      hintText: "Пребарувај аптеки",
                      elevation: WidgetStateProperty.all(1),
                      focusNode: _focusNode,
                      controller: _searchController,
                      onTap: () {
                        _searchController.openView();
                      },
                      onChanged: (query) {
                        pharmacySearchBloc.add(
                          PharmacySearchQueryChanged(query),
                        );
                        _searchController.openView();
                      },
                      leading: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.search),
                      ),
                    ),
                  ),
                );
              },
              viewBuilder: (_) {
                return BlocBuilder<PharmacySearchBloc, PharmacySearchState>(
                  builder:
                      (context, state) => switch (state) {
                        PharmacySearchLoadInProgress() => const Align(
                          alignment: Alignment.topCenter,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        PharmacySearchLoadSuccess() => PharmacySuggestionList(
                          pharmacies: state.pharmacies,
                          onTileTap: (pharmacy) {
                            pharmacySearchBloc.add(
                              PharmacySearchSuggestionTapped(pharmacy),
                            );
                            _searchController.closeView(null);
                            _searchController.text = pharmacy.name ?? '';
                            _focusNode.unfocus();

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (_) => PharmacyDetailsScreen(
                                      pharmacy: pharmacy,
                                    ),
                              ),
                            );
                          },
                        ),
                        _ => Container(),
                      },
                );
              },
              suggestionsBuilder: (_, __) => [],
            ),
            BlocBuilder<PharmacySearchBloc, PharmacySearchState>(
              builder:
                  (_, state) => switch (state) {
                    PharmacySearchLoadFail() => const Align(
                      alignment: Alignment.topCenter,
                      child: Text('Нешто тргна наопаку, пробај пак...'),
                    ),
                    PharmacySearchLoadInProgress() => const Align(
                      alignment: Alignment.topCenter,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    PharmacySearchLoadSuccess() =>
                      state.pharmacies.isEmpty
                          ? const Align(
                            alignment: Alignment.topCenter,
                            child: Text('Нема резултат од пребарувањето.'),
                          )
                          : Expanded(
                            child: ListView(
                              children: [
                                ...state.pharmacies
                                    .map(
                                      (pharmacy) => Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 16,
                                        ),
                                        child: PharmacyCard(
                                          onTap:
                                              () => Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (_) =>
                                                          PharmacyDetailsScreen(
                                                            pharmacy: pharmacy,
                                                          ),
                                                ),
                                              ),
                                          pharmacy: pharmacy,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                Container(height: 100),
                              ],
                            ),
                          ),
                    _ => Container(),
                  },
            ),
          ],
        ),
      ),
    );
  }
}
