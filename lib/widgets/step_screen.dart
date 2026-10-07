import 'package:flutter/material.dart';

import 'package:laptix/widgets/option_card.dart';
import 'package:laptix/widgets/questionnaire_scaffold.dart';

class StepOption {
  final String icon;
  final String label;
  final String? badge;

  const StepOption({required this.icon, required this.label, this.badge});
}

class StepScreen extends StatelessWidget {
  final int stepNumber;
  final int totalSteps;
  final String title;
  final String highlight;
  final String subtitle;
  final List<StepOption> options;
  final VoidCallback? onContinue;
  final int columns;
  final double? cardHeight;
  final double horizontalGap;
  final String continueText;
  final ValueChanged<int>? onSelectionChanged;
  final OptionCardVariant variant;
  final String? Function(int index)? badgeBuilder;
  final Set<int> selectedIndices;

  const StepScreen({
    super.key,
    required this.stepNumber,
    required this.totalSteps,
    required this.title,
    required this.highlight,
    required this.subtitle,
    required this.options,
    this.onContinue,
    this.columns = 2,
    this.cardHeight,
    this.horizontalGap = 8,
    this.continueText = 'Continue',
    this.onSelectionChanged,
    this.variant = OptionCardVariant.major,
    this.badgeBuilder,
    required this.selectedIndices,
  });

  Widget _buildOptionsGrid() {
    final rows = (options.length / columns).ceil();
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth =
            (constraints.maxWidth - horizontalGap * (columns - 1)) / columns;
        return Column(
          children: List.generate(rows, (rowIndex) {
            final startIdx = rowIndex * columns;
            final endIdx = (startIdx + columns).clamp(0, options.length);
            final rowOptions = options.sublist(startIdx, endIdx);
            final isLastRow = rowIndex == rows - 1;
            final isIncompleteRow = isLastRow && rowOptions.length < columns;

            Widget row;
            if (isIncompleteRow) {
              row = Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: rowOptions.asMap().entries.map((entry) {
                  final idx = startIdx + entry.key;
                  final option = entry.value;
                  final badge = badgeBuilder?.call(idx) ?? option.badge;
                  return SizedBox(
                    width: cardWidth,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: entry.key < rowOptions.length - 1
                            ? horizontalGap
                            : 0,
                      ),
                      child: OptionSelectionCard(
                        iconPath: option.icon,
                        label: option.label,
                        isSelected: selectedIndices.contains(idx),
                        onTap: () => onSelectionChanged?.call(idx),
                        variant: variant,
                        badge: badge,
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {
              row = Row(
                children: rowOptions.asMap().entries.map((entry) {
                  final idx = startIdx + entry.key;
                  final option = entry.value;
                  final badge = badgeBuilder?.call(idx) ?? option.badge;
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: entry.key < rowOptions.length - 1
                            ? horizontalGap
                            : 0,
                      ),
                      child: OptionSelectionCard(
                        iconPath: option.icon,
                        label: option.label,
                        isSelected: selectedIndices.contains(idx),
                        onTap: () => onSelectionChanged?.call(idx),
                        variant: variant,
                        badge: badge,
                      ),
                    ),
                  );
                }).toList(),
              );
            }

            if (cardHeight != null) {
              row = SizedBox(height: cardHeight, child: row);
            }

            return Padding(
              padding: EdgeInsets.only(bottom: rowIndex < rows - 1 ? 16 : 0),
              child: row,
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuestionnaireScaffold(
      stepNumber: stepNumber,
      totalSteps: totalSteps,
      title: title,
      highlight: highlight,
      subtitle: subtitle,
      onContinue: onContinue,
      continueText: continueText,
      content: _buildOptionsGrid(),
    );
  }
}
