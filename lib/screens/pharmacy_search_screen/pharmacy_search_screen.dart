import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/pharmacy_search_screen/pharmacy_search_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class PharmacySearchScreen extends StatelessWidget {
  const PharmacySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PharmacySearchScreenViewModel(),
      child: Builder(
        builder: (context) => Container(
          color: Theme.of(context).primaryColor,
          child: const Center(
            child: Text('Pharmacy Search Screen'),
          ),
        ),
      ),
    );
  }
}