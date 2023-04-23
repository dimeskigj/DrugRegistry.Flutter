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

  String getDetails() {
    switch (this) {
      case IssuingType.overTheCounter:
        return 'Лекот може да се издава и без лекарски рецепт.';
      case IssuingType.prescriptionOnly:
        return 'Лекот може да се издава само со лекарски рецепт.';
      case IssuingType.hospitalOnly:
        return 'Лекот може да се применува само во здравствена организација.';
    }
  }
}
