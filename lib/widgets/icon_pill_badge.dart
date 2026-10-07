import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class IconPillBadge extends StatelessWidget {
  final String iconPath;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;

  const IconPillBadge({
    super.key,
    required this.iconPath,
    required this.text,
    this.backgroundColor = AppColors.cardColor,
    this.foregroundColor = AppColors.primaryTextColor,
    this.borderColor = AppColors.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != Colors.transparent
            ? Border.all(color: borderColor, width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColorBlack,
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
          BoxShadow(
            color: AppColors.shadowColorBlackMedium,
            offset: const Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 15,
            height: 15,
            colorFilter: ColorFilter.mode(foregroundColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 8),
          Text(
            text.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.05 * 12,
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}