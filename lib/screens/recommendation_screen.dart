import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/spec_card.dart';

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
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: SizedBox(
              height: 64,
              child: _RecommendationAppBar(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            // Header Section
            Text(
              'YOUR MATCH',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
                color: AppColors.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Perfect ',
                    style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.charcoal,
                      letterSpacing: -0.5,
                    ),
                  ),
                  TextSpan(
                    text: 'Match Found!',
                    style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                AppStrings.recResultSubtitle,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryTextColor,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Cyan Success Badge
            _CyanSuccessBadge(),
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

            // Why this recommendation section
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
            _WhyRecommendationCard(result: _result, profile: widget.profile),
            const SizedBox(height: 32),

            // Action Buttons
            _PrimaryActionButton(
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              ),
            ),
            const SizedBox(height: 16),
            _SecondaryActionButton(
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
    ),
  ],
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
        iconColor: AppColors.orangeAccent,
        title: '${_result.storage} GB',
        description: _result.storageReason,
      ),
      _SpecData(
        label: AppStrings.specGraphics,
        iconPath: AppAssets.resultGpu,
        iconColor: AppColors.indigoAccent,
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
}

class _RecommendationAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back button
            InkWell(
              onTap: () => Navigator.of(context).maybePop(),
              customBorder: const CircleBorder(),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColorBlack,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.commonArrowBack,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Title
            Text(
              'Your Match',
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CyanSuccessBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryColor.withValues(alpha: 0.3),
              offset: const Offset(0, 8),
              blurRadius: 16,
              spreadRadius: -4,
            ),
            BoxShadow(
              color: AppColors.secondaryColor.withValues(alpha: 0.2),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            AppAssets.commonCheckCircle,
            width: 36,
            height: 36,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}

class _WhyRecommendationCard extends StatelessWidget {
  final RecommendationResult result;
  final StudentProfile profile;

  const _WhyRecommendationCard({
    required this.result,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final reasons = <String>[];

    if (profile.usages.isNotEmpty) {
      final usageNames = profile.usages.join(', ');
      reasons.add('Based on your interest in $usageNames, we recommend specs that balance performance for your workloads.');
    } else {
      reasons.add('Based on your selections, we recommend specs that match your needs.');
    }

    if (result.ram >= 32) {
      reasons.add('32 GB RAM handles heavy multitasking and large datasets smoothly.');
    } else if (result.ram >= 16) {
      reasons.add('16 GB RAM provides smooth multitasking for development and creative work.');
    }

    if (result.gpu == 'Dedicated') {
      reasons.add('A dedicated GPU is essential for graphics-intensive tasks like 3D rendering and video editing.');
    } else if (result.gpu == 'Entry-level Dedicated') {
      reasons.add('An entry-level dedicated GPU handles light creative work and external displays.');
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColorPrimary,
            offset: const Offset(0, 8),
            blurRadius: 20,
            spreadRadius: -4,
          ),
          BoxShadow(
            color: AppColors.shadowColorPrimaryMedium,
            offset: const Offset(0, 20),
            blurRadius: 25,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Text(
        reasons.join(' '),
        style: GoogleFonts.inter(
          fontSize: 16,
          height: 1.625,
          fontWeight: FontWeight.w600,
          color: AppColors.charcoal,
        ),
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  final VoidCallback onTap;

  const _PrimaryActionButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.transparent,
        ).copyWith(
          elevation: const WidgetStatePropertyAll(0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColorPrimary,
                offset: const Offset(0, 8),
                blurRadius: 10,
                spreadRadius: -6,
              ),
              BoxShadow(
                color: AppColors.shadowColorPrimaryMedium,
                offset: const Offset(0, 20),
                blurRadius: 25,
                spreadRadius: -5,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CHECK A LAPTOP',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              SvgPicture.asset(
                AppAssets.commonChevronRight,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ),
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
            SvgPicture.asset(
              AppAssets.commonChevronLeft,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(AppColors.secondaryTextColor, BlendMode.srcIn),
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