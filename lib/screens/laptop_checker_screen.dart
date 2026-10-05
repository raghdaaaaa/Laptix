import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/checker_app_bar.dart';
import 'package:laptix/widgets/checker_analysis_row.dart';
import 'package:laptix/widgets/expert_tip_card.dart';
import 'package:laptix/widgets/checker_verdict_card.dart';
import 'package:laptix/widgets/labeled_dropdown.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_routes.dart';
import 'package:laptix/Core/Constants/app_icons.dart';

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
                  // Processor field (full width)
                  LabeledDropdown<String>(
                    label: AppStrings.checkerLabelProcessor,
                    iconPath: AppAssets.checkerCpu,
                    value: _selectedCpu,
                    items: _cpuOptions,
                    itemText: (item) => _cpuDisplay[item] ?? item,
                    onChanged: (value) => setState(() => _selectedCpu = value!),
                  ),
                  const SizedBox(height: 20),

                  // RAM and Storage side by side
                  Row(
                    children: [
                      Expanded(
                        child: LabeledDropdown<int>(
                          label: AppStrings.checkerLabelMemory,
                          iconPath: AppAssets.checkerRam,
                          value: _selectedRam,
                          items: _ramOptions,
                          itemText: (item) => '$item GB',
                          onChanged: (value) => setState(() => _selectedRam = value!),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: LabeledDropdown<int>(
                          label: AppStrings.checkerLabelGraphics.replaceAll('Graphics', 'Storage'),
                          iconPath: AppAssets.checkerStorage,
                          value: _selectedStorage,
                          items: _storageOptions,
                          itemText: (item) => '$item GB',
                          onChanged: (value) =>
                              setState(() => _selectedStorage = value!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // GPU field (full width)
                  LabeledDropdown<String>(
                    label: AppStrings.checkerLabelGraphics,
                    iconPath: AppAssets.checkerGpu,
                    value: _selectedGpu,
                    items: _gpuOptions,
                    itemText: (item) => _gpuDisplay[item] ?? item,
                    onChanged: (value) => setState(() => _selectedGpu = value!),
                  ),
                  const SizedBox(height: 32),

                  // Custom Check button with search icon on left, no chevron
                  _buildCheckButton(),
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

  Widget _buildCheckButton() {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: ElevatedButton(
        onPressed: _isChecking ? null : _checkCompatibility,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
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
              AppIcons.search(color: AppColors.secondaryColor, size: 20),
              const SizedBox(width: 12),
              Text(
                _isChecking ? 'Checking...' : AppStrings.checkerBtnCheck,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
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

        // Header row: ANALYSIS RESULT + CALCULATION COMPLETE pill
        Row(
          children: [
            Text(
              AppStrings.checkerAnalysisResult,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.4,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.successBackgroundColor,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  AppStrings.checkerCalculationComplete,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.successTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Analysis rows wrapped in one card with dividers
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColorBlack,
                offset: const Offset(0, 4),
                blurRadius: 12,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              CheckerAnalysisRow(
                iconPath: AppAssets.checkerCpu,
                label: AppStrings.specProcessor,
                value: _cpuDisplay[_selectedCpu] ?? _selectedCpu,
                status: result.cpuStatus,
              ),
              _buildDivider(),
              CheckerAnalysisRow(
                iconPath: AppAssets.checkerRam,
                label: AppStrings.specMemory,
                value: '$_selectedRam GB',
                status: result.ramStatus,
              ),
              _buildDivider(),
              CheckerAnalysisRow(
                iconPath: AppAssets.checkerStorage,
                label: AppStrings.specStorage,
                value: '$_selectedStorage GB',
                status: result.storageStatus,
              ),
              _buildDivider(),
              CheckerAnalysisRow(
                iconPath: AppAssets.checkerGpu,
                label: AppStrings.specGraphics,
                value: _gpuDisplay[_selectedGpu] ?? _selectedGpu,
                status: result.gpuStatus,
              ),
            ],
          ),
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

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: AppColors.borderColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
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
        return AppAssets.checkerDoubleCheck;
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