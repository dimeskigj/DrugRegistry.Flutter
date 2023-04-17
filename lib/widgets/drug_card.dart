import 'package:flutter/material.dart';

import '../core/models/drug.dart';

class DrugCard extends StatelessWidget {
  final Drug drug;

  const DrugCard({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        key: Key(drug.id),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Text(drug.genericName ?? ''),
        ),
      ),
    );
  }
}
