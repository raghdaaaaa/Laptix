import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/Core/Constants/app_colors.dart';

class BigResultCard extends StatelessWidget {
  final String iconPath;
  final Color color;
  final Widget title;
  final String subtitle;
  final bool filled;

  const BigResultCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.color = AppColors.successColor,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
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
              width: 36,
              height: 36,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
        const SizedBox(height: 20),
        DefaultTextStyle(
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: AppColors.charcoal,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
          child: title,
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.secondaryTextColor,
            height: 1.5,
          ),
        ),
      ],
    );

    if (!filled) return content;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: content,
    );
  }
}