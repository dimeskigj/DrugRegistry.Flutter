import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/models/pharmacy.dart';

class PharmacyCard extends StatelessWidget {
  const PharmacyCard({super.key, required this.pharmacy, required this.onTap});

  final Pharmacy pharmacy;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      key: Key(pharmacy.id),
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
                  Icon(
                    Icons.health_and_safety_rounded,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pharmacy.name ?? 'Аптека',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          pharmacy.municipality ?? '',
                          style: theme.textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (pharmacy.address != null)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: Divider(
                    color: theme.colorScheme.onSurface.withValues(alpha: .2),
                  ),
                ),
              if (pharmacy.address != null) Text(pharmacy.address ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
