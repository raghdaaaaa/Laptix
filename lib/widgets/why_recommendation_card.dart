import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
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
    String usageText;
    if (profile.usages.isNotEmpty) {
      final names = profile.usages;
      if (names.length == 1) {
        usageText = names.first;
      } else if (names.length == 2) {
        usageText = '${names[0]} and ${names[1]}';
      } else {
        usageText = '${names.sublist(0, names.length - 1).join(', ')}, and ${names.last}';
      }
    } else {
      usageText = '';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
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
            spreadRadius: -2,
          ),
        ],
      ),
      child: ClipPath(
        clipper: _WhyCardClipper(),
        child: Stack(
          children: [
            // Optional AI icon decoration (bottom-right)
            Positioned(
              right: -13,
              bottom: -30,
              child: Opacity(
                opacity: 0.1,
                child: SvgPicture.asset(
                  AppAssets.usageAi,
                  width: 120,
                  height: 120,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
            // Content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.commonStar,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.secondaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(text: 'Based on your interest in '),
                        if (usageText.isNotEmpty)
                          TextSpan(
                            text: usageText,
                            style: const TextStyle(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                        TextSpan(
                          text: usageText.isNotEmpty
                              ? ', we recommend specs that balance performance for your workloads.'
                              : 'Based on your selections, we recommend specs that match your needs.',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WhyCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()..addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 20, size.width, size.height),
      const Radius.circular(10),
    ));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}