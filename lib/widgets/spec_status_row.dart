import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SpecStatus { perfect, optimal, good, poor }

class SpecStatusRow extends StatelessWidget {
  final String iconPath;
  final String label;
  final String value;
  final SpecStatus status;
  final String? reason;

  const SpecStatusRow({
    super.key,
    required this.iconPath,
    required this.label,
    required this.value,
    required this.status,
    this.reason,
  });

  ({String text, Color color, String iconPath}) get _statusStyle {
    switch (status) {
      case SpecStatus.perfect:
        return (text: AppStrings.statusPerfect, color: AppColors.successColor, iconPath: AppAssets.commonCheckCircle);
      case SpecStatus.optimal:
        return (text: AppStrings.statusOptimal, color: AppColors.successColor, iconPath: AppAssets.commonCheckCircle);
      case SpecStatus.good:
        return (text: AppStrings.statusGood, color: AppColors.warningColor, iconPath: AppAssets.commonInfo);
      case SpecStatus.poor:
        return (text: AppStrings.statusPoor, color: AppColors.errorColor, iconPath: AppAssets.commonWarning);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _statusStyle;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.08),
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
          // Label and value
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
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.charcoal,
                    letterSpacing: -0.2,
                  ),
                ),
                if (reason != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    reason!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      height: 1.4,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: s.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: s.color.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  s.iconPath,
                  width: 14,
                  height: 14,
                  colorFilter: ColorFilter.mode(s.color, BlendMode.srcIn),
                ),
                const SizedBox(width: 6),
                Text(
                  s.text,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: s.color,
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