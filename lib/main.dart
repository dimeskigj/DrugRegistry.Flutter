import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/services/drug_service.dart';
import 'package:flutter_drug_registry/core/services/location_service.dart';
import 'package:flutter_drug_registry/core/services/pharmacy_service.dart';
import 'package:flutter_drug_registry/core/services/shared_preferences_service.dart';
import 'package:flutter_drug_registry/screens/main_screen/main_screen.dart';
import 'package:get_it/get_it.dart';

void main() async {
  GetIt.I.registerLazySingleton<DrugService>(
    () => DrugService(),
  );
  GetIt.I.registerLazySingleton<PharmacyService>(
    () => PharmacyService(),
  );
  GetIt.I.registerLazySingleton<LocationService>(
    () => LocationService(),
  );
  GetIt.I.registerLazySingleton<SharedPreferencesService>(
    () => SharedPreferencesService(),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await GetIt.I.get<SharedPreferencesService>().init();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => MaterialApp(
        home: const MainScreen(),
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
            brightness: Brightness.light,
          ),
        ),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
