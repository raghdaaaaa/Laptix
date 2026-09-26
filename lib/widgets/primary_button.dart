import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/Core/Constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final IconData? trailingIcon;
  final double? height;
  final double trailingIconSize;
  final Color? trailingIconColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.trailingIcon,
    this.height,
    this.trailingIconSize = 18,
    this.trailingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          fixedSize: height != null ? Size.fromHeight(height!) : null,
          padding: height != null
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.transparent,
        ).copyWith(
          // For adding drop shadow to elevated button:
          elevation: const WidgetStatePropertyAll(0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
               BoxShadow(
                color: Color.fromRGBO(30, 58, 138, 0.3),
                offset: Offset(0, 8),
                blurRadius: 10,
                spreadRadius: -6,
              ),
              BoxShadow(
                color: Color.fromRGBO(30, 58, 138, 0.3),
                offset: Offset(0, 20),
                blurRadius: 25,
                spreadRadius: -5,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 12),
                Icon(
                  trailingIcon,
                  size: trailingIconSize,
                  color: trailingIconColor ?? Colors.white,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}