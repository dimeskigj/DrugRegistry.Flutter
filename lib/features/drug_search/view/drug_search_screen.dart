import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drug_registry/features/drug_details/view/drug_details_screen.dart';
import 'package:flutter_drug_registry/features/drug_search/bloc/drug_search_bloc.dart';
import 'package:flutter_drug_registry/features/drug_search/drug_search.dart';
import 'package:flutter_drug_registry/features/drug_search/view/drug_card.dart';
import 'package:flutter_drug_registry/features/drug_search/view/suggestion_list.dart';

class DrugSearchScreen extends StatefulWidget {
  const DrugSearchScreen({Key? key}) : super(key: key);

  @override
  State<DrugSearchScreen> createState() => _DrugSearchScreenState();
}

class _DrugSearchScreenState extends State<DrugSearchScreen> {
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
    final drugSearchBloc = context.read<DrugSearchBloc>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SearchAnchor(
              searchController: _searchController,
              viewOnChanged: (value) =>
                  drugSearchBloc.add(DrugSearchQueryChanged(query: value)),
              viewOnSubmitted: (value) {
                drugSearchBloc.add(DrugSearchQuerySubmitted(query: value));
                _searchController.closeView(null);
                _focusNode.unfocus();
              },
              viewLeading: IconButton(
                onPressed: () {
                  _searchController.closeView(null);
                  _focusNode.unfocus();
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              dividerColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              builder: (_, __) {
                return Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SearchBar(
                      hintText: "Пребарувај лекови",
                      elevation: WidgetStateProperty.all(1),
                      focusNode: _focusNode,
                      controller: _searchController,
                      onTap: () {
                        _searchController.openView();
                      },
                      onChanged: (value) {
                        drugSearchBloc.add(DrugSearchQueryChanged(query: value));
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
                return BlocBuilder<DrugSearchBloc, DrugSearchState>(
                  builder: (context, state) => switch (state) {
                    DrugSearchLoadInProgress() => const Align(
                        alignment: Alignment.topCenter,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    DrugSearchLoadSuccess() => DrugSuggestionList(
                        drugs: state.drugs,
                        onTileTap: (d) {
                          drugSearchBloc.add(
                            DrugSearchSuggestionTapped(drugGroup: d),
                          );
                          _searchController.closeView(null);
                          _searchController.text = d.latinName;
                          _focusNode.unfocus();

                          if (d.drugs.length == 1) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DrugDetailsScreen(
                                  drug: d.drugs.first,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    _ => Container(),
                  },
                );
              },
              suggestionsBuilder: (_, __) => [],
            ),
            BlocBuilder<DrugSearchBloc, DrugSearchState>(
              builder: (_, state) => switch (state) {
                DrugSearchLoadInProgress() => const Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                DrugSearchLoadFail() => const Align(
                    alignment: Alignment.topCenter,
                    child: Text('Нешто тргна наопаку, пробај пак...'),
                  ),
                DrugSearchLoadSuccess() => state.drugs.isEmpty
                    ? const Align(
                        alignment: Alignment.topCenter,
                        child: Text('Нема резултат од пребарувањето.'),
                      )
                    : Expanded(
                        child: ListView(
                          children: [
                            ...state.drugs
                                .map(
                                  (drug) => Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 16,
                                    ),
                                    child: DrugCard(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => DrugDetailsScreen(
                                            drug: drug,
                                          ),
                                        ),
                                      ),
                                      drug: drug,
                                    ),
                                  ),
                                )
                                .toList(),
                            Container(
                              height: 100,
                            ),
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
