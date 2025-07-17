import 'package:flutter/material.dart';

class DataPointDisplay extends StatelessWidget {
  const DataPointDisplay({
    super.key,
    required this.theme,
    required this.dataPointName,
    required this.dataPoint,
  });

  final ThemeData theme;
  final String dataPointName;
  final String dataPoint;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyMedium,
        children: [
          TextSpan(
            text: '$dataPointName: ',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: dataPoint),
        ],
      ),
    );
  }
}
