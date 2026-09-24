import 'package:flutter/material.dart';

import 'package:laptix/widgets/custom_app_bar.dart';
import 'package:laptix/widgets/progress_header.dart';
import 'package:laptix/widgets/laptop_placeholder.dart';
import 'package:laptix/widgets/icon_pill_badge.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/secondary_button.dart';
import 'package:laptix/widgets/stat_item.dart';
// import 'package:laptix/widgets/big_result_card.dart';

import 'package:laptix/Core/Constants/app_icons.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 150,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(AppIcons.menu),
            const SizedBox(width: 8),
            Text(
              AppStrings.appName,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.shade200,
          ),
          child: Center(
            child: Icon(AppIcons.menu),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const StepHeader(
              title: AppStrings.welcomeTitle,
              highlight: 'Laptop',
              subtitle: AppStrings.welcomeSubtitle,
            ),

            const SizedBox(height: 24),

            LaptopImagePlaceholder(
              imagePath: 'assets/images/laptop_hero.png',
              badges: [
                Positioned(
                  bottom: 10,
                  left: 12,
                  child: IconPillBadge(
                    icon: Icons.star,
                    text: 'Recommended',
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 12,
                  child: IconPillBadge(
                    icon: Icons.verified,
                    text: 'Student',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            PrimaryButton(
              text: AppStrings.btnContinue,
              onTap: () {},
              trailingIcon: AppIcons.arrowForward,
            ),
            const SizedBox(height: 24),
            SecondaryButton(text: "skip", onTap: () {}),
            const StatsRow(stats: [StatItem(), StatItem(), StatItem()]),    
          ],
        ),
      ),
    );
  }
}