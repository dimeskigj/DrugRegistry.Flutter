import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/saved_items_screen/saved_items_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SavedItemsScreenViewModel(),
      child: Builder(
        builder: (context) => Container(
          color: Theme.of(context).primaryColor,
          child: const Center(
            child: Text('Saved Items Screen'),
          ),
        ),
      ),
    );
  }
}