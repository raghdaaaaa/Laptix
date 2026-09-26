import 'package:flutter/material.dart';

import 'package:laptix/widgets/option_card.dart';
import 'package:laptix/widgets/questionnaire_scaffold.dart';

class StepOption {
  final Widget icon;
  final String label;

  const StepOption({
    required this.icon,
    required this.label,
  });
}

class StepScreen extends StatefulWidget {
  final int stepNumber;
  final int totalSteps;
  final String title;
  final String highlight;
  final String subtitle;
  final List<StepOption> options;
  final VoidCallback? onContinue;
  final int columns;
  final double cardHeight;
  final String continueText;
  final ValueChanged<int>? onSelectionChanged;

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
    this.cardHeight = 180,
    this.continueText = 'Continue',
    this.onSelectionChanged,
  });

  @override
  State<StepScreen> createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  int _selectedIndex = -1;

  void _select(int index) {
    setState(() => _selectedIndex = index);
    widget.onSelectionChanged?.call(index);
  }

  Widget _buildOptionsGrid() {
    final rows = (widget.options.length / widget.columns).ceil();
    return Column(
      children: List.generate(rows, (rowIndex) {
        final startIdx = rowIndex * widget.columns;
        final endIdx = (startIdx + widget.columns).clamp(0, widget.options.length);
        final rowOptions = widget.options.sublist(startIdx, endIdx);

        return Padding(
          padding: EdgeInsets.only(bottom: rowIndex < rows - 1 ? 16 : 0),
          child: SizedBox(
            height: widget.cardHeight,
            child: Row(
              children: rowOptions.asMap().entries.map((entry) {
                final idx = startIdx + entry.key;
                final option = entry.value;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: entry.key < rowOptions.length - 1 ? 8 : 0),
                    child: OptionSelectionCard(
                      icon: option.icon,
                      label: option.label,
                      isSelected: _selectedIndex == idx,
                      onTap: () => _select(idx),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuestionnaireScaffold(
      stepNumber: widget.stepNumber,
      totalSteps: widget.totalSteps,
      title: widget.title,
      highlight: widget.highlight,
      subtitle: widget.subtitle,
      onContinue: widget.onContinue,
      continueText: widget.continueText,
      content: _buildOptionsGrid(),
    );
  }
}