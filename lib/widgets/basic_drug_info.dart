import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/extensions/issuing_type_extensions.dart';

import '../core/models/drug.dart';

class BasicDrugInfo extends StatelessWidget {
  final Drug drug;

  const BasicDrugInfo({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const Border(),
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              drug.latinName ?? '',
              maxLines: 3,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                "${drug.genericName}\n${drug.strength}",
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Text(drug.manufacturer ?? '',
                maxLines: 10, softWrap: true, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyLarge),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                drug.pharmaceuticalForm ?? '',
                maxLines: 10,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                drug.packaging ?? '',
                maxLines: 10,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                drug.ingredients ?? '',
                maxLines: 10,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                      radius: 12,
                      child: Text(
                        drug.issuingType?.getSymbol() ?? '',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      drug.issuingType?.getDetails() ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  )
                ],
              ),
            ),
            Wrap(
              spacing: 5,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    "${drug.priceWithoutVat.toString()} МКД со ДДВ",
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: Text(
                    "${drug.priceWithoutVat.toString()} МКД без ДДВ",
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
