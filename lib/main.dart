import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/providers/theme_provider.dart';
import 'package:flutter_drug_registry/core/services/drug_service.dart';
import 'package:flutter_drug_registry/core/services/location_service.dart';
import 'package:flutter_drug_registry/core/services/pharmacy_service.dart';
import 'package:flutter_drug_registry/core/services/shared_preferences_service.dart';
import 'package:flutter_drug_registry/screens/main_tabbed_screen/main_tabbed_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

void main() async {
  GetIt.I.registerLazySingleton<DrugService>(() => DrugService());
  GetIt.I.registerLazySingleton<PharmacyService>(() => PharmacyService());
  GetIt.I.registerLazySingleton<LocationService>(() => LocationService());
  GetIt.I.registerLazySingleton<SharedPreferencesService>(() => SharedPreferencesService());

  WidgetsFlutterBinding.ensureInitialized();

  await GetIt.I.get<SharedPreferencesService>().init();

  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Builder(
        builder: (context) => MaterialApp(
          home: MainTabbedScreen(),
          theme: context.watch<ThemeProvider>().currentTheme,
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}