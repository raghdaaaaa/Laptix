import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/widgets/spec_status_row.dart';

class CheckerAnalysisRow extends StatelessWidget {
  const CheckerAnalysisRow({
    super.key,
    required this.iconPath,
    required this.label,
    required this.value,
    required this.reason,
    required this.status,
  });

  final String iconPath;
  final String label;
  final String value;
  final String reason;
  final SpecStatus status;

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
      case 'Storage':
        return AppColors.orangeAccent.withValues(alpha: 0.1);
      case 'Graphics':
        return AppColors.indigoAccent.withValues(alpha: 0.1);
      default:
        return AppColors.primaryColor.withValues(alpha: 0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
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
}