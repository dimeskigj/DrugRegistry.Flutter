import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/drug_search_screen/drug_search_screen_viewmodel.dart';
import 'package:flutter_drug_registry/widgets/drug_card.dart';
import 'package:flutter_drug_registry/widgets/search_scroll_view.dart';
import 'package:provider/provider.dart';

class DrugSearchScreen extends StatelessWidget {
  const DrugSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrugSearchScreenViewModel(),
      child: Builder(
        builder: (context) => SafeArea(
          child: Scaffold(
            body: SearchScrollView(
              results: [
                ...context.watch<DrugSearchScreenViewModel>().searchResults.map(
                      (e) => DrugCard(
                        key: Key(e.id),
                        drug: e,
                        toggleDrugBookmark: context.read<DrugSearchScreenViewModel>().toggleDrugBookmark,
                      ),
                    ),
              ],
              scrollController: context.read<DrugSearchScreenViewModel>().scrollController,
              textEditingController: context.read<DrugSearchScreenViewModel>().textEditingController,
              retryFunction: context.read<DrugSearchScreenViewModel>().retry,
              hasSearched: context.watch<DrugSearchScreenViewModel>().hasSearched,
              hasError: context.watch<DrugSearchScreenViewModel>().hasError,
              hasNoResults: context.watch<DrugSearchScreenViewModel>().hasNoResults,
              isLoading: context.watch<DrugSearchScreenViewModel>().isLoading,
              isAtEndOfResults: context.watch<DrugSearchScreenViewModel>().isAtEndOfResults,
              searchBarHintText: 'Пребарувај лекови...',
              hasNotSearchedYetBodyText: 'Пребарувајте лекови по име, генерик или состав.',
            ),
          ),
        ),
      ),
    );
  }
}