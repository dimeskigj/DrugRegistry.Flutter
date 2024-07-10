import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/extensions/issuing_type_extensions.dart';
import 'package:flutter_drug_registry/core/models/drug.dart';
import 'package:flutter_drug_registry/features/drug_details/view/curved_divider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DrugDetailsScreen extends StatelessWidget {
  const DrugDetailsScreen({super.key, required this.drug});

  final Drug drug;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const defaultInsets = EdgeInsets.symmetric(horizontal: 20, vertical: 2);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: Text(
          drug.latinName!,
        ),
        actions: [
          if (drug.url != null)
            IconButton(
              onPressed: () => launchUrl(drug.url!),
              icon: const Icon(
                Icons.open_in_new,
              ),
            ),
        ],
      ),
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (drug.latinName != null)
              Container(
                margin: defaultInsets,
                child: Text(
                  drug.latinName!,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (drug.genericName != null)
              Container(
                margin: defaultInsets,
                child: Text(
                  drug.genericName!,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            if (drug.atc != null)
              Container(
                margin: defaultInsets,
                child: Text(
                  drug.atc!,
                  style: theme.textTheme.titleMedium,
                ),
              ),
            Container(
              margin: defaultInsets,
              child: Text(drug.issuingType?.getDetails() ?? ''),
            ),
            const CurvedDivider(),
            if (drug.pharmaceuticalForm != null)
              Container(
                margin: defaultInsets,
                child: _DrugDetail(
                  theme: theme,
                  dataPointName: 'Фармацевтска форма',
                  dataPoint: drug.pharmaceuticalForm!,
                ),
              ),
            if (drug.ingredients != null)
              Container(
                margin: defaultInsets,
                child: _DrugDetail(
                  theme: theme,
                  dataPointName: 'Состав',
                  dataPoint: drug.ingredients!,
                ),
              ),
            if (drug.packaging != null)
              Container(
                margin: defaultInsets,
                child: _DrugDetail(
                  theme: theme,
                  dataPointName: 'Пакување',
                  dataPoint: drug.packaging!,
                ),
              ),
            if (drug.strength != null)
              Container(
                margin: defaultInsets,
                child: _DrugDetail(
                  theme: theme,
                  dataPointName: 'Јачина',
                  dataPoint: drug.strength!,
                ),
              ),
            if (drug.manualUrl != null || drug.reportUrl != null)
              const CurvedDivider(),
            if (drug.manualUrl != null || drug.reportUrl != null)
              Container(
                margin: defaultInsets.copyWith(bottom: 5),
                child: Text(
                  'Документи:',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            if (drug.manualUrl != null)
              InkWell(
                onTap: () => launchUrl(drug.manualUrl!),
                child: Container(
                  margin: defaultInsets.copyWith(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.description,
                        color: theme.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Упатство за употреба',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            if (drug.reportUrl != null)
              InkWell(
                onTap: () => launchUrl(drug.reportUrl!),
                child: Container(
                  margin: defaultInsets.copyWith(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.description,
                        color: theme.primaryColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Збирен извештај',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            const CurvedDivider(),
            Container(
              margin: defaultInsets,
              child: _DrugDetail(
                theme: theme,
                dataPointName: 'Цена со ДДВ',
                dataPoint: drug.priceWithVat?.toString() ?? 'Недефинирана',
              ),
            ),
            Container(
              margin: defaultInsets,
              child: _DrugDetail(
                theme: theme,
                dataPointName: 'Цена без ДДВ',
                dataPoint: drug.priceWithoutVat?.toString() ?? 'Недефинирана',
              ),
            ),
            const CurvedDivider(),
            if (drug.manufacturer != null)
              Container(
                margin: defaultInsets,
                child: _DrugDetail(
                  theme: theme,
                  dataPointName: 'Производител',
                  dataPoint: drug.manufacturer!,
                ),
              ),
            if (drug.approvalCarrier != null)
              Container(
                margin: defaultInsets,
                child: _DrugDetail(
                  theme: theme,
                  dataPointName: 'Носител на одобрение',
                  dataPoint: drug.approvalCarrier!,
                ),
              ),
            if (drug.decisionNumber != null)
              Container(
                margin: defaultInsets,
                child: _DrugDetail(
                  theme: theme,
                  dataPointName: 'Број на одлука',
                  dataPoint: drug.decisionNumber!,
                ),
              ),
            if (drug.decisionDate != null)
              Container(
                margin: defaultInsets,
                child: _DrugDetail(
                  theme: theme,
                  dataPointName: 'Датум на одлука',
                  dataPoint: DateFormat('yyyy/MM/dd').format(
                    drug.decisionDate!,
                  ),
                ),
              ),
            if (drug.validityDate != null)
              Container(
                margin: defaultInsets,
                child: _DrugDetail(
                  theme: theme,
                  dataPointName: 'Датум на валидност',
                  dataPoint: DateFormat('yyyy/MM/dd').format(
                    drug.validityDate!,
                  ),
                ),
              ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: defaultInsets,
              child: RichText(
                text: TextSpan(
                  style: theme.textTheme.bodyMedium,
                  children: [
                    const TextSpan(
                      text:
                          'Внимание! Секогаш потврдувај ги информациите на официјалната страна на регистарот на лекови ',
                    ),
                    TextSpan(
                      text: 'lekovi.zdravstvo.gov.mk',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchUrl(drug.url!),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                    TextSpan(
                      text:
                          '. Овој лек е последно ажуриран на ${DateFormat('yyyy/MM/dd').format(drug.lastUpdate!)}.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrugDetail extends StatelessWidget {
  const _DrugDetail({
    required this.theme,
    required this.dataPointName,
    required this.dataPoint,
  });

  final ThemeData theme;
  final String dataPointName;
  final String dataPoint;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyLarge,
        children: [
          TextSpan(
            text: '$dataPointName: ',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: dataPoint,
          ),
        ],
      ),
    );
  }
}
