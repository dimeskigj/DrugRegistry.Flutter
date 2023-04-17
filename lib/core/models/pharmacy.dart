import 'package:flutter_drug_registry/core/models/location.dart';
import 'package:flutter_drug_registry/core/models/pharmacy_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pharmacy.g.dart';

@JsonSerializable()
class Pharmacy {
  final String id;
  final String? idNumber;
  final String? taxNumber;
  final String? code;
  final String? name;
  final String? address;
  final String? municipality;
  final String? place;
  final String? phoneNumber;
  final String? decision;
  final String? email;
  final String? pharmacists;
  final String? technicians;
  final String? comment;
  final PharmacyType? pharmacyType;
  final bool central;
  final bool active;
  final Location? location;
  final Uri? url;
  final DateTime? lastUpdate;

  Pharmacy(this.id, {
    this.idNumber,
    this.taxNumber,
    this.code,
    this.name,
    this.address,
    this.municipality,
    this.place,
    this.phoneNumber,
    this.decision,
    this.email,
    this.pharmacists,
    this.technicians,
    this.comment,
    this.pharmacyType,
    this.central = false,
    this.active = false,
    this.location,
    this.url,
    this.lastUpdate,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) => _$PharmacyFromJson(json);

  Map<String, dynamic> toJson() => _$PharmacyToJson(this);
}
