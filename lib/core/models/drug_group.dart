import 'package:equatable/equatable.dart';
import 'package:flutter_drug_registry/core/models/drug.dart';

class DrugGroup extends Equatable {
  final String genericName;
  final String latinName;
  final List<Drug> drugs;

  const DrugGroup({
    required this.genericName,
    required this.latinName,
    required this.drugs,
  });

  @override
  List<Object?> get props => [genericName, latinName];
}
