import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/models/bookmark_type.dart';
import 'package:flutter_drug_registry/core/providers/saved_items_provider.dart';
import 'package:flutter_drug_registry/screens/saved_items_screen/saved_items_screen_viewmodel.dart';
import 'package:flutter_drug_registry/widgets/drug_card.dart';
import 'package:flutter_drug_registry/widgets/pharmacy_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../drug_details_screen/drug_details_screen.dart';

class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.pills,
                      size: 20,
                    ),
                    Container(margin: const EdgeInsets.symmetric(vertical: 5), child: const Text("Лекови")),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.hospitalUser,
                      size: 20,
                    ),
                    Container(margin: const EdgeInsets.symmetric(vertical: 5), child: const Text("Аптеки")),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: context.watch<SavedItemsScreenViewModel>().isLoading
            ? Center(
                child: LoadingAnimationWidget.prograssiveDots(color: Theme.of(context).primaryColor, size: 50),
              )
            : TabBarView(
                children: [
                  // Drugs
                  ListView(
                    children: [
                      if (context.watch<SavedItemsScreenViewModel>().hasNoSavedDrugs)
                        Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 50),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: const Icon(Icons.bookmark_rounded),
                                ),
                                const Text('Немаш зачувани лекови.'),
                              ],
                            ),
                          ),
                        ),
                      ...context.watch<SavedItemsProvider>().savedDrugs.map(
                            (drug) => DrugCard(
                              drug: drug,
                              toggleDrugBookmark: (id) =>
                                  context.read<SavedItemsScreenViewModel>().removeBookmark(id, BookmarkType.drugBookmark),
                              navigateToDrugDetailsCallback: (drug) => navigatorKey.currentState?.push(
                                MaterialPageRoute(
                                  builder: (context) => DrugDetailsScreen(drug: drug),
                                ),
                              ),
                            ),
                          ),
                    ],
                  ),
                  // Pharmacies
                  ListView(
                    children: [
                      if (context.watch<SavedItemsScreenViewModel>().hasNoSavedPharmacies)
                        Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 50),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: const Icon(Icons.bookmark_rounded),
                                ),
                                const Text(
                                  'Немаш зачувани аптеки.',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ...context.watch<SavedItemsProvider>().savedPharmacies.map(
                            (pharmacy) => PharmacyCard(
                              pharmacy: pharmacy,
                              togglePharmacyBookmark: (id) =>
                            context.read<SavedItemsScreenViewModel>().removeBookmark(id, BookmarkType.pharmacyBookmark),
                        navigateToPharmacyDetailsCallback: (_) {},
                      ),
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}