import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/drug_search_screen/drug_search_screen_viewmodel.dart';
import 'package:flutter_drug_registry/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class DrugSearchScreen extends StatelessWidget {
  const DrugSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrugSearchScreenViewModel(),
      child: Builder(
        builder: (context) => Scaffold(
          body: Stack(alignment: AlignmentDirectional.topCenter, children: [
            Container(
              color: Theme.of(context).primaryColor,
              child: const Center(
                child: Text('Drug Search Screen'),
              ),
            ),
            SearchBar(
              textEditingController: context.read<DrugSearchScreenViewModel>().textEditingController,
              hintText: 'Пребарувај лекови...',
            ),
          ]),
        ),
      ),
    );
  }
}