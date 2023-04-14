import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/services/drug_service.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerLazySingleton<DrugService>(() => DrugService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Center(
        child: Text("Hello World!"),
      ),
    );
  }
}
