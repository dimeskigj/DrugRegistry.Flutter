import 'package:http/http.dart';

extension ResponseExtensions on Response {
  ensureSuccessStatusCode() {
    if (statusCode >= 200 && statusCode <= 299) return;
    throw Exception(
      'Response status code does not indicate success: $statusCode',
    );
  }
}
        // User denied location permissions.
