import 'dart:math';

import '../models/location.dart';

/// Calculates the distance in meters between two locations on Earth.
///
/// @param l1 The first location.
///
/// @param l2 The second location.
///
/// @return The distance in meters between the two locations.
///
/// This method uses the Haversine formula to calculate the distance between two points
/// on a sphere (in this case, the Earth) given their longitudes and latitudes.
double getDistanceBetweenLocations(Location l1, Location l2) {
  final longitude = l1.longitude,
      otherLongitude = l2.longitude,
      latitude = l1.latitude,
      otherLatitude = l2.latitude;
  final d1 = latitude * (pi / 180.0);
  final num1 = longitude * (pi / 180.0);
  final d2 = otherLatitude * (pi / 180.0);
  final num2 = otherLongitude * (pi / 180.0) - num1;
  final d3 = pow(sin((d2 - d1) / 2.0), 2.0) +
      cos(d1) * cos(d2) * pow(sin(num2 / 2.0), 2.0);

  return 6376500.0 * (2.0 * atan2(sqrt(d3), sqrt(1.0 - d3)));
}

const kmBreakpoints = [1, 5, 10];

String humanizeDistanceBetweenLocationsInKm(Location l1, Location l2) {
  final distance = getDistanceBetweenLocations(l1, l2) / 1000;
  for (var breakpoint in kmBreakpoints) {
    if (distance <= breakpoint) return "< $breakpoint km";
  }
  return "> ${kmBreakpoints.last} km";
}
