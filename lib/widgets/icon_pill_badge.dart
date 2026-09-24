import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/Core/Constants/app_colors.dart';

class IconPillBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;

  const IconPillBadge({
    super.key,
    required this.icon,
    required this.text,
    this.backgroundColor = Colors.white,
    this.foregroundColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: foregroundColor,
          ),
          const SizedBox(width: 6),
          Text(
            text.toUpperCase(),
            style: GoogleFonts.urbanist(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }
}