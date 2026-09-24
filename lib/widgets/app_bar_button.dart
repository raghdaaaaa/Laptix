import 'package:flutter/material.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class AppBarButton extends StatelessWidget {
  final IconData icon;
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
            BoxShadow(color: Color(0x14000000), blurRadius: 8),
          ],
        ),
        child: Icon(icon, size: 20, color: AppColors.primaryColor),
      ),
    );
  }
}