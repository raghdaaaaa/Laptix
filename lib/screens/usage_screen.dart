import 'package:flutter/material.dart';

import 'package:laptix/widgets/step_screen.dart';

import 'package:laptix/Core/Constants/app_icons.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_routes.dart';

import 'package:laptix/models/student_profile.dart';

class UsageScreen extends StatefulWidget {
  final StudentProfile profile;

  const UsageScreen({
    super.key,
    required this.profile,
  });

  @override
  State<UsageScreen> createState() => _UsageScreenState();
}

class _UsageScreenState extends State<UsageScreen> {
  final Set<int> _selectedIndices = {};

  static final List<StepOption> _usageOptions = [
    StepOption(icon: Icon(AppIcons.usageAndroidDev, size: 30), label: AppStrings.usageAndroidDev),
    StepOption(icon: Icon(AppIcons.usageGaming, size: 30), label: AppStrings.usageGaming),
    StepOption(icon: Icon(AppIcons.usageGraphicDesign, size: 30), label: AppStrings.usageGraphicDesign),
    StepOption(icon: Icon(AppIcons.usageVideoEditing, size: 30), label: AppStrings.usageVideoEditing),
    StepOption(icon: Icon(AppIcons.usage3DCAD, size: 30), label: AppStrings.usage3DCAD),
    StepOption(icon: Icon(AppIcons.usageStudy, size: 30), label: AppStrings.usageStudy),
  ];

  void _onSelectionChanged(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  List<String> get _selectedUsages =>
      _selectedIndices.map((i) => _usageOptions[i].label).toList();

  @override
  Widget build(BuildContext context) {
    return StepScreen(
      stepNumber: 2,
      totalSteps: 3,
      title: AppStrings.step2Title,
      highlight: 'laptop for?',
      subtitle: AppStrings.step2Subtitle,
      options: _usageOptions,
      onContinue: _selectedIndices.isEmpty
          ? null
          : () => Navigator.pushNamed(
                context,
                AppRoutes.budget,
                arguments: StudentProfile(
                  major: widget.profile.major,
                  usages: _selectedUsages,
                  budget: '',
                ),
              ),
      onSelectionChanged: _onSelectionChanged,
    );
  }
}