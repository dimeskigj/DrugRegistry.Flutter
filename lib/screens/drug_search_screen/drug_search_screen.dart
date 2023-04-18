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
            body: CustomScrollView(
              controller: context.read<DrugSearchScreenViewModel>().scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  floating: true,
                  snap: true,
                  pinned: false,
                  flexibleSpace: SearchBar(
                    textEditingController: context.read<DrugSearchScreenViewModel>().textEditingController,
                    hintText: 'Пребарувај лекови...',
                  ),
                ),
                // Hasn't searched yet
                if (!context.watch<DrugSearchScreenViewModel>().hasSearched)
                  const SliverToBoxAdapter(
                    child: SvgStatus(
                      assetName: 'assets/search_character.svg',
                      headline: 'Започнете со пребарување',
                      body: 'Пребарувајте лекови по име, генерик, или по состав.',
                    ),
                  ),
                // No results
                if (context.watch<DrugSearchScreenViewModel>().hasNoResults)
                  const SliverToBoxAdapter(
                    child: SvgStatus(
                      assetName: 'assets/no_results_character.svg',
                      headline: 'Нема резултати од пребарувањето',
                    ),
                  ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => DrugCard(drug: context.read<DrugSearchScreenViewModel>().searchResults[index]),
                      childCount: context.watch<DrugSearchScreenViewModel>().searchResults.length),
                ),
                // Loading indicator
                if (context.watch<DrugSearchScreenViewModel>().isLoading)
                  SliverToBoxAdapter(
                    child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(color: Theme.of(context).primaryColor, size: 50),
                    ),
                  ),
                // End of results
                if (context.watch<DrugSearchScreenViewModel>().isAtEndOfResults)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      child: Text(
                        'Крај на резултати.',
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                // Retry
                if (context.watch<DrugSearchScreenViewModel>().hasError)
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () => context.read<DrugSearchScreenViewModel>().retry(),
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.labelLarge,
                            children: [
                              const TextSpan(text: 'Се случи грешка. '),
                              TextSpan(
                                text: 'Обидете се повторно',
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).primaryColor),
                              ),
                              const TextSpan(text: '.'),
                            ],
                          ),
                        ),
                      ),
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