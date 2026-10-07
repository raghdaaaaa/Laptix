import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckerVerdictCard extends StatelessWidget {
  const CheckerVerdictCard({
    super.key,
    required this.color,
    required this.iconPath,
    required this.verdict,
    required this.matchedUsages,
    required this.totalUsages,
  });

  final Color color;
  final String iconPath;
  final String verdict;
  final int matchedUsages;
  final int totalUsages;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  offset: const Offset(0, 8),
                  blurRadius: 16,
                  spreadRadius: -4,
                ),
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            verdict,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$matchedUsages of $totalUsages use cases supported',
            style: GoogleFonts.inter(
              fontSize: 14,
              color:  color.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}