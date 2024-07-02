import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/models/drug.dart';

class DrugSuggestionList extends StatelessWidget {
  const DrugSuggestionList({super.key, required this.drugs});

  final List<Drug> drugs;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: drugs
          .map(
            (d) => ListTile(
              title: Text(
                d.latinName ?? '',
              ),
            ),
          )
          .toList(),
    );
  }
}
