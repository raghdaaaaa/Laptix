import 'package:flutter/material.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class LaptopImagePlaceholder extends StatelessWidget {
  final String? imagePath;
  final List<Widget> badges;

  const LaptopImagePlaceholder({
    super.key,
    this.imagePath,
    this.badges = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColorPrimary,
            offset: const Offset(0, 8),
            blurRadius: 10,
            spreadRadius: -6,
          ),
          BoxShadow(
            color: AppColors.shadowColorPrimaryMedium,
            offset: const Offset(0, 20),
            blurRadius: 25,
            spreadRadius: -5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 1,
              child: imagePath == null
                  ? const Placeholder(color: Colors.grey)
                  : Image.asset(imagePath!, fit: BoxFit.contain),
            ),
          ),
          ...badges,
        ],
      ),
    );
  }
}