import '../models/drug.dart';
import '../models/pharmacy.dart';

Map<String, dynamic> toJsonFactory<T>(Object? object) {
  if (T == Drug) {
    return (object as Drug).toJson();
  }
  if (T == Pharmacy) {
    return (object as Pharmacy).toJson();
  }
  return {};
}

T fromJsonFactory<T>(Object? json) {
  json as Map<String, dynamic>;
  if (json.containsKey('atc')) {
    // only Drug has an atc property
    return Drug.fromJson(json) as T;
  }
  if (json.containsKey('pharmacyType')) {
    // only Pharmacy has a pharmacyType property
    return Pharmacy.fromJson(json) as T;
  }
  return json as T;
}
