import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/extensions/issuing_type_extensions.dart';

import '../core/models/drug.dart';
import '../core/models/issuing_type.dart';

typedef BookmarkCallback = void Function(String);
typedef DrugCallback = void Function(Drug);

const iconButtonScale = 0.8;
const iconButtonIconSize = 30.0;

class DrugCard extends StatelessWidget {
  final Drug drug;
  final BookmarkCallback toggleDrugBookmark;
  final DrugCallback navigateToDrugDetailsCallback;

  const DrugCard({super.key, required this.drug, required this.toggleDrugBookmark, required this.navigateToDrugDetailsCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => navigateToDrugDetailsCallback(drug),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                drug.latinName ?? '',
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                drug.genericName ?? '',
                                maxLines: 3,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(iconButtonIconSize / 2 * iconButtonScale, 0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
                                radius: 11,
                                child: Text(
                                  (drug.issuingType ?? IssuingType.prescriptionOnly).getSymbol(),
                                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 10),
                                ),
                              ),
                              Transform.scale(
                                scale: iconButtonScale,
                                child: IconButton(
                                  style: IconButton.styleFrom(splashFactory: InkSparkle.splashFactory),
                                  splashColor:
                                      drug.isBookmarked ? Theme.of(context).splashColor : Colors.orangeAccent.withOpacity(0.25),
                                  onPressed: () => toggleDrugBookmark(drug.id),
                                  tooltip: 'Зачувајте',
                                  icon: drug.isBookmarked
                                      ? const Icon(
                                          Icons.bookmark_rounded,
                                          size: iconButtonIconSize,
                                          color: Colors.orangeAccent,
                                        )
                                      : Icon(
                                          Icons.bookmark_border_rounded,
                                          size: iconButtonIconSize,
                                          color: Colors.grey.shade400,
                                        ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: const Divider(
                          thickness: 1,
                        )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        drug.packaging ?? '',
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      drug.manufacturer ?? '',
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
