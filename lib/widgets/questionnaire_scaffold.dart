import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/widgets/app_bar_button.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/progress_header.dart';

import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_icons.dart';

class QuestionnaireScaffold extends StatelessWidget {
  final int stepNumber;
  final int totalSteps;
  final String title;
  final String highlight;
  final String subtitle;
  final Widget content;
  final VoidCallback? onContinue;
  final String continueText;

  const QuestionnaireScaffold({
    super.key,
    required this.stepNumber,
    required this.totalSteps,
    required this.title,
    required this.highlight,
    required this.subtitle,
    required this.content,
    this.onContinue,
    this.continueText = 'Continue',
  });

  Widget _stepDot({required bool isActive}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.borderColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.backgroundLight,
      padding: const EdgeInsets.only(left: 24, top: 40, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBarButton(
            icon: AppIcons.arrowBackIos,
            onTap: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(totalSteps, (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: index < totalSteps - 1 ? 6 : 0),
                      child: _stepDot(isActive: index == stepNumber - 1),
                    );
                  }),
                ),
                const SizedBox(height: 5),
                Text(
                  'Step $stepNumber of $totalSteps'.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    height: 1.5,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          AppBarButton(
            icon: AppIcons.close,
            onTap: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: StepHeader(
                      title: title,
                      highlight: highlight,
                      subtitle: subtitle,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: content,
                  ),
                  const SizedBox(height: 36),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: PrimaryButton(
                      text: continueText,
                      onTap: onContinue,
                      height: 68,
                      trailingIcon: AppIcons.arrowForwardSharp,
                      trailingIconSize: 17,
                      trailingIconColor: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}