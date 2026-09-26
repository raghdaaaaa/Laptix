import 'package:flutter/material.dart';

import 'package:laptix/widgets/step_screen.dart';
import 'package:laptix/widgets/major_icons.dart';

import 'package:laptix/Core/Constants/app_icons.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_routes.dart';

import 'package:laptix/models/student_profile.dart';

class MajorScreen extends StatefulWidget {
  const MajorScreen({super.key});

  @override
  State<MajorScreen> createState() => _MajorScreenState();
}

class _MajorScreenState extends State<MajorScreen> {
  String? _selectedMajor;

  static final List<StepOption> _majorOptions = [
    StepOption(icon: const CodeSlashIcon(), label: AppStrings.majorComputerScience),
    StepOption(icon: const Icon(AppIcons.majorEngineering, size: 30), label: AppStrings.majorEngineering),
    StepOption(icon: const BusinessChartIcon(), label: AppStrings.majorBusiness),
    StepOption(icon: const DesignNodesIcon(), label: AppStrings.majorDesign),
    StepOption(icon: const Icon(AppIcons.majorMedia, size: 30), label: AppStrings.majorMedia),
    StepOption(
      icon: Transform.flip(
        flipX: true,
        child: const Icon(AppIcons.majorOther, size: 30),
      ),
      label: AppStrings.majorOther,
    ),
  ];

  void _onSelectionChanged(int index) {
    setState(() {
      _selectedMajor = _majorOptions[index].label;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepScreen(
      stepNumber: 1,
      totalSteps: 3,
      title: AppStrings.step1Title,
      highlight: 'major?',
      subtitle: AppStrings.step1Subtitle,
      options: _majorOptions,
      onContinue: _selectedMajor == null
          ? null
          : () => Navigator.pushNamed(
                context,
                AppRoutes.usage,
                arguments: StudentProfile(
                  major: _selectedMajor!,
                  usages: [],
                  budget: '',
                ),
              ),
      onSelectionChanged: _onSelectionChanged,
    );
  }
}