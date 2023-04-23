import 'package:flutter/material.dart';

import '../../core/models/drug.dart';

class DrugDetailsScreen extends StatelessWidget {
  final Drug drug;

  const DrugDetailsScreen({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drug.latinName ?? ''),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.open_in_new_rounded),
            tooltip: 'Одете кон lekovi.zdravstvo.gov.mk',
          ),
        ],
      ),
    );
  }
}
