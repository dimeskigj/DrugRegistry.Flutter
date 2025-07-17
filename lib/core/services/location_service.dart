import 'package:geolocator/geolocator.dart';

import '../models/location.dart';

class LocationService {
  Future<bool> _checkLocationServices() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      // Location services are disabled on the device.
      return false;
    }
    return true;
  }

  Future<bool> _checkLocationPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Location permissions are denied.
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // User denied location permissions.
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // User denied location permissions permanently.
      return false;
    }
    return true;
  }

  Future<Location> getCurrentLocation() async {
    bool locationEnabled = await _checkLocationServices();

    if (!locationEnabled) {
      return Future.error(LocationServiceDisabledException);
    }

    bool locationPermissionGranted = await _checkLocationPermissions();

    if (!locationPermissionGranted) {
      return Future.error(PermissionDeniedException);
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return Location(longitude: position.longitude, latitude: position.latitude);
  }
}
