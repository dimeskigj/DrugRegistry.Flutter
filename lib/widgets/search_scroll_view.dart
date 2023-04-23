import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/widgets/search_bar.dart';
import 'package:flutter_drug_registry/widgets/svg_status.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'diffutil_sliverlist_widget.dart';

class SearchScrollView extends StatelessWidget {
  final ScrollController scrollController;
  final TextEditingController textEditingController;
  final FocusNode searchFocusNode;
  final bool hasSearched;
  final bool hasError;
  final bool hasNoResults;
  final bool isLoading;
  final bool isAtEndOfResults;
  final Function retryFunction;
  final String? hasNotSearchedYetBodyText;
  final String? noResultsBodyText;
  final String? searchBarHintText;
  final List<Widget> results;

  const SearchScrollView({
    super.key,
    required this.scrollController,
    required this.textEditingController,
    required this.searchFocusNode,
    required this.hasSearched,
    required this.hasError,
    required this.hasNoResults,
    required this.isLoading,
    required this.isAtEndOfResults,
    required this.retryFunction,
    this.hasNotSearchedYetBodyText,
    this.noResultsBodyText,
    this.searchBarHintText,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floating: true,
          snap: true,
          pinned: false,
          elevation: 0,
          flexibleSpace: SearchBar(
            textEditingController: textEditingController,
            hintText: searchBarHintText ?? '',
            focusNode: searchFocusNode,
          ),
        ),
        DiffUtilSliverList.fromKeyedWidgetList(
          children: results,
          insertAnimationDuration: const Duration(milliseconds: 250),
          insertAnimationBuilder: (context, animation, child) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.5, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          removeAnimationDuration: Duration.zero,
          removeAnimationBuilder: (context, animation, child) => child,
        ),
        // Hasn't searched yet
        if (!hasSearched)
          SliverToBoxAdapter(
            child: SvgStatus(
              assetName: 'assets/magnifying-glass.svg',
              headline: 'Започнете со пребарување',
              body: hasNotSearchedYetBodyText,
            ),
          ),
        // No results
        if (hasNoResults)
          SliverToBoxAdapter(
            child: SvgStatus(
              assetName: 'assets/magnifying-glass-no-results.svg',
              headline: 'Нема резултати од пребарувањето',
              body: noResultsBodyText,
            ),
          ),
        // Loading indicator
        if (isLoading)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Center(
                child: LoadingAnimationWidget.prograssiveDots(color: Theme.of(context).primaryColor, size: 50),
              ),
            ),
          ),
        // End of results
        if (isAtEndOfResults)
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
        if (hasError)
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => retryFunction(),
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
    );
  }
}
