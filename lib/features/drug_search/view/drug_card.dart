import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/models/drug.dart';

class DrugCard extends StatelessWidget {
  const DrugCard({
    super.key,
    required this.drug,
    required this.onTap,
  });

  final Drug drug;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: Key(drug.id),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                drug.latinName!,
                style: theme.textTheme.titleMedium,
              ),
              Text(
                drug.genericName!,
                style: theme.textTheme.titleSmall,
              ),
              Divider(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              Text(
                "${drug.packaging!} ${drug.pharmaceuticalForm!}",
                style: theme.textTheme.labelMedium,
              ),
              Container(
                height: 10,
              ),
              Text(
                drug.manufacturer!,
                style: theme.textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
