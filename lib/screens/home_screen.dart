import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/widgets/custom_app_bar.dart';
import 'package:laptix/widgets/progress_header.dart';
import 'package:laptix/widgets/laptop_placeholder.dart';
import 'package:laptix/widgets/icon_pill_badge.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/widgets/secondary_button.dart';
import 'package:laptix/widgets/bottom_nav_bar.dart';

import 'package:laptix/Core/Constants/app_icons.dart';
import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: CustomAppBar(
        leadingWidth: 150,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(30, 58, 138, 0.2),
                    offset: Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: -4,
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(30, 58, 138, 0.2),
                    offset: Offset(0, 10),
                    blurRadius: 15,
                    spreadRadius: -3,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'L',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Laptix',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E3A8A),
                letterSpacing: -0.025 * 24,
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: const Center(child: Icon(AppIcons.menu, color: Colors.black)),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 96),
        child: Column(
          children: [
            const StepHeader(
              title: 'Find the right\nlaptop for\nyour needs.',
              highlight: 'laptop',
              subtitle: 'Personalized laptop\nrecommendations based on your\nmajor, usage, and budget.',
            ),
            const SizedBox(height: 48),
            const LaptopImagePlaceholder(
              imagePath: 'assets/images/laptop_hero.png', 
              badges: [
                Positioned(
                  bottom: 10,
                  left: -8, 
                  child: IconPillBadge(
                     icon: Icons.star, 
                    text: 'Performance',
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF1F2937),
                    borderColor: Color(0xFFF3F4F6),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: -8, 
                  child: IconPillBadge(
                     icon: Icons.verified, 
                    text: 'Student Life',
                    backgroundColor: Color(0xFF06B6D4),
                    foregroundColor: Colors.white,
                    borderColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            PrimaryButton(
              text: 'Find My Laptop',
              onTap: () {},
               trailingIcon: AppIcons.arrowForward,
            ),
            const SizedBox(height: 16),
            SecondaryButton(
              text: 'Check a Laptop',
              onTap: () {},
               leadingIcon: Icons.search, 
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: CustomBottomNavBar(
          currentIndex: 0,
          onTap: (index) {},
        ),
      ),
    );
  }
}