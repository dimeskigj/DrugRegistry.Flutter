import 'package:flutter/material.dart';

class DrugSearchScreen extends StatelessWidget {
  const DrugSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: const Expanded(
        child: Center(
          child: Text('Drug Search Screen'),
        ),
      ),
    );
  }
}