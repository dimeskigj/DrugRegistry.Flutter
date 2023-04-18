import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/drug_search_screen/drug_search_screen_viewmodel.dart';
import 'package:flutter_drug_registry/widgets/search_bar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/drug_card.dart';
import '../../widgets/svg_status.dart';

class DrugSearchScreen extends StatelessWidget {
  const DrugSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrugSearchScreenViewModel(),
      child: Builder(
        builder: (context) => SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SearchBar(
                  textEditingController: context.read<DrugSearchScreenViewModel>().textEditingController,
                  hintText: 'Пребарувај лекови...',
                ),
                // Hasn't searched yet
                if (!context.watch<DrugSearchScreenViewModel>().hasSearched)
                  const SvgStatus(
                    assetName: 'assets/search_character.svg',
                    headline: 'Започнете со пребарување',
                    body: 'Пребарувајте лекови по име, генерик, или по состав.',
                  ),
                // No results
                if (context.watch<DrugSearchScreenViewModel>().hasNoResults)
                  const SvgStatus(
                    assetName: 'assets/no_results_character.svg',
                    headline: 'Нема резултати од пребарувањето',
                    body: 'Проверете дали точно сте го внеле терминот,или пак пробајте да го измените. '
                        'Ако повторно не успеете, можеби го немаме бараниот лек запишано во базата.',
                  ),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView(
                    controller: context.read<DrugSearchScreenViewModel>().scrollController,
                    children: [
                      ...context.watch<DrugSearchScreenViewModel>().searchResults.map((d) => DrugCard(drug: d)),
                      // Loading indicator
                      if (context.watch<DrugSearchScreenViewModel>().isLoading)
                        Center(
                          child: LoadingAnimationWidget.prograssiveDots(color: Theme.of(context).primaryColor, size: 50),
                        ),
                      // End of results
                      if (context.watch<DrugSearchScreenViewModel>().isAtEndOfResults)
                        Container(
                          margin: const EdgeInsets.all(12),
                          child: Text(
                            'крај на резултати',
                            style: Theme.of(context).textTheme.labelLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}