import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/settings_screen/settings_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsScreenViewModel(),
      child: Builder(
        builder: (context) => Container(
          color: Theme.of(context).primaryColor,
          child: const Center(
            child: Text('Settings Screen'),
          ),
        ),
      ),
    );
  }
}
