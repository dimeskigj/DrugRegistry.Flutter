import 'package:flutter_drug_registry/core/models/drug.dart';

class DrugGroup {
  final String genericName;
  final String latinName;
  final List<Drug> drugs;

  DrugGroup({
    required this.genericName,
    required this.latinName,
    required this.drugs,
  });
}
