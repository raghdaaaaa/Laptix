import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/custom_app_bar.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/status_card.dart';

import 'package:laptix/Core/Constants/app_icons.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_routes.dart';

import 'package:laptix/data/requirements_data.dart';

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

      final cpuLevel = _cpuLevel(_selectedCpu) >= _cpuLevel(req.cpu);
      final ramOk = _selectedRam >= req.ram;
      final gpuLevel = _gpuLevel(_selectedGpu) >= _gpuLevel(req.gpu);

      if (cpuLevel && ramOk && gpuLevel) {
        matchedUsages++;
        suitableFor.add(usage);
      } else {
        notSuitableFor.add(usage);
      }
    }

    String verdict;
    Color verdictColor;
    IconData verdictIcon;

    if (matchedUsages == totalUsages) {
      verdict = AppStrings.checkerHighlySuitable;
      verdictColor = AppColors.successColor;
      verdictIcon = Icons.check_circle_rounded;
    } else if (matchedUsages >= totalUsages ~/ 2) {
      verdict = 'Moderately Suitable';
      verdictColor = Colors.orange;
      verdictIcon = Icons.info_rounded;
    } else {
      verdict = 'Limited Suitability';
      verdictColor = AppColors.errorColor;
      verdictIcon = Icons.warning_amber_rounded;
    }

    return {
      'verdict': verdict,
      'verdictColor': verdictColor,
      'verdictIcon': verdictIcon,
      'matchedUsages': matchedUsages,
      'totalUsages': totalUsages,
      'suitableFor': suitableFor,
      'notSuitableFor': notSuitableFor,
      'cpuReason': _getCpuReason(),
      'ramReason': _getRamReason(),
      'gpuReason': _getGpuReason(),
    };
  }

  int _cpuLevel(String cpu) {
    switch (cpu) {
      case 'High':
        return 3;
      case 'Medium':
        return 2;
      default:
        return 1;
    }
  }

  int _gpuLevel(String gpu) {
    switch (gpu) {
      case 'Dedicated':
        return 3;
      case 'Entry-level Dedicated':
        return 2;
      default:
        return 1;
    }
  }

  String _getCpuReason() {
    final level = _cpuLevel(_selectedCpu);
    if (level >= 3) return 'High-performance CPU handles all workloads';
    if (level >= 2) return 'Medium CPU suitable for most development tasks';
    return 'Basic CPU only for light browsing and office work';
  }

  String _getRamReason() {
    if (_selectedRam >= 32) return '32+ GB ideal for video editing, 3D, and AI';
    if (_selectedRam >= 16) return '16 GB recommended for development and design';
    return '8 GB sufficient for basic usage';
  }

  String _getGpuReason() {
    if (_selectedGpu == 'Dedicated') return 'Dedicated GPU required for gaming, 3D, and video editing';
    if (_selectedGpu == 'Entry-level Dedicated') return 'Entry-level GPU handles light creative work';
    return 'Integrated graphics only for basic tasks';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: CustomAppBar(
          leading: IconButton(
            icon: const Icon(AppIcons.arrowBack, color: AppColors.primaryTextColor),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text(
            'Laptop Checker',
            style: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.charcoal,
            ),
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
              AppStrings.checkerTitle,
              style: GoogleFonts.urbanist(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                color: AppColors.secondaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              AppStrings.checkerSubtitle,
              style: GoogleFonts.urbanist(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.checkerDescription,
              style: GoogleFonts.urbanist(
                fontSize: 15,
                height: 1.4,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),

            // Spec Selectors
            Text(
              AppStrings.checkerSpecsHeader,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(height: 16),

            // CPU Dropdown
            LabeledDropdown<String>(
              label: AppStrings.checkerLabelProcessor,
              icon: AppIcons.processor,
              value: _selectedCpu,
              items: _cpuOptions,
              itemText: (item) => item,
              onChanged: (value) => setState(() => _selectedCpu = value!),
            ),
            const SizedBox(height: 16),

            // RAM Dropdown
            LabeledDropdown<int>(
              label: AppStrings.checkerLabelMemory,
              icon: AppIcons.memory,
              value: _selectedRam,
              items: _ramOptions,
              itemText: (item) => '$item GB',
              onChanged: (value) => setState(() => _selectedRam = value!),
            ),
            const SizedBox(height: 16),

            // GPU Dropdown
            LabeledDropdown<String>(
              label: AppStrings.checkerLabelGraphics,
              icon: AppIcons.graphics,
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
              trailingIcon: AppIcons.checkCircle,
            ),
            const SizedBox(height: 32),

            // Results
            if (_analysisResult != null) _buildResults(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: CustomBottomNavBar(
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
      ),
    );
  }

  Widget _buildResults() {
    final result = _analysisResult!;
    final verdictColor = result['verdictColor'] as Color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Verdict Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: verdictColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: verdictColor.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Icon(
                result['verdictIcon'] as IconData,
                color: verdictColor,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                result['verdict'] as String,
                style: GoogleFonts.urbanist(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: verdictColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${result['matchedUsages']} of ${result['totalUsages']} use cases supported',
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Analysis Details
        Text(
          AppStrings.checkerAnalysisResult,
          style: GoogleFonts.urbanist(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.charcoal,
          ),
        ),
        const SizedBox(height: 16),

        // CPU Analysis
        _buildAnalysisRow(
          icon: AppIcons.processor,
          label: AppStrings.specProcessor,
          value: _selectedCpu,
          reason: result['cpuReason'] as String,
        ),
        const SizedBox(height: 12),

        // RAM Analysis
        _buildAnalysisRow(
          icon: AppIcons.memory,
          label: AppStrings.specMemory,
          value: '$_selectedRam GB',
          reason: result['ramReason'] as String,
        ),
        const SizedBox(height: 12),

        // GPU Analysis
        _buildAnalysisRow(
          icon: AppIcons.graphics,
          label: AppStrings.specGraphics,
          value: _selectedGpu,
          reason: result['gpuReason'] as String,
        ),
        const SizedBox(height: 24),

        // Suitable for section
        if ((result['suitableFor'] as List).isNotEmpty) ...[
          Text(
            AppStrings.checkerSuitableFor,
            style: GoogleFonts.urbanist(
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.successBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.successBorderColor),
                ),
                child: Text(
                  usage,
                  style: GoogleFonts.urbanist(
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
            style: GoogleFonts.urbanist(
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade100),
                ),
                child: Text(
                  usage,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade700,
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
    required IconData icon,
    required String label,
    required String value,
    required String reason,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: GoogleFonts.urbanist(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: Colors.grey.shade500,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reason,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    height: 1.3,
                    color: Colors.grey.shade600,
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