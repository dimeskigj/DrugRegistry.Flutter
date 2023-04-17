import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/drug_search_screen/drug_search_screen_viewmodel.dart';
import 'package:flutter_drug_registry/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import '../../widgets/drug_card.dart';

class DrugSearchScreen extends StatelessWidget {
  const DrugSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrugSearchScreenViewModel(),
      child: Builder(
        builder: (context) => SafeArea(
          child: Scaffold(
            body: Stack(alignment: AlignmentDirectional.topCenter, children: [
              ListView(
                controller: context.read<DrugSearchScreenViewModel>().scrollController,
                children: [...context.watch<DrugSearchScreenViewModel>().searchResults.map((d) => DrugCard(drug: d))],
              ),
              SearchBar(
                textEditingController: context.read<DrugSearchScreenViewModel>().textEditingController,
                hintText: 'Пребарувај лекови...',
              ),
            ]),
          ),
        ),
      ),
    );
  }
}