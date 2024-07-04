import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drug_registry/features/drug_search/drug_search.dart';
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
      body: SafeArea(
        child: Column(
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
              dividerColor: Theme.of(context).colorScheme.onSurface,
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
                    DrugSearchInitial() => Container(),
                    DrugSearchLoadInProgress() => const Align(
                        alignment: Alignment.topCenter,
                        child: LinearProgressIndicator(),
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
                    DrugSearchLoadFail() => Container(),
                  },
                );
              },
              suggestionsBuilder: (_, __) => [],
            ),
            Expanded(
              child: BlocBuilder<DrugSearchBloc, DrugSearchState>(
                builder: (context, state) => switch (state) {
                  DrugSearchInitial() => Container(),
                  DrugSearchLoadInProgress() => const Align(
                      alignment: Alignment.topCenter,
                      child: LinearProgressIndicator(),
                    ),
                  DrugSearchLoadSuccess() => DrugSuggestionList(
                      drugs: state.drugs,
                      onTileTap: (d) {},
                    ),
                  DrugSearchLoadFail() => Container(),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
