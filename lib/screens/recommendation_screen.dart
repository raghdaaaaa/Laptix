import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/widgets/big_result_card.dart';
import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/custom_app_bar.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/secondary_button.dart';
import 'package:laptix/widgets/spec_card.dart';
import 'package:laptix/widgets/spec_status_row.dart';

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
    if (!mounted) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar.recommendation(
        title: '',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              AppStrings.recResultYourMatch,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: AppColors.secondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.recResultPerfectMatch,
              style: GoogleFonts.inter(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.recResultSubtitle,
              style: GoogleFonts.inter(
                fontSize: 16,
                height: 1.5,
                color: AppColors.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 32),

            // Big Result Card
            BigResultCard(
              iconPath: AppAssets.commonCheckCircle,
              color: AppColors.successColor,
              title: Text(AppStrings.recResultPerfectMatchTitle),
              subtitle: AppStrings.recResultBasedOn,
              filled: true,
            ),
            const SizedBox(height: 32),

            // Specification Cards Grid
            Text(
              AppStrings.recResultRecommendedSpecs,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16),
            _buildSpecGrid(),
            const SizedBox(height: 32),

            // Budget warning (if applicable)
            if (_result.budgetWarning != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.warningBackgroundColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.warningBorderColor),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.commonWarning,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(AppColors.warningColor, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _result.budgetWarning!,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          height: 1.4,
                          color: AppColors.warningTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Why this recommendation section
            Text(
              AppStrings.recResultWhyTitle,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16),
            _buildWhySection(),
            const SizedBox(height: 32),

            // Expert Tip
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.1)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.commonStar,
                        width: 18,
                        height: 18,
                        colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.expertTipTitle,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppStrings.expertTipContent,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            height: 1.5,
                            color: AppColors.primaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            PrimaryButton(
              text: AppStrings.recResultFindLaptops,
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              ),
            ),
            const SizedBox(height: 16),
            SecondaryButton(
              text: AppStrings.btnStartOver,
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.major,
                (route) => false,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return;
          if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.laptopChecker);
            return;
          }
        },
        onCenterTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.major,
          (route) => false,
        ),
      ),
    );
  }

  Widget _buildSpecGrid() {
    final specs = [
      _SpecData(
        label: AppStrings.specProcessor,
        iconPath: AppAssets.resultCpu,
        iconColor: AppColors.primaryColor,
        title: _result.cpu,
        description: _result.cpuReason,
      ),
      _SpecData(
        label: AppStrings.specMemory,
        iconPath: AppAssets.resultMemory,
        iconColor: AppColors.secondaryColor,
        title: '${_result.ram} GB',
        description: _result.ramReason,
      ),
      _SpecData(
        label: AppStrings.specStorage,
        iconPath: AppAssets.resultSsd,
        iconColor: AppColors.purpleAccent,
        title: '${_result.storage} GB',
        description: _result.storageReason,
      ),
      _SpecData(
        label: AppStrings.specGraphics,
        iconPath: AppAssets.resultGpu,
        iconColor: AppColors.orangeAccent,
        title: _result.gpu,
        description: _result.gpuReason,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: specs.length,
      itemBuilder: (context, index) {
        final spec = specs[index];
        return SpecificationCard(
          label: spec.label,
          iconPath: spec.iconPath,
          iconColor: spec.iconColor,
          title: spec.title,
          description: spec.description,
        );
      },
    );
  }

  Widget _buildWhySection() {
    return Column(
      children: [
        SpecStatusRow(
          iconPath: AppAssets.resultCpu,
          label: AppStrings.specProcessor,
          value: _result.cpu,
          status: _getStatusForCpu(_result.cpu),
          reason: _result.cpuReason,
        ),
        SpecStatusRow(
          iconPath: AppAssets.resultMemory,
          label: AppStrings.specMemory,
          value: '${_result.ram} GB',
          status: _getStatusForRam(_result.ram),
          reason: _result.ramReason,
        ),
        SpecStatusRow(
          iconPath: AppAssets.resultSsd,
          label: AppStrings.specStorage,
          value: '${_result.storage} GB',
          status: _getStatusForStorage(_result.storage),
          reason: _result.storageReason,
        ),
        SpecStatusRow(
          iconPath: AppAssets.resultGpu,
          label: AppStrings.specGraphics,
          value: _result.gpu,
          status: _getStatusForGpu(_result.gpu),
          reason: _result.gpuReason,
        ),
      ],
    );
  }

  SpecStatus _getStatusForCpu(String cpu) {
    switch (cpu) {
      case 'High':
        return SpecStatus.perfect;
      case 'Medium':
        return SpecStatus.optimal;
      default:
        return SpecStatus.good;
    }
  }

  SpecStatus _getStatusForRam(int ram) {
    if (ram >= 32) return SpecStatus.perfect;
    if (ram >= 16) return SpecStatus.optimal;
    return SpecStatus.good;
  }

  SpecStatus _getStatusForStorage(int storage) {
    if (storage >= 1024) return SpecStatus.perfect;
    if (storage >= 512) return SpecStatus.optimal;
    return SpecStatus.good;
  }

  SpecStatus _getStatusForGpu(String gpu) {
    switch (gpu) {
      case 'Dedicated':
        return SpecStatus.perfect;
      case 'Entry-level Dedicated':
        return SpecStatus.optimal;
      default:
        return SpecStatus.good;
    }
  }
}

class _SpecData {
  final String label;
  final String iconPath;
  final Color iconColor;
  final String title;
  final String description;

  const _SpecData({
    required this.label,
    required this.iconPath,
    required this.iconColor,
    required this.title,
    required this.description,
  });
}