import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/models/recommendation_result.dart';
import 'package:laptix/models/student_profile.dart';

class WhyRecommendationCard extends StatelessWidget {
  const WhyRecommendationCard({
    super.key,
    required this.result,
    required this.profile,
  });

  final RecommendationResult result;
  final StudentProfile profile;

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