import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/custom_app_bar.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/status_card.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_routes.dart';

import 'package:laptix/data/requirements_data.dart';
import 'package:laptix/services/recommendation_engine.dart';

class LaptopCheckerScreen extends StatefulWidget {
  const LaptopCheckerScreen({super.key});

  @override
  State<LaptopCheckerScreen> createState() => _LaptopCheckerScreenState();
}

class _LaptopCheckerScreenState extends State<LaptopCheckerScreen> {
  String _selectedCpu = 'Basic';
  int _selectedRam = 8;
  String _selectedGpu = 'Integrated';

  final List<String> _cpuOptions = ['Basic', 'Medium', 'High'];
  final List<int> _ramOptions = [8, 16, 32, 64];
  final List<String> _gpuOptions = ['Integrated', 'Entry-level Dedicated', 'Dedicated'];

  bool _isChecking = false;
  Map<String, dynamic>? _analysisResult;

  void _checkCompatibility() {
    setState(() {
      _isChecking = true;
    });

    // Simulate analysis
    Future.delayed(const Duration(milliseconds: 800), () {
      final result = _analyzeSpecs();
      setState(() {
        _isChecking = false;
        _analysisResult = result;
      });
    });
  }

  Map<String, dynamic> _analyzeSpecs() {
    int matchedUsages = 0;
    int totalUsages = requirements.length;
    List<String> suitableFor = [];
    List<String> notSuitableFor = [];

    for (final entry in requirements.entries) {
      final usage = entry.key;
      final req = entry.value;

      final cpuLevel = RecommendationEngine.cpuLevel(_selectedCpu) >= RecommendationEngine.cpuLevel(req.cpu);
      final ramOk = _selectedRam >= req.ram;
      final gpuLevel = RecommendationEngine.gpuLevel(_selectedGpu) >= RecommendationEngine.gpuLevel(req.gpu);

      if (cpuLevel && ramOk && gpuLevel) {
        matchedUsages++;
        suitableFor.add(usage);
      } else {
        notSuitableFor.add(usage);
      }
    }

    String verdict;
    Color verdictColor;
    String verdictIconPath;

    if (matchedUsages == totalUsages) {
      verdict = AppStrings.checkerHighlySuitable;
      verdictColor = AppColors.successColor;
      verdictIconPath = AppAssets.iconCheckCircle;
    } else if (matchedUsages >= totalUsages ~/ 2) {
      verdict = AppStrings.statusModeratelySuitable;
      verdictColor = AppColors.warningColor;
      verdictIconPath = AppAssets.iconWarning;
    } else {
      verdict = AppStrings.statusLimitedSuitability;
      verdictColor = AppColors.errorColor;
      verdictIconPath = AppAssets.iconWarning;
    }

    return {
      'verdict': verdict,
      'verdictColor': verdictColor,
      'verdictIconPath': verdictIconPath,
      'matchedUsages': matchedUsages,
      'totalUsages': totalUsages,
      'suitableFor': suitableFor,
      'notSuitableFor': notSuitableFor,
      'cpuReason': _getCpuReason(),
      'ramReason': _getRamReason(),
      'gpuReason': _getGpuReason(),
    };
  }

  String _getCpuReason() {
    final level = RecommendationEngine.cpuLevel(_selectedCpu);
    if (level >= 3) return AppStrings.cpuReasonHigh;
    if (level >= 2) return AppStrings.cpuReasonMedium;
    return AppStrings.cpuReasonBasic;
  }

  String _getRamReason() {
    if (_selectedRam >= 32) return AppStrings.ramReasonHigh;
    if (_selectedRam >= 16) return AppStrings.ramReasonMedium;
    return AppStrings.ramReasonBasic;
  }

  String _getGpuReason() {
    if (_selectedGpu == 'Dedicated') return AppStrings.gpuReasonHigh;
    if (_selectedGpu == 'Entry-level Dedicated') return AppStrings.gpuReasonMedium;
    return AppStrings.gpuReasonBasic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar.checker(
        title: AppStrings.checkerTitle,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              AppStrings.checkerTitle,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: AppColors.secondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.checkerSubtitle,
              style: GoogleFonts.inter(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.checkerDescription,
              style: GoogleFonts.inter(
                fontSize: 16,
                height: 1.5,
                color: AppColors.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 32),

            // Spec Selectors
            Text(
              AppStrings.checkerSpecsHeader,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16),

            // CPU Dropdown
            LabeledDropdown<String>(
              label: AppStrings.checkerLabelProcessor,
              iconPath: AppAssets.specProcessor,
              value: _selectedCpu,
              items: _cpuOptions,
              itemText: (item) => item,
              onChanged: (value) => setState(() => _selectedCpu = value!),
            ),
            const SizedBox(height: 16),

            // RAM Dropdown
            LabeledDropdown<int>(
              label: AppStrings.checkerLabelMemory,
              iconPath: AppAssets.specMemory,
              value: _selectedRam,
              items: _ramOptions,
              itemText: (item) => '$item GB',
              onChanged: (value) => setState(() => _selectedRam = value!),
            ),
            const SizedBox(height: 16),

            // GPU Dropdown
            LabeledDropdown<String>(
              label: AppStrings.checkerLabelGraphics,
              iconPath: AppAssets.specGraphics,
              value: _selectedGpu,
              items: _gpuOptions,
              itemText: (item) => item,
              onChanged: (value) => setState(() => _selectedGpu = value!),
            ),
            const SizedBox(height: 32),

            // Check Button
            PrimaryButton(
              text: _isChecking ? 'Checking...' : AppStrings.checkerBtnCheck,
              onTap: _isChecking ? null : _checkCompatibility,
              trailingIconSize: 18,
            ),
            const SizedBox(height: 32),

            // Results
            if (_analysisResult != null) _buildResults(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
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

  Widget _buildResults() {
    final result = _analysisResult!;
    final verdictColor = result['verdictColor'] as Color;
    final verdictIconPath = result['verdictIconPath'] as String;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Verdict Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: verdictColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: verdictColor.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                verdictIconPath,
                width: 56,
                height: 56,
                colorFilter: ColorFilter.mode(verdictColor, BlendMode.srcIn),
              ),
              const SizedBox(height: 16),
              Text(
                result['verdict'] as String,
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: verdictColor,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${result['matchedUsages']} of ${result['totalUsages']} use cases supported',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Analysis Details
        Text(
          AppStrings.checkerAnalysisResult,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.charcoal,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 16),

        // CPU Analysis
        _buildAnalysisRow(
          iconPath: AppAssets.specProcessor,
          label: AppStrings.specProcessor,
          value: _selectedCpu,
          reason: result['cpuReason'] as String,
        ),
        const SizedBox(height: 12),

        // RAM Analysis
        _buildAnalysisRow(
          iconPath: AppAssets.specMemory,
          label: AppStrings.specMemory,
          value: '$_selectedRam GB',
          reason: result['ramReason'] as String,
        ),
        const SizedBox(height: 12),

        // GPU Analysis
        _buildAnalysisRow(
          iconPath: AppAssets.specGraphics,
          label: AppStrings.specGraphics,
          value: _selectedGpu,
          reason: result['gpuReason'] as String,
        ),
        const SizedBox(height: 24),

        // Suitable for section
        if ((result['suitableFor'] as List).isNotEmpty) ...[
          Text(
            AppStrings.checkerSuitableFor,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (result['suitableFor'] as List<String>).map((usage) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.successBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.successBorderColor),
                ),
                child: Text(
                  usage,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.successTextColor,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],

        // Not suitable for section
        if ((result['notSuitableFor'] as List).isNotEmpty) ...[
          Text(
            AppStrings.checkerNotSuitableFor,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (result['notSuitableFor'] as List<String>).map((usage) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.errorBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.errorBorderColor),
                ),
                child: Text(
                  usage,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.errorTextColor,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildAnalysisRow({
    required String iconPath,
    required String label,
    required String value,
    required String reason,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 22,
                height: 22,
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
                  label.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.charcoal,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reason,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    height: 1.4,
                    color: AppColors.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}