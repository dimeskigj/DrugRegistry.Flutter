import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/utils/location_utils.dart';

import '../core/models/location.dart';
import '../core/models/pharmacy.dart';

typedef BookmarkCallback = void Function(String);
typedef PharmacyCallback = void Function(Pharmacy);

const iconButtonScale = 0.8;
const iconButtonIconSize = 30.0;

class PharmacyCard extends StatelessWidget {
  final Pharmacy pharmacy;
  final Location? location;
  final BookmarkCallback togglePharmacyBookmark;
  final PharmacyCallback navigateToPharmacyDetailsCallback;

  const PharmacyCard(
      {super.key,
      required this.pharmacy,
      required this.togglePharmacyBookmark,
      required this.navigateToPharmacyDetailsCallback,
      this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => navigateToPharmacyDetailsCallback(pharmacy),
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
                                pharmacy.name ?? '',
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                pharmacy.municipality ?? '',
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
                              if (location != null && pharmacy.location != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                                  child: Text(
                                    humanizeDistanceBetweenLocationsInKm(location!, pharmacy.location!),
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              Transform.scale(
                                scale: iconButtonScale,
                                child: IconButton(
                                  style: IconButton.styleFrom(splashFactory: InkSparkle.splashFactory),
                                  splashColor:
                                      pharmacy.isBookmarked ? Theme.of(context).splashColor : Colors.orangeAccent.withOpacity(0.25),
                                  onPressed: () => togglePharmacyBookmark(pharmacy.id),
                                  tooltip: 'Зачувајте',
                                  icon: pharmacy.isBookmarked
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: const Divider(
                        thickness: 1,
                      ),
                    ),
                    Text(
                      [pharmacy.address, pharmacy.place, pharmacy.municipality].where((element) => element != null).join(', '),
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
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
