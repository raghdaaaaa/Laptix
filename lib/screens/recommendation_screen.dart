import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/widgets/spec_card.dart'; 
import 'package:laptix/widgets/recommendation_app_bar.dart';
import 'package:laptix/widgets/budget_warning_card.dart';
import 'package:laptix/widgets/why_recommendation_card.dart';
import 'package:laptix/widgets/primary_button.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_routes.dart';

import 'package:laptix/models/student_profile.dart';
import 'package:laptix/models/recommendation_result.dart';
import 'package:laptix/services/recommendation_engine.dart';

class RecommendationScreen extends StatefulWidget {
  final StudentProfile profile;

  const RecommendationScreen({
    super.key,
    required this.profile,
  });

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  late final RecommendationResult _result;

  @override
  void initState() {
    super.initState();
    final engine = RecommendationEngine();
    _result = engine.recommend(
      usages: widget.profile.usages,
      budget: widget.profile.budget,
      major: widget.profile.major,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: SizedBox(height: 80, child: const RecommendationAppBar()),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Success badge (green)
                  Center(
                    child: _SuccessBadge(),
                  ),
                  const SizedBox(height: 30),

                  // Title
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: _result.budgetWarning == null ? 'Perfect ' : 'Best Match ',
                            style: GoogleFonts.inter(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: AppColors.charcoal,
                              letterSpacing: -0.5,
                            ),
                          ),
                          TextSpan(
                            text: _result.budgetWarning == null ? 'Match Found!' : 'for Your Budget!',
                            style: GoogleFonts.inter(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      AppStrings.recResultSubtitle,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 37),

                  // Spec cards (2 rows)
                  _buildSpecCards(),

                  // Budget Warning
                  if (_result.budgetWarning != null) ...[
                    const SizedBox(height: 16),
                    BudgetWarningCard(message: _result.budgetWarning!),
                  ],
                  const SizedBox(height: 32),
                  // Why this recommendation
                  Text(
                    'WHY THIS RECOMMENDATION?',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2.4,
                      color: AppColors.charcoal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  WhyRecommendationCard(
                    result: _result,
                    profile: widget.profile,
                  ),
                  const SizedBox(height: 32),

                  // Action Buttons
                  PrimaryButton(
                    text: 'Check a Laptop',
                    onTap: () => Navigator.pushNamed(context, AppRoutes.laptopChecker),
                    height: 64,
                    trailingIconSize: 18,
                    trailingIconColor: AppColors.secondaryColor,
                  ),
                  const SizedBox(height: 16),
                  _SecondaryActionButton(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.major,
                      (route) => false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecCards() {
    final cpuTitle = _getCpuTitle(_result.cpu);
    final memTitle = '${_result.ram} GB RAM';
    final storTitle = '${_result.storage} GB SSD';
    final gpuTitle = _getGpuTitle(_result.gpu);

    return Column(
      children: [
        // Row 1: CPU + RAM
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SpecificationCard(
                  label: AppStrings.specProcessor,
                  iconPath: AppAssets.resultCpu,
                  iconColor: AppColors.primaryColor,
                  title: cpuTitle,
                  description: _result.cpuReason,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SpecificationCard(
                  label: AppStrings.specMemory,
                  iconPath: AppAssets.resultMemory,
                  iconColor: AppColors.secondaryColor,
                  title: memTitle,
                  description: _result.ramReason,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Row 2: Storage + GPU
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SpecificationCard(
                  label: AppStrings.specStorage,
                  iconPath: AppAssets.resultSsd,
                  iconColor: AppColors.orangeAccent,
                  title: storTitle,
                  description: _result.storageReason,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SpecificationCard(
                  label: AppStrings.specGraphics,
                  iconPath: AppAssets.resultGpu,
                  iconColor: AppColors.indigoAccent,
                  title: gpuTitle,
                  description: _result.gpuReason,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getCpuTitle(String cpu) {
    switch (cpu) {
      case 'High':
        return 'High Performance';
      case 'Medium':
        return 'Medium Performance';
      case 'Basic':
      default:
        return 'Basic Performance';
    }
  }

  String _getGpuTitle(String gpu) {
    switch (gpu) {
      case 'Dedicated':
        return 'Dedicated GPU';
      case 'Entry-level Dedicated':
        return 'Entry-level GPU';
      case 'Integrated':
      default:
        return 'Integrated Graphics';
    }
  }
}

class _SuccessBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.successColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.successColor.withValues(alpha: 0.3),
            offset: const Offset(0, 8),
            blurRadius: 16,
            spreadRadius: -4,
          ),
          BoxShadow(
            color: AppColors.successColor.withValues(alpha: 0.2),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Center(
        child: SvgPicture.asset(
          AppAssets.commonCheckMark,
          width: 36,
          height: 36,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  final VoidCallback onTap;

  const _SecondaryActionButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.secondaryTextColor,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh_rounded,
              size: 18,
              color: AppColors.secondaryTextColor,
            ),
            const SizedBox(width: 8),
            Text(
              'START OVER',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryTextColor,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}