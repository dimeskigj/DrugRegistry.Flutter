import 'package:flutter/material.dart';

class SavedItemsScreen extends StatelessWidget {
  const SavedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: const Expanded(
        child: Center(
          child: Text('Saved Items Screen'),
        ),
      ),
    );
  }
}