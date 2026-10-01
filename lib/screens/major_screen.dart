import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/widgets/step_screen.dart';
import 'package:laptix/widgets/option_card.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
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
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.majorCs,
        width: 48,
        height: 48,
      ),
      label: AppStrings.majorComputerScience,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.majorEng,
        width: 48,
        height: 48,
      ),
      label: AppStrings.majorEngineering,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.majorBis,
        width: 48,
        height: 48,
      ),
      label: AppStrings.majorBusiness,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.majorDesign,
        width: 48,
        height: 48,
      ),
      label: AppStrings.majorDesign,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.majorDesign, // fallback: media.svg missing, use design
        width: 48,
        height: 48,
      ),
      label: AppStrings.majorMedia,
    ),
    StepOption(
      icon: SvgPicture.asset(
        AppAssets.majorOther,
        width: 48,
        height: 48,
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
      cardHeight: 180,
      variant: OptionCardVariant.major,
    );
  }
}