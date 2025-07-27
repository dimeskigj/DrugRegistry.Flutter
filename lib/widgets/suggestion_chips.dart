import 'package:flutter/material.dart';

class SuggestionChips extends StatelessWidget {
  const SuggestionChips({
    super.key,
    required this.suggestions,
    this.recentSearches = const [],
    required this.onSuggestionSelected,
  });

  final List<String> suggestions;
  final List<String> recentSearches;
  final void Function(String) onSuggestionSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Популарни пребарувања:',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: .6),
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children:
              suggestions.map((suggestion) {
                return ActionChip(
                  side: BorderSide(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: .1),
                  ),
                  label: Text(suggestion),
                  tooltip: suggestion,
                  avatar: const Icon(Icons.moving_rounded),
                  onPressed: () => onSuggestionSelected(suggestion),
                );
              }).toList(),
        ),
        if (recentSearches.isNotEmpty) ...[
          const SizedBox(height: 20),
          Text(
            'Неодамна пребарувани:',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: .6),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children:
                recentSearches.map((search) {
                  return ActionChip(
                    side: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: .1),
                    ),
                    label: Text(search),
                    tooltip: search,
                    avatar: const Icon(Icons.history_rounded),
                    onPressed: () => onSuggestionSelected(search),
                  );
                }).toList(),
          ),
        ],
      ],
    );
  }
}
