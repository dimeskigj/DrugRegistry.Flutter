import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/services/drug_service.dart';
import 'package:flutter_drug_registry/core/services/location_service.dart';
import 'package:flutter_drug_registry/core/services/pharmacy_service.dart';
import 'package:flutter_drug_registry/screens/main_tabbed_screen/main_tabbed_screen.dart';
import 'package:flutter_drug_registry/themes/light_theme.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerLazySingleton<DrugService>(() => DrugService());
  GetIt.I.registerLazySingleton<PharmacyService>(() => PharmacyService());
  GetIt.I.registerLazySingleton<LocationService>(() => LocationService());

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const MainTabbedScreen(),
};

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      routes: routes,
      initialRoute: '/',
      navigatorKey: navigatorKey,
    );
  }
}