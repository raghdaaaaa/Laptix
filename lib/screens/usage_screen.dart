import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/widgets/step_screen.dart';
import 'package:laptix/widgets/option_card.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
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
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.usageApp,
        width: 48,
        height: 48,
      ),
      label: AppStrings.usageAndroidDev,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.usageGaming,
        width: 48,
        height: 48,
      ),
      label: AppStrings.usageGaming,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.usageGraphic,
        width: 48,
        height: 48,
      ),
      label: AppStrings.usageGraphicDesign,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.usageVideo,
        width: 48,
        height: 48,
      ),
      label: AppStrings.usageVideoEditing,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.usageCad,
        width: 48,
        height: 48,
      ),
      label: AppStrings.usage3DCAD,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.usageStudy,
        width: 48,
        height: 48,
      ),
      label: AppStrings.usageStudy,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.usageProgramming,
        width: 48,
        height: 48,
      ),
      label: AppStrings.usageProgramming,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.usageWeb,
        width: 48,
        height: 48,
      ),
      label: AppStrings.usageWebDev,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.usageAi,
        width: 48,
        height: 48,
      ),
      label: AppStrings.usageAIML,
    ),
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
      cardHeight: 160,
      columns: 2,
      horizontalGap: 12,
      variant: OptionCardVariant.usage,
    );
  }
}