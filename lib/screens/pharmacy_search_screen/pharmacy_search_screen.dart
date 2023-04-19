import 'package:flutter/material.dart';

class PharmacySearchScreen extends StatelessWidget {
  const PharmacySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: const Center(
        child: Text('Pharmacy Search Screen'),
      ),
    );
  }
}