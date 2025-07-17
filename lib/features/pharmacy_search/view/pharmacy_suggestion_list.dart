import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/models/pharmacy.dart';

class PharmacySuggestionList extends StatelessWidget {
  const PharmacySuggestionList({
    super.key,
    required this.pharmacies,
    required this.onTileTap,
  });

  final List<Pharmacy> pharmacies;
  final void Function(Pharmacy pharmacy) onTileTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...pharmacies
            .map(
              (pharmacy) => GestureDetector(
                onTap: () => onTileTap(pharmacy),
                child: ListTile(
                  key: Key(pharmacy.id),
                  leading: const Icon(Icons.search),
                  title: Text(pharmacy.name ?? ''),
                  subtitle: Text(pharmacy.municipality ?? ''),
                ),
              ),
            )
            .toList(),
        Container(height: 300),
      ],
    );
  }
}
