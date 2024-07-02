import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_drug_registry/features/drug_search/drug_search.dart';
import 'package:flutter_drug_registry/features/drug_search/view/suggestion_list.dart';

class DrugSearchScreen extends StatelessWidget {
  const DrugSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchAnchor(
                viewOnChanged: (value) => context
                    .read<DrugSearchBloc>()
                    .add(DrugSearchQueryChanged(query: value)),
                viewOnSubmitted: (value) => context
                    .read<DrugSearchBloc>()
                    .add(DrugSearchQuerySubmitted(query: value)),
                builder: (
                  _,
                  SearchController controller,
                ) {
                  return SearchBar(
                    hintText: "Пребарувај лекови",
                    elevation: WidgetStateProperty.all(1),
                    controller: controller,
                    onTap: () {
                      controller.openView();
                    },
                    leading: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.search),
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
                      DrugSearchLoadSuccess() =>
                        DrugSuggestionList(drugs: state.drugs),
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
                    DrugSearchLoadSuccess() =>
                      DrugSuggestionList(drugs: state.drugs),
                    DrugSearchLoadFail() => Container(),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
