import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drug_registry/features/drug_details/view/drug_details_screen.dart';
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
              dividerColor:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              builder: (_, __) {
                return Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SearchBar(
                      hintText: "Пребарувај лекови",
                      onChanged: (value) {
                        drugSearchBloc.add(
                          DrugSearchQueryChanged(query: value),
                        );
                        _searchController.openView();
                      },
                      elevation: WidgetStateProperty.all(1),
                      focusNode: _focusNode,
                      controller: _searchController,
                      onTap: () {
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
                DrugSearchLoadSuccess() => Expanded(
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
