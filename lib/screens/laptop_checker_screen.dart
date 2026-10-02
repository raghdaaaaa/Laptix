import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/checker_app_bar.dart';
import 'package:laptix/widgets/checker_analysis_row.dart';
import 'package:laptix/widgets/expert_tip_card.dart';
import 'package:laptix/widgets/checker_verdict_card.dart';
import 'package:laptix/widgets/status_card.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_routes.dart';

import 'package:laptix/models/checker_result.dart';
import 'package:laptix/models/spec_status.dart';
import 'package:laptix/services/laptop_checker_service.dart';

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
  final List<String> _gpuOptions = [
    'Integrated',
    'Entry-level Dedicated',
    'Dedicated',
  ];

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
  CheckerResult? _result;

  void _checkCompatibility() {
    setState(() {
      _isChecking = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      final result = LaptopCheckerService().check(
        cpu: _selectedCpu,
        ram: _selectedRam,
        storage: _selectedStorage,
        gpu: _selectedGpu,
      );
      setState(() {
        _isChecking = false;
        _result = result;
      });
    });
  }

  String _pickExpertTip(
    SpecStatus cpuStatus,
    SpecStatus ramStatus,
    SpecStatus gpuStatus,
  ) {
    String tip =
        'Consider future-proofing: selecting a tier above your current needs extends laptop lifespan by 2-3 years.';

    if (gpuStatus == SpecStatus.good) {
      tip = 'While the GPU is suitable, upgrading to an RTX 40-series would future-proof your 3D rendering tasks for the next 3 years.';
    } else if (ramStatus == SpecStatus.good) {
      tip = 'Consider upgrading to 32 GB RAM for smoother multitasking with heavy creative workloads.';
    }

    return tip;
  }

  Widget _buildChipsSection({
    required String title,
    required List<String> items,
    required Color background,
    required Color border,
    required Color textColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
          children: items.map((usage) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: border),
              ),
              child: Text(
                usage,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
            child: SizedBox(height: 64, child: const CheckerAppBar()),
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
                    onChanged: (value) =>
                        setState(() => _selectedStorage = value!),
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
                    text: _isChecking
                        ? 'Checking...'
                        : AppStrings.checkerBtnCheck,
                    onTap: _isChecking ? null : _checkCompatibility,
                    height: 64,
                    trailingIconSize: 18,
                  ),
                  const SizedBox(height: 32),

                  if (_result != null) _buildResults(),
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
    final result = _result!;
    final verdictColor = _verdictColorForLevel(result.level);
    final verdictIconPath = _verdictIconPathForLevel(result.level);
    final verdictText = _verdictTextForLevel(result.level);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckerVerdictCard(
          color: verdictColor,
          iconPath: verdictIconPath,
          verdict: verdictText,
          matchedUsages: result.matchedUsages,
          totalUsages: result.totalUsages,
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

        CheckerAnalysisRow(
          iconPath: AppAssets.checkerCpu,
          label: AppStrings.specProcessor,
          value: _cpuDisplay[_selectedCpu] ?? _selectedCpu,
          reason: result.cpuReason,
          status: result.cpuStatus,
        ),
        const SizedBox(height: 12),

        CheckerAnalysisRow(
          iconPath: AppAssets.checkerRam,
          label: AppStrings.specMemory,
          value: '$_selectedRam GB',
          reason: result.ramReason,
          status: result.ramStatus,
        ),
        const SizedBox(height: 12),

        CheckerAnalysisRow(
          iconPath: AppAssets.checkerStorage,
          label: AppStrings.specStorage,
          value: '$_selectedStorage GB',
          reason: result.storageReason,
          status: result.storageStatus,
        ),
        const SizedBox(height: 12),

        CheckerAnalysisRow(
          iconPath: AppAssets.checkerGpu,
          label: AppStrings.specGraphics,
          value: _gpuDisplay[_selectedGpu] ?? _selectedGpu,
          reason: result.gpuReason,
          status: result.gpuStatus,
        ),
        const SizedBox(height: 24),

        ExpertTipCard(tip: _pickExpertTip(result.cpuStatus, result.ramStatus, result.gpuStatus)),
        const SizedBox(height: 24),

        if (result.suitableFor.isNotEmpty) ...[
          _buildChipsSection(
            title: AppStrings.checkerSuitableFor,
            items: result.suitableFor,
            background: AppColors.successBackgroundColor,
            border: AppColors.successBorderColor,
            textColor: AppColors.successTextColor,
          ),
          const SizedBox(height: 16),
        ],

        if (result.notSuitableFor.isNotEmpty) ...[
          _buildChipsSection(
            title: AppStrings.checkerNotSuitableFor,
            items: result.notSuitableFor,
            background: AppColors.errorBackgroundColor,
            border: AppColors.errorBorderColor,
            textColor: AppColors.errorTextColor,
          ),
        ],
      ],
    );
  }

  Color _verdictColorForLevel(SuitabilityLevel level) {
    switch (level) {
      case SuitabilityLevel.high:
        return AppColors.successColor;
      case SuitabilityLevel.moderate:
        return AppColors.warningColor;
      case SuitabilityLevel.limited:
        return AppColors.errorColor;
    }
  }

  String _verdictIconPathForLevel(SuitabilityLevel level) {
    switch (level) {
      case SuitabilityLevel.high:
        return AppAssets.commonCheckCircle;
      case SuitabilityLevel.moderate:
      case SuitabilityLevel.limited:
        return AppAssets.commonWarning;
    }
  }

  String _verdictTextForLevel(SuitabilityLevel level) {
    switch (level) {
      case SuitabilityLevel.high:
        return AppStrings.checkerHighlySuitable;
      case SuitabilityLevel.moderate:
        return AppStrings.statusModeratelySuitable;
      case SuitabilityLevel.limited:
        return AppStrings.statusLimitedSuitability;
    }
  }
}