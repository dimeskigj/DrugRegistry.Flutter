import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/screens/drug_search_screen/drug_search_screen.dart';
import 'package:flutter_drug_registry/screens/main_tabbed_screen/main_tabbed_screen_viewmodel.dart';
import 'package:flutter_drug_registry/screens/pharmacy_search_screen/pharmacy_search_screen.dart';
import 'package:flutter_drug_registry/screens/saved_items_screen/saved_items_screen.dart';
import 'package:flutter_drug_registry/screens/settings_screen/settings_screen_viewmodel.dart';
import 'package:flutter_drug_registry/widgets/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../settings_screen/settings_screen.dart';

class MainTabbedScreen extends StatelessWidget {
  const MainTabbedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainTabbedScreenViewModel(),
      child: Builder(
        builder: (context) => Scaffold(
          body: [
            const DrugSearchScreen(),
            const PharmacySearchScreen(),
            const SavedItemsScreen(),
            const SettingsScreen(),
          ][context.watch<MainTabbedScreenViewModel>().currentScreenIndex],
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: context.watch<MainTabbedScreenViewModel>().currentScreenIndex,
            onTap: (index) => context.read<MainTabbedScreenViewModel>().changeScreen(index),
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.4),
            duration: const Duration(milliseconds: 200),
            items: [
              SalomonBottomBarItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.pills,
                    size: 32,
                  ),
                  title: const Text('Лекови')),
              SalomonBottomBarItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.hospitalUser,
                    size: 32,
                  ),
                  title: const Text('Аптеки')),
              SalomonBottomBarItem(
                  icon: const Icon(
                    Icons.bookmark,
                    size: 32,
                  ),
                  title: const Text('Зачувани')),
              SalomonBottomBarItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.gear,
                    size: 32,
                  ),
                  title: const Text('Поставки')),
            ],
          ),
        ),
      ),
    );
  }
}
