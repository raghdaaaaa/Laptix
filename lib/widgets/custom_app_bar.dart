import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_assets.dart';

enum CustomAppBarVariant {
  home,
  checker,
  recommendation,
  defaultVariant,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CustomAppBarVariant variant;
  final String? title;
  final String? subtitle;
  final VoidCallback? onLeadingTap;
  final VoidCallback? onTrailingTap;
  final Widget? trailing;
  final bool showLogo;
  final bool showBackButton;

  static const double _heightHome = 120;
  static const double _heightStandard = 88;

  const CustomAppBar({
    super.key,
    this.variant = CustomAppBarVariant.defaultVariant,
    this.title,
    this.subtitle,
    this.onLeadingTap,
    this.onTrailingTap,
    this.trailing,
    this.showLogo = false,
    this.showBackButton = false,
  });

  // Factory constructors for specific variants
  const CustomAppBar.home({
    super.key,
    this.title,
    this.subtitle,
    this.onLeadingTap,
    this.onTrailingTap,
    this.trailing,
    this.showLogo = true,
    this.showBackButton = false,
  }) : variant = CustomAppBarVariant.home;

  const CustomAppBar.checker({
    super.key,
    this.title,
    this.subtitle,
    this.onLeadingTap,
    this.onTrailingTap,
    this.trailing,
    this.showLogo = false,
    this.showBackButton = true,
  }) : variant = CustomAppBarVariant.checker;

  const CustomAppBar.recommendation({
    super.key,
    this.title,
    this.subtitle,
    this.onLeadingTap,
    this.onTrailingTap,
    this.trailing,
    this.showLogo = false,
    this.showBackButton = true,
  }) : variant = CustomAppBarVariant.recommendation;

  @override
  Size get preferredSize => Size.fromHeight(
        variant == CustomAppBarVariant.home ? _heightHome : _heightStandard,
      );

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case CustomAppBarVariant.home:
        return _buildHomeAppBar(context);
      case CustomAppBarVariant.checker:
        return _buildCheckerAppBar(context);
      case CustomAppBarVariant.recommendation:
        return _buildRecommendationAppBar(context);
      default:
        return _buildDefaultAppBar(context);
    }
  }

  Widget _buildHomeAppBar(BuildContext context) {
    return Container(
      height: _heightHome,
      color: AppColors.backgroundColor,
      padding: const EdgeInsets.only(top: 44, left: 24, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColorPrimary,
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -4,
                ),
                BoxShadow(
                  color: AppColors.shadowColorPrimaryMedium,
                  offset: const Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'L',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Laptix',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryColor,
              letterSpacing: -0.025 * 24,
            ),
          ),
          const Spacer(),
          // Menu button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.cardColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.backgroundColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColorBlack,
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.iconMenu,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryTextColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckerAppBar(BuildContext context) {
    return Container(
      height: _heightStandard,
      color: AppColors.backgroundColor,
      padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back button
          InkWell(
            onTap: onLeadingTap ?? () => Navigator.of(context).maybePop(),
            customBorder: const CircleBorder(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColorBlack,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.iconArrowBack,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryTextColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Title
          Expanded(
            child: Text(
              title ?? 'Laptop Checker',
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
              ),
            ),
          ),
          // Trailing
          if (trailing != null) trailing!,
        ],
      ),
    );
  }

  Widget _buildRecommendationAppBar(BuildContext context) {
    return Container(
      height: _heightStandard,
      color: AppColors.backgroundColor,
      padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back button
          InkWell(
            onTap: onLeadingTap ?? () => Navigator.of(context).maybePop(),
            customBorder: const CircleBorder(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColorBlack,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.iconArrowBack,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.primaryTextColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Title
          Expanded(
            child: Text(
              title ?? 'Recommendation',
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
              ),
            ),
          ),
          // Trailing
          if (trailing != null) trailing!,
        ],
      ),
    );
  }

  Widget _buildDefaultAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: _heightStandard,
      centerTitle: true,
      leadingWidth: 72,
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: onLeadingTap ?? () => Navigator.of(context).maybePop(),
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColorBlack,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.iconArrowBack,
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryTextColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.charcoal,
              ),
            )
          : null,
      actions: [
        if (trailing != null)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: trailing,
          ),
      ],
    );
  }
}