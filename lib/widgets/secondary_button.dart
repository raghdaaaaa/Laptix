import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final IconData? leadingIcon;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primaryColor,
          side: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.15)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: 18, color: AppColors.primaryColor),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}