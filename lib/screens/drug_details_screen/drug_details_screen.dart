import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/drug_details_screen/drug_details_screen_viewmodel.dart';
import 'package:flutter_drug_registry/widgets/basic_drug_info.dart';
import 'package:provider/provider.dart';

import '../../core/models/drug.dart';

class DrugDetailsScreen extends StatelessWidget {
  final Drug drug;

  const DrugDetailsScreen({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DrugDetailsScreenViewModel(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(drug.latinName ?? ''),
              actions: [
                if (drug.url != null)
                  IconButton(
                    onPressed: () => context.read<DrugDetailsScreenViewModel>().openUrl(drug.url!),
                    icon: const Icon(Icons.open_in_new_rounded),
                    tooltip: 'Одете кон lekovi.zdravstvo.gov.mk',
                  ),
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Text(
                    "Основни информации",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                BasicDrugInfo(drug: drug),
                if (drug.manualUrl != null || drug.reportUrl != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                    child: Text(
                      "Документи",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                Card(
                  shape: const Border(),
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (drug.manualUrl != null)
                        TextButton(
                          onPressed: () => context.read<DrugDetailsScreenViewModel>().openUrl(drug.manualUrl!),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.picture_as_pdf_rounded,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "Упатство за употреба",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              )
                            ],
                          ),
                        ),
                      if (drug.reportUrl != null)
                        TextButton(
                          onPressed: () => context.read<DrugDetailsScreenViewModel>().openUrl(drug.reportUrl!),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.picture_as_pdf_rounded,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  "Збирен извештај",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                  child: Text(
                    "Дополнителни информации",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Card(
                  shape: const Border(),
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: Material(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (drug.atc != null)
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "ATЦ: ",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    TextSpan(
                                      text: drug.atc,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (drug.approvalCarrier != null)
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Носител на одобрение: ",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    TextSpan(
                                      text: drug.approvalCarrier,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (drug.decisionNumber != null)
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Број на решение: ",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    TextSpan(
                                      text: drug.decisionNumber,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (drug.decisionDate != null)
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: "Датум на решение: ",
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  TextSpan(
                                    text:
                                        "${drug.decisionDate?.toUtc().day}/${drug.decisionDate?.toUtc().month}/${drug.decisionDate?.toUtc().year}",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Овој лек е последно ажуриран на ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: "${drug.lastUpdate?.toUtc().day}/${drug.lastUpdate?.toUtc().month}/${drug.lastUpdate?.toUtc().year}",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ". За најточни информации одете на ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.read<DrugDetailsScreenViewModel>().openUrl(drug.url ?? Uri()),
                          text: "lekovi.zdravstvo.gov.mk",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ".",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
