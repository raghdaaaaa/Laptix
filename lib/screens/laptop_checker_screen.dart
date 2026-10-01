import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/status_card.dart';
import 'package:laptix/widgets/spec_status_row.dart';

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
  int _selectedStorage = 256;
  String _selectedGpu = 'Integrated';

  final List<String> _cpuOptions = ['Basic', 'Medium', 'High'];
  final List<int> _ramOptions = [8, 16, 32, 64];
  final List<int> _storageOptions = [256, 512, 1024];
  final List<String> _gpuOptions = ['Integrated', 'Entry-level Dedicated', 'Dedicated'];

  final Map<String, String> _cpuDisplay = {
    'Basic': 'Intel Core i3 / Ryzen 3',
    'Medium': 'Intel Core i5 / Ryzen 5',
    'High': 'Intel Core i7 / Ryzen 7',
  };

  final Map<String, String> _gpuDisplay = {
    'Integrated': 'Integrated Graphics',
    'Entry-level Dedicated': 'Entry-level Dedicated (RTX 3050)',
    'Dedicated': 'Dedicated (RTX 3050+)',
  };

  bool _isChecking = false;
  Map<String, dynamic>? _analysisResult;

  void _checkCompatibility() {
    setState(() {
      _isChecking = true;
    });

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
      verdictIconPath = AppAssets.commonCheckCircle;
    } else if (matchedUsages >= totalUsages ~/ 2) {
      verdict = AppStrings.statusModeratelySuitable;
      verdictColor = AppColors.warningColor;
      verdictIconPath = AppAssets.commonWarning;
    } else {
      verdict = AppStrings.statusLimitedSuitability;
      verdictColor = AppColors.errorColor;
      verdictIconPath = AppAssets.commonWarning;
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
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: SizedBox(
              height: 64,
              child: _CheckerAppBar(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Text(
              AppStrings.checkerTitle,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(height: 32),

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

            LabeledDropdown<String>(
              label: AppStrings.checkerLabelProcessor,
              iconPath: AppAssets.checkerCpu,
              value: _selectedCpu,
              items: _cpuOptions,
              itemText: (item) => _cpuDisplay[item] ?? item,
              onChanged: (value) => setState(() => _selectedCpu = value!),
            ),
            const SizedBox(height: 20),

            LabeledDropdown<int>(
              label: AppStrings.checkerLabelMemory,
              iconPath: AppAssets.checkerRam,
              value: _selectedRam,
              items: _ramOptions,
              itemText: (item) => '$item GB',
              onChanged: (value) => setState(() => _selectedRam = value!),
            ),
            const SizedBox(height: 20),

            LabeledDropdown<int>(
              label: 'Storage',
              iconPath: AppAssets.checkerStorage,
              value: _selectedStorage,
              items: _storageOptions,
              itemText: (item) => '$item GB',
              onChanged: (value) => setState(() => _selectedStorage = value!),
            ),
            const SizedBox(height: 20),

            LabeledDropdown<String>(
              label: AppStrings.checkerLabelGraphics,
              iconPath: AppAssets.checkerGpu,
              value: _selectedGpu,
              items: _gpuOptions,
              itemText: (item) => _gpuDisplay[item] ?? item,
              onChanged: (value) => setState(() => _selectedGpu = value!),
            ),
            const SizedBox(height: 32),

            PrimaryButton(
              text: _isChecking ? 'Checking...' : AppStrings.checkerBtnCheck,
              onTap: _isChecking ? null : _checkCompatibility,
              height: 64,
              trailingIconSize: 18,
            ),
            const SizedBox(height: 32),

            if (_analysisResult != null) _buildResults(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    ),
  ],
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

    final cpuLevel = RecommendationEngine.cpuLevel(_selectedCpu);
    final ramLevel = _selectedRam >= 32 ? 3 : (_selectedRam >= 16 ? 2 : 1);
    final gpuLevel = RecommendationEngine.gpuLevel(_selectedGpu);

    int maxReqCpu = 1, maxReqRam = 1, maxReqGpu = 1;
    for (final entry in requirements.entries) {
      final req = entry.value;
      maxReqCpu = max(maxReqCpu, RecommendationEngine.cpuLevel(req.cpu));
      maxReqRam = max(maxReqRam, req.ram >= 32 ? 3 : (req.ram >= 16 ? 2 : 1));
      maxReqGpu = max(maxReqGpu, RecommendationEngine.gpuLevel(req.gpu));
    }

    SpecStatus specStatusFn(int current, int required) {
      if (current > required) return SpecStatus.perfect;
      if (current == required) return SpecStatus.optimal;
      return SpecStatus.good;
    }

    final cpuStatus = specStatusFn(cpuLevel, maxReqCpu);
    final ramStatus = specStatusFn(ramLevel, maxReqRam);
    final gpuStatus = specStatusFn(gpuLevel, maxReqGpu);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: verdictColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: verdictColor.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: verdictColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: verdictColor.withValues(alpha: 0.3),
                      offset: const Offset(0, 8),
                      blurRadius: 16,
                      spreadRadius: -4,
                    ),
                    BoxShadow(
                      color: verdictColor.withValues(alpha: 0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    verdictIconPath,
                    width: 28,
                    height: 28,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
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

        _buildAnalysisRowWithStatus(
          iconPath: AppAssets.checkerCpu,
          label: AppStrings.specProcessor,
          value: _cpuDisplay[_selectedCpu] ?? _selectedCpu,
          reason: result['cpuReason'] as String,
          status: cpuStatus,
        ),
        const SizedBox(height: 12),

        _buildAnalysisRowWithStatus(
          iconPath: AppAssets.checkerRam,
          label: AppStrings.specMemory,
          value: '$_selectedRam GB',
          reason: result['ramReason'] as String,
          status: ramStatus,
        ),
        const SizedBox(height: 12),

        _buildAnalysisRowWithStatus(
          iconPath: AppAssets.checkerGpu,
          label: AppStrings.specGraphics,
          value: _gpuDisplay[_selectedGpu] ?? _selectedGpu,
          reason: result['gpuReason'] as String,
          status: gpuStatus,
        ),
        const SizedBox(height: 24),

        _buildExpertTip(cpuStatus, ramStatus, gpuStatus),
        const SizedBox(height: 24),

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

  Widget _buildAnalysisRowWithStatus({
    required String iconPath,
    required String label,
    required String value,
    required String reason,
    required SpecStatus status,
  }) {
    final statusData = _getStatusData(status);

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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getIconBgColor(label),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.charcoal,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusData.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: statusData.color.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  statusData.iconPath,
                  width: 12,
                  height: 12,
                  colorFilter: ColorFilter.mode(statusData.color, BlendMode.srcIn),
                ),
                const SizedBox(width: 4),
                Text(
                  statusData.text,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: statusData.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ({String text, Color color, String iconPath}) _getStatusData(SpecStatus status) {
    switch (status) {
      case SpecStatus.perfect:
        return (text: 'Perfect', color: AppColors.successColor, iconPath: AppAssets.commonCheckCircle);
      case SpecStatus.optimal:
        return (text: 'Optimal', color: AppColors.successColor, iconPath: AppAssets.commonCheckCircle);
      case SpecStatus.good:
        return (text: 'Good', color: AppColors.warningColor, iconPath: AppAssets.commonCheckCircle);
      case SpecStatus.poor:
        return (text: 'Poor', color: AppColors.errorColor, iconPath: AppAssets.commonWarning);
    }
  }

  Color _getIconBgColor(String label) {
    switch (label) {
      case 'Processor':
        return AppColors.primaryColor.withValues(alpha: 0.1);
      case 'Memory':
        return AppColors.secondaryColor.withValues(alpha: 0.1);
      case 'Graphics':
        return AppColors.orangeAccent.withValues(alpha: 0.1);
      default:
        return AppColors.primaryColor.withValues(alpha: 0.1);
    }
  }

  Widget _buildExpertTip(SpecStatus cpuStatus, SpecStatus ramStatus, SpecStatus gpuStatus) {
    String tip = 'Consider future-proofing: selecting a tier above your current needs extends laptop lifespan by 2-3 years.';

    if (gpuStatus == SpecStatus.good || gpuStatus == SpecStatus.poor) {
      tip = 'While the GPU is suitable, upgrading to an RTX 40-series would future-proof your 3D rendering tasks for the next 3 years.';
    } else if (ramStatus == SpecStatus.good || ramStatus == SpecStatus.poor) {
      tip = 'Consider upgrading to 32 GB RAM for smoother multitasking with heavy creative workloads.';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.commonStar,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expert Tip',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    height: 1.625,
                    color: AppColors.hintTextColor,
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

class _CheckerAppBar extends StatelessWidget {
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
            Expanded(
              child: Center(
                child: Text(
                  'Check a Laptop',
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.charcoal,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 56),
          ],
        ),
      ),
    );
  }
}