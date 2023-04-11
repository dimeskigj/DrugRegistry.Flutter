import 'package:json_annotation/json_annotation.dart';

enum IssuingType {
  @JsonValue(0)
  overTheCounter,
  @JsonValue(1)
  prescriptionOnly,
  @JsonValue(2)
  hospitalOnly
}
