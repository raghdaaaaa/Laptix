import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_icons.dart';

enum OptionCardVariant { major, usage }

class OptionSelectionCard extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final OptionCardVariant variant;

  const OptionSelectionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.variant = OptionCardVariant.major,
  });

  @override
  Widget build(BuildContext context) {
    final isMajor = variant == OptionCardVariant.major;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: isMajor ? 26 : 20,
              horizontal: isMajor ? 16 : 12,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : AppColors.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: isSelected
                  ? null
                  : Border.all(color: AppColors.borderColor, width: 1.5),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.shadowColorPrimary,
                        offset: const Offset(0, 8),
                        blurRadius: 20,
                        spreadRadius: -4,
                      ),
                      BoxShadow(
                        color: AppColors.shadowColorPrimaryMedium,
                        offset: const Offset(0, 4),
                        blurRadius: 12,
                        spreadRadius: -2,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: isMajor ? 56 : 48,
                  height: isMajor ? 56 : 48,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.15)
                        : AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconTheme(
                    data: IconThemeData(
                      color: isSelected
                          ? AppColors.secondaryColor
                          : AppColors.primaryColor,
                      size: isMajor ? 28 : 24,
                    ),
                    child: Center(child: icon),
                  ),
                ),
                SizedBox(height: isMajor ? 16 : 12),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isMajor ? 16 : 14,
                    height: 1.5,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? Colors.white
                        : AppColors.primaryTextColor,
                    letterSpacing: isMajor ? -0.2 : -0.1,
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Positioned(
              top: -8,
              right: -8,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: const BoxDecoration(
                      color: AppColors.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: AppIcons.check(
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}