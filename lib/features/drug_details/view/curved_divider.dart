import 'package:flutter/material.dart';

class CurvedDivider extends StatelessWidget {
  const CurvedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: theme.scaffoldBackgroundColor,
          child: Transform.translate(
            offset: Offset.fromDirection(-0.1),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: theme.colorScheme.surface,
              ),
            ),
          ),
        ),
        Container(
          color: theme.scaffoldBackgroundColor,
          height: 10,
        ),
        Container(
          color: theme.scaffoldBackgroundColor,
          child: Transform.translate(
            offset: Offset.fromDirection(0.1),
            child: Container(
              height: 10,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                color: theme.colorScheme.surface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
