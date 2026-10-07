import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_icons.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? height;
  final double trailingIconSize;
  final Color? trailingIconColor;
  final String? leadingIconPath;
  final double leadingIconSize;
  final Color? leadingIconColor;
  final String? trailingIconPath;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height,
    this.trailingIconSize = 18,
    this.trailingIconColor,
    this.leadingIconPath,
    this.leadingIconSize = 20,
    this.leadingIconColor,
    this.trailingIconPath,
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
              : const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.transparent,
        ).copyWith(elevation: const WidgetStatePropertyAll(0)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: onTap != null
                ? [
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
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIconPath != null) ...[
                SvgPicture.asset(
                  leadingIconPath!,
                  width: leadingIconSize,
                  height: leadingIconSize,
                  colorFilter: ColorFilter.mode(
                    leadingIconColor ?? Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              if (leadingIconPath == null) ...[
                const SizedBox(width: 12),
                if (trailingIconPath != null)
                  SvgPicture.asset(
                    trailingIconPath!,
                    width: trailingIconSize,
                    height: trailingIconSize,
                    colorFilter: ColorFilter.mode(
                      trailingIconColor ?? Colors.white,
                      BlendMode.srcIn,
                    ),
                  )
                else
                  AppIcons.iconChevronRight(
                    color:
                        trailingIconColor ?? Colors.white.withValues(alpha: 0.7),
                    size: trailingIconSize,
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
