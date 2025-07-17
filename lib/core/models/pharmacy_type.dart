import 'package:json_annotation/json_annotation.dart';

enum PharmacyType {
  @JsonValue(0)
  pharmacyStation,
  @JsonValue(1)
  hospital,
  @JsonValue(2)
  insulin,
  @JsonValue(3)
  privateHealthInstitution,
  @JsonValue(4)
  mobilePharmacy,
}
