import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hintText;

  const SearchBar({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(50);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Material(
          elevation: 0.5,
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: TextField(
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.search_rounded),
              hintText: hintText,
              contentPadding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
              filled: true,
              fillColor: Theme.of(context).colorScheme.background,
              border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: borderRadius),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor), borderRadius: borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}
