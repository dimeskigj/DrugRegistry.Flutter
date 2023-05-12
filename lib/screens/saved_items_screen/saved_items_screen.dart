import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.pills,
                      size: 20,
                    ),
                    Container(margin: const EdgeInsets.symmetric(vertical: 5), child: const Text("Лекови")),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.hospitalUser,
                      size: 20,
                    ),
                    Container(margin: const EdgeInsets.symmetric(vertical: 5), child: const Text("Аптеки")),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text('Drugs'),
            ),
            Center(
              child: Text('Pharmacies'),
            ),
          ],
        ),
      ),
    );
  }
}