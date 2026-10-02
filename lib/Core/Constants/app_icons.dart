import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laptix/Core/Constants/app_assets.dart';

class AppIcons {
  AppIcons._();

  // Helper builder for SVG assets (monochrome - applies colorFilter)
  static Widget _buildSvg(String path, {Color? color, double? width, double? height, double? size}) {
    final w = size ?? width;
    final h = size ?? height;
    return SvgPicture.asset(
      path,
      width: w,
      height: h,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  // Helper builder for SVG assets (multicolor - preserves original colors, ignores color parameter)
  static Widget _buildSvgMulti(String path, {double? width, double? height, double? size}) {
    final w = size ?? width;
    final h = size ?? height;
    return SvgPicture.asset(
      path,
      width: w,
      height: h,
      // No colorFilter - preserves original SVG colors
    );
  }

  // ==========================================
  // COMMON ICONS (Monochrome - colorizable)
  // ==========================================
  static Widget arrowBack({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.commonArrowBack, color: color, size: size);

  static Widget chevronLeft({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.commonChevronLeft, color: color, size: size);

  static Widget chevronRight({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.commonChevronRight, color: color, size: size);

  static Widget close({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.commonClose, color: color, size: size);

  static Widget search({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.commonSearch, color: color, size: size);

  static Widget check({Color? color, double size = 18}) =>
      _buildSvg(AppAssets.commonCheck, color: color, size: size);

  static Widget checkCircle({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.commonCheckCircle, color: color, size: size);

  static Widget warning({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.commonWarning, color: color, size: size);

  // Aliases (still used in code)
  static Widget arrowBackIos({Color? color, double size = 20}) => chevronLeft(color: color, size: size);
  static Widget iconChevronRight({Color? color, double size = 20}) => chevronRight(color: color, size: size);
  static Widget iconSearch({Color? color, double size = 20}) => search(color: color, size: size);

  // ==========================================
  // NAVIGATION ICONS (Monochrome - colorizable)
  // ==========================================
  // NOTE: navHomeActive, navCheckerActive are MISSING from disk

  // ==========================================
  // HOME SCREEN ICONS
  // ==========================================
  static Widget menu({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.homeMenu, color: color, size: size);

  // Multicolor - preserves original colors
  static Widget homeHero({double? width, double? height, double? size}) =>
      _buildSvgMulti(AppAssets.homeHero, width: width, height: height, size: size);

  // ==========================================
  // MAJOR ICONS (Multicolor SVG - keeps original colors unless specified)
  // ==========================================
  static Widget majorCs({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.majorCs, color: color, size: size);

  static Widget majorEng({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.majorEng, color: color, size: size);

  static Widget majorBis({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.majorBis, color: color, size: size);

  static Widget majorDesign({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.majorDesign, color: color, size: size);

  // ==========================================
  // USAGE ICONS (Multicolor SVG)
  // ==========================================
  static Widget usageProgramming({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.usageProgramming, color: color, size: size);

  static Widget usageWeb({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.usageWeb, color: color, size: size);

  static Widget usageApp({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.usageApp, color: color, size: size);

  static Widget usageGaming({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.usageGaming, color: color, size: size);

  static Widget usageGraphic({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.usageGraphic, color: color, size: size);

  static Widget usageVideo({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.usageVideo, color: color, size: size);

  static Widget usageAi({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.usageAi, color: color, size: size);

  static Widget usageCad({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.usageCad, color: color, size: size);

  static Widget usageStudy({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.usageStudy, color: color, size: size);

  // ==========================================
  // BUDGET ICONS (Multicolor SVG)
  // ==========================================
  static Widget budgetLow({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.budgetLow, color: color, size: size);

  static Widget budgetMid({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.budgetMid, color: color, size: size);

  static Widget budgetHigh({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.budgetHigh, color: color, size: size);

  static Widget budgetPro({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.budgetPro, color: color, size: size);

  // ==========================================
  // RECOMMENDATION & CHECKER SPEC ICONS (Monochrome - colorizable per spec)
  // ==========================================
  static Widget specCpu({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.resultCpu, color: color, size: size);

  static Widget specMemory({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.resultMemory, color: color, size: size);

  static Widget specSsd({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.resultSsd, color: color, size: size);

  static Widget specGpu({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.resultGpu, color: color, size: size);

  // ==========================================
  // CHECKER SPECIFIC ICONS
  // ==========================================
  static Widget checkerCpu({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.checkerCpu, color: color, size: size);

  static Widget checkerRam({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.checkerRam, color: color, size: size);

  static Widget checkerStorage({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.checkerStorage, color: color, size: size);

  static Widget checkerGpu({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.checkerGpu, color: color, size: size);
}