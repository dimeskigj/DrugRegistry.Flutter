import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/pharmacy_search_screen/pharmacy_search_screen_viewmodel.dart';
import 'package:flutter_drug_registry/widgets/pharmacy_card.dart';
import 'package:flutter_drug_registry/widgets/search_scroll_view.dart';
import 'package:provider/provider.dart';

class PharmacySearchScreen extends StatelessWidget {
  final FocusNode searchFocusNode = FocusNode();

  PharmacySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SearchScrollView(
          scrollController: context.read<PharmacySearchScreenViewModel>().scrollController,
          textEditingController: context.read<PharmacySearchScreenViewModel>().textEditingController,
          searchFocusNode: searchFocusNode,
          hasSearched: context.watch<PharmacySearchScreenViewModel>().hasSearched,
          hasError: context.watch<PharmacySearchScreenViewModel>().hasError,
          hasNoResults: context.watch<PharmacySearchScreenViewModel>().hasNoResults,
          isLoading: context.watch<PharmacySearchScreenViewModel>().isLoading,
          isAtEndOfResults: context.watch<PharmacySearchScreenViewModel>().isAtEndOfResults,
          retryFunction: context.read<PharmacySearchScreenViewModel>().retry,
          results: [
            ...context.watch<PharmacySearchScreenViewModel>().searchResults.map((p) => PharmacyCard(
                key: Key(p.id),
                pharmacy: p,
                location: context.read<PharmacySearchScreenViewModel>().userLocation,
                togglePharmacyBookmark: context.read<PharmacySearchScreenViewModel>().togglePharmacyBookmark,
                navigateToPharmacyDetailsCallback: (dynamic _) {})),
          ],
          searchBarHintText: 'Пребарувај аптеки...',
        ),
      ),
    );
  }
}
