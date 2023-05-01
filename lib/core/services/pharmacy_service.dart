import 'dart:convert';

import 'package:flutter_drug_registry/core/extensions/response_extensions.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../models/paged_result.dart';
import '../models/pharmacy.dart';

class PharmacyService {
  final Duration _timeOut = const Duration(seconds: 10);

  Future<PagedResult<Pharmacy>> searchPharmacies(String query,
      {int page = 0, int size = 10, String? municipality, String? place}) async {
    final queryParameters = {'query': query, 'page': page.toString(), 'size': size.toString()};
    if (municipality?.isNotEmpty ?? false) queryParameters['municipality'] = municipality!;
    if (place?.isNotEmpty ?? false) queryParameters['place'] = place!;
    final url = Uri.https(Constants.baseApiUrl, 'api/pharmacies/search', queryParameters);
    final response = await http.get(url).timeout(_timeOut);
    response.ensureSuccessStatusCode();
    final json = jsonDecode(response.body);
    return PagedResult<Pharmacy>.fromJson(json);
  }

  Future<PagedResult<Pharmacy>> searchPharmaciesByLocation(double latitude, double longitude,
      {int page = 0, int size = 10, String? municipality, String? place}) async {
    final queryParameters = {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'page': page.toString(),
      'size': size.toString()
    };
    if (municipality?.isNotEmpty ?? false) queryParameters['municipality'] = municipality!;
    if (place?.isNotEmpty ?? false) queryParameters['place'] = place!;
    final url = Uri.https(Constants.baseApiUrl, 'api/pharmacies/byLocation', queryParameters);
    final response = await http.get(url).timeout(_timeOut);
    response.ensureSuccessStatusCode();
    final json = jsonDecode(response.body);
    return PagedResult<Pharmacy>.fromJson(json);
  }

  Future<Iterable<String>> getMunicipalitiesByFrequency() async {
    final url = Uri.https(Constants.baseApiUrl, 'api/pharmacies/municipalitiesByFrequency');
    final response = await http.get(url).timeout(_timeOut);
    response.ensureSuccessStatusCode();
    final json = jsonDecode(response.body);
    return List<String>.from(json);
  }

  Future<Iterable<String>> getPlacesByFrequency(String municipality) async {
    final queryParameters = {'municipality': municipality};
    final url = Uri.https(Constants.baseApiUrl, 'api/pharmacies/placesByFrequency', queryParameters);
    final response = await http.get(url).timeout(_timeOut);
    response.ensureSuccessStatusCode();
    final json = jsonDecode(response.body);
    return List<String>.from(json);
  }
}
