import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class RecommendationAppBar extends StatelessWidget {
  const RecommendationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back button
            InkWell(
              onTap: () => Navigator.of(context).maybePop(),
              customBorder: const CircleBorder(),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColorBlack,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.commonArrowBack,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryTextColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Title
            Text(
              'Your Match',
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}