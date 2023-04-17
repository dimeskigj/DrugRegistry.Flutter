import '../models/issuing_type.dart';

extension IssuingTypeExtensions on IssuingType {
  String getSymbol() {
    switch (this) {
      case IssuingType.overTheCounter:
        return 'BRp';
      case IssuingType.prescriptionOnly:
        return 'Rp';
      case IssuingType.hospitalOnly:
        return 'H';
    }
  }
}
