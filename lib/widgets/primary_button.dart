import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/Core/Constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final IconData? trailingIcon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(
                trailingIcon,
                size: 18,
                color: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}