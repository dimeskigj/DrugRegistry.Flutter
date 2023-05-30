import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/pharmacy_search_screen/pharmacy_search_screen_viewmodel.dart';
import 'package:flutter_drug_registry/widgets/pharmacy_card.dart';
import 'package:flutter_drug_registry/widgets/search_bar.dart' as dr_search_bar;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../widgets/diffutil_sliverlist_widget.dart';
import '../../widgets/svg_status.dart';

class PharmacySearchScreen extends StatelessWidget {
  final FocusNode searchFocusNode = FocusNode();

  PharmacySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: context.read<PharmacySearchScreenViewModel>().scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              snap: true,
              pinned: false,
              elevation: 0,
              flexibleSpace: dr_search_bar.SearchBar(
                textEditingController: context.read<PharmacySearchScreenViewModel>().textEditingController,
                hintText: 'Пребарувај аптеки...',
                focusNode: searchFocusNode,
              ),
            ),
            DiffUtilSliverList.fromKeyedWidgetList(
              children: [
                ...context.watch<PharmacySearchScreenViewModel>().searchResults.map((p) => PharmacyCard(
                    key: Key(p.id),
                    pharmacy: p,
                    location: context.read<PharmacySearchScreenViewModel>().userLocation,
                    togglePharmacyBookmark: context.read<PharmacySearchScreenViewModel>().togglePharmacyBookmark,
                    navigateToPharmacyDetailsCallback: (dynamic _) {})),
              ],
              insertAnimationDuration: const Duration(milliseconds: 250),
              insertAnimationBuilder: (context, animation, child) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              removeAnimationDuration: Duration.zero,
              removeAnimationBuilder: (context, animation, child) => child,
            ),
            // No results
            if (context.watch<PharmacySearchScreenViewModel>().hasNoResults)
              const SliverToBoxAdapter(
                child: SvgStatus(
                  assetName: 'assets/magnifying-glass-no-results.svg',
                  headline: 'Нема резултати од пребарувањето',
                ),
              ),
            // Loading indicator
            if (context.watch<PharmacySearchScreenViewModel>().isLoading)
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  child: Center(
                    child: LoadingAnimationWidget.prograssiveDots(color: Theme.of(context).primaryColor, size: 50),
                  ),
                ),
              ),
            // End of results
            if (context.watch<PharmacySearchScreenViewModel>().isAtEndOfResults)
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
            if (context.watch<PharmacySearchScreenViewModel>().hasError)
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () => context.read<PharmacySearchScreenViewModel>().retry(),
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
    );
  }
}
