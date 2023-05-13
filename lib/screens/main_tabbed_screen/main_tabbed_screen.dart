import 'package:flutter/material.dart';
import 'package:flutter_drug_registry/core/providers/saved_items_provider.dart';
import 'package:flutter_drug_registry/screens/drug_search_screen/drug_search_screen.dart';
import 'package:flutter_drug_registry/screens/drug_search_screen/drug_search_screen_viewmodel.dart';
import 'package:flutter_drug_registry/screens/main_tabbed_screen/main_tabbed_screen_viewmodel.dart';
import 'package:flutter_drug_registry/screens/pharmacy_search_screen/pharmacy_search_screen.dart';
import 'package:flutter_drug_registry/screens/pharmacy_search_screen/pharmacy_search_screen_viewmodel.dart';
import 'package:flutter_drug_registry/screens/saved_items_screen/saved_items_screen.dart';
import 'package:flutter_drug_registry/screens/settings_screen/settings_screen_viewmodel.dart';
import 'package:flutter_drug_registry/widgets/salomon_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/providers/theme_provider.dart';
import '../settings_screen/settings_screen.dart';

class MainTabbedScreen extends StatelessWidget {
  final FocusNode _drugSearchFocusNode = FocusNode();

  MainTabbedScreen({super.key});

  void requestFocusForIndex(int index) {
    if (index == 0) {
      _drugSearchFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainTabbedScreenViewModel()),
        ChangeNotifierProvider(create: (_) => DrugSearchScreenViewModel(Provider.of<SavedItemsProvider>(context, listen: false))),
        ChangeNotifierProvider(create: (_) => PharmacySearchScreenViewModel(Provider.of<SavedItemsProvider>(context, listen: false))),
        ChangeNotifierProxyProvider<ThemeProvider, SettingsScreenViewModel>(
          update: (_, themeProvider, previousViewModel) => SettingsScreenViewModel(themeProvider),
          create: (context) => SettingsScreenViewModel(Provider.of<ThemeProvider>(context, listen: false)),
        ),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          body: [
            DrugSearchScreen(searchFocusNode: _drugSearchFocusNode),
            PharmacySearchScreen(),
            const SavedItemsScreen(),
            const SettingsScreen(),
          ][context.watch<MainTabbedScreenViewModel>().currentScreenIndex],
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: context.watch<MainTabbedScreenViewModel>().currentScreenIndex,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.4),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            onTap: (index) => {
              if (index == context.read<MainTabbedScreenViewModel>().currentScreenIndex)
                requestFocusForIndex(index)
              else
                context.read<MainTabbedScreenViewModel>().changeScreen(index)
            },
            onLongPress: (index) {
              context.read<MainTabbedScreenViewModel>().changeScreen(index);
              requestFocusForIndex(index);
            },
            items: [
              SalomonBottomBarItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.pills,
                    size: 24,
                  ),
                  title: const Text('Лекови')),
              SalomonBottomBarItem(
                  icon: const FaIcon(
                    FontAwesomeIcons.hospitalUser,
                    size: 24,
                  ),
                  title: const Text('Аптеки')),
              SalomonBottomBarItem(
                  icon: const Icon(
                    Icons.bookmark,
                    size: 24,
                  ),
                  title: const Text('Зачувани')),
              SalomonBottomBarItem(
                  icon: const Icon(
                    Icons.settings,
                    size: 24,
                  ),
                  title: const Text('Поставки')),
            ],
          ),
        ),
      ),
    );
  }
}
