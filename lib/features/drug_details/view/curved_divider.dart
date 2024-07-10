import 'package:flutter/material.dart';

class CurvedDivider extends StatelessWidget {
  const CurvedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: theme.colorScheme.surface,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
              color: theme.colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
