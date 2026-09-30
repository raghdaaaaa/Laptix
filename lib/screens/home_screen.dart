import 'package:flutter/material.dart';

import 'package:laptix/widgets/custom_app_bar.dart';
import 'package:laptix/widgets/progress_header.dart';
import 'package:laptix/widgets/laptop_placeholder.dart';
import 'package:laptix/widgets/icon_pill_badge.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/secondary_button.dart';
import 'package:laptix/widgets/bottom_nav_bar.dart';

import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_routes.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar.home(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 120),
        child: Column(
          children: [
            const StepHeader(
              title: AppStrings.welcomeTitle,
              highlight: 'laptop',
              subtitle: AppStrings.welcomeSubtitle,
            ),
            const SizedBox(height: 40),
            LaptopImagePlaceholder(
              imagePath: AppAssets.laptopHero,
              badges: [
                Positioned(
                  bottom: 20,
                  left: -12,
                  child: IconPillBadge(
                    iconPath: AppAssets.iconStar,
                    text: 'Performance',
                    backgroundColor: AppColors.cardColor,
                    foregroundColor: AppColors.charcoal,
                    borderColor: AppColors.backgroundColor,
                  ),
                ),
                Positioned(
                  top: 30,
                  right: -12,
                  child: IconPillBadge(
                    iconPath: AppAssets.iconVerified,
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
              onTap: () => Navigator.pushNamed(context, AppRoutes.laptopChecker),
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