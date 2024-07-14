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
                  leading: const Icon(Icons.search),
                  trailing: d.drugs.length > 1
                      ? CircleAvatar(
                          radius: 12,
                          child: Text(
                            d.drugs.length.toString(),
                          ),
                        )
                      : const SizedBox(),
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
    var orderedDrugs = Iterable.generate(drugs.length).map(
      (index) => (
        index,
        drugs[index],
      ),
    );

    var groupedDrugs = groupBy(
      orderedDrugs,
      (d) => (d.$2.genericName, d.$2.latinName),
    );

    return groupedDrugs.keys
        .sorted(
          (key1, key2) => (groupedDrugs[key1]?.first.$1 as int)
              .compareTo(groupedDrugs[key2]?.first.$1 as int),
        )
        .map((key) => groupedDrugs[key]!.map((tuple) => tuple.$2))
        .where((drugs) => drugs.isNotEmpty)
        .map(
          (drugs) => DrugGroup(
            genericName: drugs.first.genericName ?? '',
            latinName: drugs.first.latinName ?? '',
            drugs: drugs.toList(),
          ),
        )
        .where((groupedDrug) => groupedDrug.drugs.isNotEmpty)
        .toList();
  }
}
