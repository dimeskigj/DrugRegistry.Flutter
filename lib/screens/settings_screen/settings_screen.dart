import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/settings_screen/settings_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поставки'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Тема',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      'Уклучи светла тема',
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
                    Switch(
                      value: context.watch<SettingsScreenViewModel>().isLightTheme,
                      onChanged: (value) => context.read<SettingsScreenViewModel>().toggleTheme(value),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
