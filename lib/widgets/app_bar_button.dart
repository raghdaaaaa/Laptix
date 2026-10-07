import 'package:flutter/material.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class AppBarButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onTap;

  const AppBarButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: AppColors.shadowColorBlack, blurRadius: 8),
          ],
        ),
        child: Center(child: icon),
      ),
    );
  }
}
