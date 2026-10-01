import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/checker_app_bar.dart';
import 'package:laptix/widgets/checker_analysis_row.dart';
import 'package:laptix/widgets/expert_tip_card.dart';
import 'package:laptix/widgets/checker_verdict_card.dart';
import 'package:laptix/widgets/spec_status_row.dart';
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
  Map<String, dynamic>? _analysisResult;

  void _checkCompatibility() {
    setState(() {
      _isChecking = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
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

      final cpuLevel =
          RecommendationEngine.cpuLevel(_selectedCpu) >=
          RecommendationEngine.cpuLevel(req.cpu);
      final ramOk = _selectedRam >= req.ram;
      final storageOk = _selectedStorage >= req.storage;
      final gpuLevel =
          RecommendationEngine.gpuLevel(_selectedGpu) >=
          RecommendationEngine.gpuLevel(req.gpu);

      if (cpuLevel && ramOk && storageOk && gpuLevel) {
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
      'storageReason': _getStorageReason(),
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

  String _getStorageReason() {
    if (_selectedStorage >= 1024) return AppStrings.storageReasonHigh;
    if (_selectedStorage >= 512) return AppStrings.storageReasonMedium;
    return AppStrings.storageReasonBasic;
  }

  String _getGpuReason() {
    if (_selectedGpu == 'Dedicated') {
      return AppStrings.gpuReasonHigh;
    }
    if (_selectedGpu == 'Entry-level Dedicated') {
      return AppStrings.gpuReasonMedium;
    }
    return AppStrings.gpuReasonBasic;
  }

  int _ramLevel(int ram) {
    if (ram >= 32) return 3;
    if (ram >= 16) return 2;
    return 1;
  }

  int _storageLevel(int storage) {
    if (storage >= 1024) return 3;
    if (storage >= 512) return 2;
    return 1;
  }

  String _pickExpertTip(
    SpecStatus cpuStatus,
    SpecStatus ramStatus,
    SpecStatus gpuStatus,
  ) {
    String tip =
        'Consider future-proofing: selecting a tier above your current needs extends laptop lifespan by 2-3 years.';

    if (gpuStatus == SpecStatus.good || gpuStatus == SpecStatus.poor) {
      tip = 'While the GPU is suitable, upgrading to an RTX 40-series would future-proof your 3D rendering tasks for the next 3 years.';
    } else if (ramStatus == SpecStatus.good || ramStatus == SpecStatus.poor) {
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
    final ramLevel = _ramLevel(_selectedRam);
    final storageLevel = _storageLevel(_selectedStorage);
    final gpuLevel = RecommendationEngine.gpuLevel(_selectedGpu);

    int maxReqCpu = 1, maxReqRam = 1, maxReqStorage = 1, maxReqGpu = 1;
    for (final entry in requirements.entries) {
      final req = entry.value;
      maxReqCpu = max(maxReqCpu, RecommendationEngine.cpuLevel(req.cpu));
      maxReqRam = max(maxReqRam, _ramLevel(req.ram));
      maxReqStorage = max(maxReqStorage, _storageLevel(req.storage));
      maxReqGpu = max(maxReqGpu, RecommendationEngine.gpuLevel(req.gpu));
    }

    SpecStatus specStatusFn(int current, int required) {
      if (current > required) return SpecStatus.perfect;
      if (current == required) return SpecStatus.optimal;
      return SpecStatus.good;
    }

    final cpuStatus = specStatusFn(cpuLevel, maxReqCpu);
    final ramStatus = specStatusFn(ramLevel, maxReqRam);
    final storageStatus = specStatusFn(storageLevel, maxReqStorage);
    final gpuStatus = specStatusFn(gpuLevel, maxReqGpu);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckerVerdictCard(
          color: verdictColor,
          iconPath: verdictIconPath,
          verdict: result['verdict'] as String,
          matchedUsages: result['matchedUsages'] as int,
          totalUsages: result['totalUsages'] as int,
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
          reason: result['cpuReason'] as String,
          status: cpuStatus,
        ),
        const SizedBox(height: 12),

        CheckerAnalysisRow(
          iconPath: AppAssets.checkerRam,
          label: AppStrings.specMemory,
          value: '$_selectedRam GB',
          reason: result['ramReason'] as String,
          status: ramStatus,
        ),
        const SizedBox(height: 12),

        CheckerAnalysisRow(
          iconPath: AppAssets.checkerStorage,
          label: AppStrings.specStorage,
          value: '$_selectedStorage GB',
          reason: result['storageReason'] as String,
          status: storageStatus,
        ),
        const SizedBox(height: 12),

        CheckerAnalysisRow(
          iconPath: AppAssets.checkerGpu,
          label: AppStrings.specGraphics,
          value: _gpuDisplay[_selectedGpu] ?? _selectedGpu,
          reason: result['gpuReason'] as String,
          status: gpuStatus,
        ),
        const SizedBox(height: 24),

        ExpertTipCard(tip: _pickExpertTip(cpuStatus, ramStatus, gpuStatus)),
        const SizedBox(height: 24),

        if ((result['suitableFor'] as List).isNotEmpty) ...[
          _buildChipsSection(
            title: AppStrings.checkerSuitableFor,
            items: result['suitableFor'] as List<String>,
            background: AppColors.successBackgroundColor,
            border: AppColors.successBorderColor,
            textColor: AppColors.successTextColor,
          ),
          const SizedBox(height: 16),
        ],

        if ((result['notSuitableFor'] as List).isNotEmpty) ...[
          _buildChipsSection(
            title: AppStrings.checkerNotSuitableFor,
            items: result['notSuitableFor'] as List<String>,
            background: AppColors.errorBackgroundColor,
            border: AppColors.errorBorderColor,
            textColor: AppColors.errorTextColor,
          ),
        ],
      ],
    );
  }
}
