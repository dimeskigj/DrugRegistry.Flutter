import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (value) => setState(() {
          currentPageIndex = value;
        }),
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.medication_rounded),
            icon: Icon(Icons.medication_outlined),
            label: 'Лекови',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.health_and_safety_rounded),
            icon: Icon(Icons.health_and_safety),
            label: 'Аптеки',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_outline),
            label: 'Зачувани',
          ),
        ],
      ),
      body: const [
        Placeholder(),
        Placeholder(),
        Placeholder(),
      ][currentPageIndex],
    );
  }
}
