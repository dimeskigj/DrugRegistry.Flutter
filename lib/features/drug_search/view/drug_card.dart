import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/models/drug.dart';

class DrugCard extends StatelessWidget {
  const DrugCard({super.key, required this.drug, required this.onTap});

  final Drug drug;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: Key(drug.id),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: theme.colorScheme.onSurface.withValues(alpha: .1),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.medication_rounded, color: theme.primaryColor),
                  const SizedBox(width: 8),
                  Expanded(
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
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Divider(color: theme.colorScheme.onSurface.withValues(alpha: .2)),
              const SizedBox(height: 6),
              Text(
                "${drug.packaging!} ${drug.pharmaceuticalForm!}",
                style: theme.textTheme.labelMedium,
              ),
              Container(height: 10),
              Text(drug.manufacturer!, style: theme.textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
