import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/models/drug.dart';
import 'package:flutter_drug_registry/core/models/drug_group.dart';

class DrugSuggestionList extends StatelessWidget {
  const DrugSuggestionList({
    super.key,
    required this.drugs,
    required this.onTileTap,
  });

  final List<Drug> drugs;
  final void Function(DrugGroup d) onTileTap;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ..._groupDrugs(drugs)
            .map(
              (d) => GestureDetector(
                onTap: () => onTileTap(d),
                child: ListTile(
                  key: Key(d.genericName + d.latinName),
                  title: Text(
                    d.latinName,
                  ),
                  subtitle: Text(
                    d.genericName,
                  ),
                ),
              ),
            )
            .toList(),
        Container(
          height: 300,
        ),
      ],
    );
  }

  List<DrugGroup> _groupDrugs(List<Drug> drugs) {
    var groupedDrugs = groupBy(drugs, (d) => (d.genericName, d.latinName));

    return groupedDrugs.keys
        .map(
          (key) => DrugGroup(
            genericName: key.$1 ?? '',
            latinName: key.$2 ?? '',
            drugs: groupedDrugs[key] ?? [],
          ),
        )
        .where((groupedDrug) => groupedDrug.drugs.isNotEmpty)
        .toList();
  }
}
