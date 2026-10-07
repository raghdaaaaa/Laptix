import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class ExpertTipCard extends StatelessWidget {
  const ExpertTipCard({super.key, required this.tip});

  final String tip;

  @override
  Widget build(BuildContext context) {
    final highlight = 'RTX 40-series';
    final parts = tip.split(highlight);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.charcoal,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.checkerTips,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.secondaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expert Tip',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      height: 1.5,
                      color: AppColors.hintTextColor,
                    ),
                    children: [
                      for (int i = 0; i < parts.length; i++) ...[
                        if (parts[i].isNotEmpty) TextSpan(text: parts[i]),
                        if (i < parts.length - 1)
                          TextSpan(
                            text: highlight,
                            style: const TextStyle(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                      ],
                    ],
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