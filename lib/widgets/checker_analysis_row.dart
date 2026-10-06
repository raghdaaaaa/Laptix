import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/models/spec_status.dart';

class CheckerAnalysisRow extends StatelessWidget {
  const CheckerAnalysisRow({
    super.key,
    required this.iconPath,
    required this.label,
    required this.value,
    required this.status,
  });

  final String iconPath;
  final String label;
  final String value;
  final SpecStatus status;

  ({String text, Color color, String iconPath}) _getStatusData(
    SpecStatus status,
  ) {
    switch (status) {
      case SpecStatus.perfect:
        return (
          text: 'Perfect',
          color: AppColors.successColor,
          iconPath: AppAssets.commonCheckCircle,
        );

      case SpecStatus.optimal:
        return (
          text: 'Optimal',
          color: AppColors.successColor,
          iconPath: AppAssets.commonCheckCircle,
        );

      case SpecStatus.good:
        return (
          text: 'Good',
          color: AppColors.warningColor,
          iconPath: AppAssets.commonWarning,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusData(status);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 7,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
            Container(    
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 12,
                  height: 12,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
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
                      letterSpacing: 1,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.charcoal,
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  statusData.text,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: statusData.color,
                  ),
                ),

                const SizedBox(width: 6),

                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: statusData.color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      statusData.iconPath,
                      width: 8,
                      height: 8,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
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