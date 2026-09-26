import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/widgets/big_result_card.dart';
import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/custom_app_bar.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/secondary_button.dart';
import 'package:laptix/widgets/spec_card.dart';
import 'package:laptix/widgets/spec_status_row.dart';

import 'package:laptix/Core/Constants/app_icons.dart';
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
    _result = engine.recommend(widget.profile.usages);
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) return const SizedBox.shrink();
    
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: CustomAppBar(
          leading: IconButton(
            icon: const Icon(AppIcons.arrowBack, color: AppColors.primaryTextColor),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              AppStrings.recResultYourMatch,
              style: GoogleFonts.urbanist(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: AppColors.secondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.recResultPerfectMatch,
              style: GoogleFonts.urbanist(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.recResultSubtitle,
              style: GoogleFonts.urbanist(
                fontSize: 15,
                height: 1.4,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),

            // Big Result Card
            BigResultCard(
              icon: AppIcons.checkCircle,
              color: AppColors.successColor,
              title: const Text(AppStrings.recResultPerfectMatchTitle),
              subtitle: AppStrings.recResultBasedOn,
              filled: true,
            ),
            const SizedBox(height: 32),

            // Specification Cards Grid
            Text(
              AppStrings.recResultRecommendedSpecs,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(height: 16),
            _buildSpecGrid(),
            const SizedBox(height: 32),

            // Why this recommendation section
            Text(
              AppStrings.recResultWhyTitle,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(height: 16),
            _buildWhySection(),
            const SizedBox(height: 32),

            // Action Buttons
            PrimaryButton(
              text: AppStrings.recResultFindLaptops,
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              ),
              trailingIcon: AppIcons.arrowForward,
            ),
            const SizedBox(height: 16),
            SecondaryButton(
              text: 'Start Over',
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: CustomBottomNavBar(
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
      ),
    );
  }

  Widget _buildSpecGrid() {
    final specs = [
      _SpecData(
        label: AppStrings.specProcessor,
        icon: AppIcons.processor,
        iconColor: AppColors.primaryColor,
        title: _result.cpu,
        description: _result.cpuReason,
      ),
      _SpecData(
        label: AppStrings.specMemory,
        icon: AppIcons.memory,
        iconColor: AppColors.secondaryColor,
        title: '${_result.ram} GB',
        description: _result.ramReason,
      ),
      _SpecData(
        label: AppStrings.specStorage,
        icon: AppIcons.storage,
        iconColor: const Color(0xFF8B5CF6),
        title: '${_result.storage} GB',
        description: _result.storageReason,
      ),
      _SpecData(
        label: AppStrings.specGraphics,
        icon: AppIcons.graphics,
        iconColor: const Color(0xFFF59E0B),
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
          icon: spec.icon,
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
          icon: AppIcons.processor,
          label: AppStrings.specProcessor,
          value: _result.cpu,
          status: _getStatusForCpu(_result.cpu),
        ),
        SpecStatusRow(
          icon: AppIcons.memory,
          label: AppStrings.specMemory,
          value: '${_result.ram} GB',
          status: _getStatusForRam(_result.ram),
        ),
        SpecStatusRow(
          icon: AppIcons.storage,
          label: AppStrings.specStorage,
          value: '${_result.storage} GB',
          status: _getStatusForStorage(_result.storage),
        ),
        SpecStatusRow(
          icon: AppIcons.graphics,
          label: AppStrings.specGraphics,
          value: _result.gpu,
          status: _getStatusForGpu(_result.gpu),
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
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const _SpecData({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });
}