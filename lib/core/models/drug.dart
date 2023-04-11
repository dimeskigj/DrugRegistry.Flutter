import 'package:json_annotation/json_annotation.dart';

import 'issuing_type.dart';

part 'drug.g.dart';

@JsonSerializable()
class Drug {
  final String? decisionNumber;
  final String? atc;
  final String? latinName;
  final String? genericName;
  final IssuingType? issuingType;
  final String? ingredients;
  final String? packaging;
  final String? strength;
  final String? pharmaceuticalForm;
  final Uri? url;
  final Uri? manualUrl;
  final Uri? reportUrl;
  final DateTime? decisionDate;
  final DateTime? validityDate;
  final String? approvalCarrier;
  final String? manufacturer;
  final double? priceWithVat;
  final double? priceWithoutVat;
  final DateTime? lastUpdate;

  Drug({
    this.decisionNumber,
    this.atc,
    this.latinName,
    this.genericName,
    this.issuingType,
    this.ingredients,
    this.packaging,
    this.strength,
    this.pharmaceuticalForm,
    this.url,
    this.manualUrl,
    this.reportUrl,
    this.decisionDate,
    this.validityDate,
    this.approvalCarrier,
    this.manufacturer,
    this.priceWithVat,
    this.priceWithoutVat,
    this.lastUpdate,
  });

  factory Drug.fromJson(Map<String, dynamic> json) => _$DrugFromJson(json);

  Map<String, dynamic> toJson() => _$DrugToJson(this);
}
