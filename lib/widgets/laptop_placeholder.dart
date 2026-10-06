import 'package:flutter/material.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class LaptopImagePlaceholder extends StatelessWidget {
  final String imagePath;
  final List<Widget> badges;

  const LaptopImagePlaceholder({
    super.key,
    required this.imagePath,
    this.badges = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 288,
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderColor, width: 1),
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
      clipBehavior: Clip.none,
      padding: const EdgeInsets.all(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 295,
              height: 254,
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          ...badges,
        ],
      ),
    );
  }
}