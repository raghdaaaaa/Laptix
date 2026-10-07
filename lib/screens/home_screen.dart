import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/widgets/custom_app_bar.dart';
import 'package:laptix/widgets/laptop_placeholder.dart';
import 'package:laptix/widgets/icon_pill_badge.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/secondary_button.dart';
import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/home_menu_sheet.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_routes.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openMenuSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const HomeMenuSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // App Bar
      appBar: CustomAppBar.home(onMenuTap: () => _openMenuSheet(context)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: 120,
        ),
        child: Column(
          children: [
            _WelcomeHeader(),
            const SizedBox(height: 40),
            LaptopImagePlaceholder(
              imagePath: AppAssets.laptopHero,
              badges: [
                Positioned(
                  bottom: -30,
                  left: -20,
                  child: IconPillBadge(
                    iconPath: AppAssets.commonLightningBolt,
                    text: 'Performance',
                    backgroundColor: AppColors.cardColor,
                    foregroundColor: AppColors.charcoal,
                    borderColor: AppColors.backgroundColor,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: -20,
                  child: IconPillBadge(
                    iconPath: AppAssets.commonGraduationCap,
                    text: 'Student Life',
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: Colors.white,
                    borderColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            PrimaryButton(
              text: AppStrings.homeFindMyLaptop,
              onTap: () => Navigator.pushNamed(context, AppRoutes.major),
            ),
            const SizedBox(height: 16),
            SecondaryButton(
              text: AppStrings.btnCheckLaptop,
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.laptopChecker),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return;
          if (index == 1) {
            Navigator.pushNamed(context, AppRoutes.laptopChecker);
            return;
          }
        },
        onCenterTap: () => Navigator.pushNamed(context, AppRoutes.major),
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final highlightStyle = GoogleFonts.interTight(
      fontSize: 40,
      height: 44 / 40,
      letterSpacing: -0.025,
      fontWeight: FontWeight.w800,
      color: AppColors.primaryColor,
    );

    final titleStyle = GoogleFonts.interTight(
      fontSize: 40,
      height: 44 / 40,
      letterSpacing: -0.025,
      fontWeight: FontWeight.w800,
      color: AppColors.primaryTextColor,
    );

    const title = AppStrings.welcomeTitle;
    const highlight = 'laptop for';

    final words = title.split(highlight);
    final spans = <TextSpan>[];

    for (int i = 0; i < words.length; i++) {
      spans.add(TextSpan(text: words[i], style: titleStyle));
      if (i < words.length - 1) {
        spans.add(TextSpan(text: highlight, style: highlightStyle));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: spans)),
        const SizedBox(height: 16),
        Text(
          AppStrings.welcomeSubtitle,
          style: GoogleFonts.inter(
            fontSize: 18,
            height: 29.25 / 18,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}
