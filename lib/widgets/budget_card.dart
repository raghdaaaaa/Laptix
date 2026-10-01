import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_icons.dart';

class BudgetOptionCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final String price;
  final bool isSelected;
  final String? badge;
  final VoidCallback? onTap;

  const BudgetOptionCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.price,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : AppColors.cardColor,
              borderRadius: BorderRadius.circular(32),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.shadowColorPrimary,
                        offset: const Offset(0, 8),
                        blurRadius: 24,
                        spreadRadius: -4,
                      ),
                      BoxShadow(
                        color: AppColors.shadowColorPrimaryMedium,
                        offset: const Offset(0, 4),
                        blurRadius: 16,
                        spreadRadius: -2,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: AppColors.shadowColorBlack.withValues(alpha: 0.05),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                        spreadRadius: 0,
                      ),
                    ],
              border: isSelected
                  ? Border.all(color: AppColors.primaryColor, width: 2)
                  : Border.all(color: AppColors.borderColor, width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.15)
                        : AppColors.primaryColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      iconPath,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        isSelected ? AppColors.secondaryColor : AppColors.primaryColor,
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
                        label,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: isSelected
                              ? AppColors.secondaryColor.withValues(alpha: 0.8)
                              : AppColors.primaryColor.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        price,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: isSelected ? Colors.white : AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.secondaryColor : Colors.transparent,
                    border: isSelected
                        ? null
                        : Border.all(color: AppColors.borderColor, width: 2),
                  ),
                  child: isSelected
                      ? Center(child: AppIcons.check(color: Colors.white, size: 16))
                      : null,
                ),
              ],
            ),
          ),
          if (badge != null)
            Positioned(
              top: -8,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge!,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}