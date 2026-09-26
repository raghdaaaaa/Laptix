import 'package:flutter/material.dart';

import 'package:laptix/widgets/budget_card.dart';
import 'package:laptix/widgets/questionnaire_scaffold.dart';

import 'package:laptix/Core/Constants/app_icons.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_routes.dart';

import 'package:laptix/models/student_profile.dart';

class BudgetScreen extends StatefulWidget {
  final StudentProfile profile;

  const BudgetScreen({
    super.key,
    required this.profile,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedIndex = -1;

  static final List<_BudgetOption> _options = [
    _BudgetOption(
      icon: AppIcons.budgetEntry,
      label: AppStrings.budgetEntryLevelTitle,
      price: AppStrings.budgetEntryLevelValue,
    ),
    _BudgetOption(
      icon: AppIcons.budgetMid,
      label: AppStrings.budgetMidRangeTitle,
      price: AppStrings.budgetMidRangeValue,
      badge: AppStrings.budgetMidRangeBadge,
    ),
    _BudgetOption(
      icon: AppIcons.budgetHigh,
      label: AppStrings.budgetHighEndTitle,
      price: AppStrings.budgetHighEndValue,
    ),
    _BudgetOption(
      icon: AppIcons.budgetPro,
      label: AppStrings.budgetProTitle,
      price: AppStrings.budgetProValue,
    ),
  ];

  void _select(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return QuestionnaireScaffold(
      stepNumber: 3,
      totalSteps: 3,
      title: AppStrings.step3Title,
      highlight: 'budget?',
      subtitle: AppStrings.step3Subtitle,
      onContinue: _selectedIndex == -1
          ? null
          : () => Navigator.pushNamed(
                context,
                AppRoutes.recommendation,
                arguments: StudentProfile(
                  major: widget.profile.major,
                  usages: widget.profile.usages,
                  budget: _options[_selectedIndex].price,
                ),
              ),
      continueText: AppStrings.btnShowRecommendations,
      content: Column(
        children: List.generate(_options.length, (index) {
          final option = _options[index];
          return Padding(
            padding: EdgeInsets.only(bottom: index < _options.length - 1 ? 12 : 0),
            child: BudgetOptionCard(
              icon: option.icon,
              label: option.label,
              price: option.price,
              isSelected: _selectedIndex == index,
              badge: option.badge,
              onTap: () => _select(index),
            ),
          );
        }),
      ),
    );
  }
}

class _BudgetOption {
  final IconData icon;
  final String label;
  final String price;
  final String? badge;

  const _BudgetOption({
    required this.icon,
    required this.label,
    required this.price,
    this.badge,
  });
}