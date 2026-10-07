import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_assets.dart';
import 'package:laptix/Core/Constants/app_strings.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback? onCenterTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onCenterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColorBlackMedium,
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                  spreadRadius: -4,
                ),
                BoxShadow(
                  color: AppColors.shadowColorBlack,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  child: _NavIcon(
                    assetPath: AppAssets.navHome,
                    activeAssetPath: AppAssets.navHome,
                    label: AppStrings.navHome,
                    isActive: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                ),
                _CenterButton(onTap: onCenterTap),
                SizedBox(
                  width: 60,
                  child: _NavIcon(
                    assetPath: AppAssets.navChecker,
                    activeAssetPath: AppAssets.navChecker,
                    label: AppStrings.navChecker,
                    isActive: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final String assetPath;
  final String activeAssetPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIcon({
    required this.assetPath,
    required this.activeAssetPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isActive ? activeAssetPath : assetPath,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.primaryColor : AppColors.hintTextColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.urbanist(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isActive
                    ? AppColors.primaryColor
                    : AppColors.hintTextColor,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _CenterButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(1),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColorPrimary,
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: -2,
            ),
            BoxShadow(
              color: AppColors.shadowColorPrimaryMedium,
              blurRadius: 20,
              offset: const Offset(0, 6),
              spreadRadius: -4,
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            AppAssets.iconAdd,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
