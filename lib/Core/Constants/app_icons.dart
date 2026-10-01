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

  static Widget arrowForward({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.commonArrowForward, color: color, size: size);

  static Widget chevronLeft({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.commonChevronLeft, color: color, size: size);

  static Widget chevronRight({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.commonChevronRight, color: color, size: size);

  static Widget chevronDown({Color? color, double size = 16}) =>
      _buildSvg(AppAssets.commonChevronDown, color: color, size: size);

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

  static Widget info({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.commonInfo, color: color, size: size);

  static Widget star({Color? color, double size = 18}) =>
      _buildSvg(AppAssets.commonStar, color: color, size: size);

  static Widget verified({Color? color, double size = 18}) =>
      _buildSvg(AppAssets.commonVerified, color: color, size: size);

  static Widget suitableCheck({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.commonSuitableCheck, color: color, size: size);

  // Alias getters for backward compatibility
  static Widget arrowBackIos({Color? color, double size = 20}) => chevronLeft(color: color, size: size);
  static Widget iconChevronRight({Color? color, double size = 20}) => chevronRight(color: color, size: size);
  static Widget iconChevronLeft({Color? color, double size = 20}) => chevronLeft(color: color, size: size);
  static Widget iconChevronDown({Color? color, double size = 16}) => chevronDown(color: color, size: size);
  static Widget iconCheck({Color? color, double size = 18}) => check(color: color, size: size);
  static Widget iconCheckCircle({Color? color, double size = 24}) => checkCircle(color: color, size: size);
  static Widget iconWarning({Color? color, double size = 24}) => warning(color: color, size: size);
  static Widget iconInfo({Color? color, double size = 20}) => info(color: color, size: size);
  static Widget iconStar({Color? color, double size = 18}) => star(color: color, size: size);
  static Widget iconVerified({Color? color, double size = 18}) => verified(color: color, size: size);
  static Widget iconArrowForward({Color? color, double size = 20}) => arrowForward(color: color, size: size);
  static Widget iconArrowBack({Color? color, double size = 20}) => arrowBack(color: color, size: size);
  static Widget iconClose({Color? color, double size = 20}) => close(color: color, size: size);
  static Widget iconMenu({Color? color, double size = 20}) => menu(color: color, size: size);
  static Widget iconAdd({Color? color, double size = 24}) => navAdd(color: color, size: size);
  static Widget iconSearch({Color? color, double size = 20}) => search(color: color, size: size);

  // ==========================================
  // NAVIGATION ICONS (Monochrome - colorizable)
  // ==========================================
  static Widget navHome({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.navHome, color: color, size: size);

  static Widget navChecker({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.navChecker, color: color, size: size);

  static Widget navAdd({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.navAdd, color: color, size: size);

  static Widget navExplore({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.navExplore, color: color, size: size);

  static Widget navProfile({Color? color, double size = 24}) =>
      _buildSvg(AppAssets.navProfile, color: color, size: size);

  // NOTE: Active state icons (navHomeActive, navCheckerActive, navExploreActive, navProfileActive) are MISSING from disk

  // ==========================================
  // HOME SCREEN ICONS
  // ==========================================
  static Widget menu({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.homeMenu, color: color, size: size);

  // Multicolor - preserves original colors
  static Widget homeHero({double? width, double? height, double? size}) =>
      _buildSvgMulti(AppAssets.homeHero, width: width, height: height, size: size);

  static Widget homePerformance({double? width, double? height, double? size}) =>
      _buildSvgMulti(AppAssets.homePerformance, width: width, height: height, size: size);

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

  static Widget majorEdit({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.majorEdit, color: color, size: size);

  static Widget majorOther({Color? color, double size = 48}) =>
      _buildSvg(AppAssets.majorOther, color: color, size: size);

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

  static Widget checkerBottomArrow({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.checkerBottomArrow, color: color, size: size);

  static Widget checkerCheck({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.checkerCheck, color: color, size: size);

  static Widget checkerTips({Color? color, double size = 20}) =>
      _buildSvg(AppAssets.checkerTips, color: color, size: size);

  // NOTE: checkerStatusWarning, checkerBgPattern, checkerInfoDot, checkerResultBadge, checkerSpecIcon are MISSING from disk

  // ==========================================
  // BACKWARD COMPATIBILITY ALIASES
  // ==========================================
  static Widget specProcessor({Color? color, double size = 24}) => specCpu(color: color, size: size);
  static Widget specStorage({Color? color, double size = 24}) => specSsd(color: color, size: size);
  static Widget specGraphics({Color? color, double size = 24}) => specGpu(color: color, size: size);

  static Widget majorComputerScience({Color? color, double size = 48}) => majorCs(color: color, size: size);
  static Widget majorEngineering({Color? color, double size = 48}) => majorEng(color: color, size: size);
  static Widget majorBusiness({Color? color, double size = 48}) => majorBis(color: color, size: size);
  static Widget majorMedia({Color? color, double size = 48}) => majorDesign(color: color, size: size); // fallback

  static Widget usageWebDev({Color? color, double size = 48}) => usageWeb(color: color, size: size);
  static Widget usageAndroidDev({Color? color, double size = 48}) => usageApp(color: color, size: size);
  static Widget usageGraphicDesign({Color? color, double size = 48}) => usageGraphic(color: color, size: size);
  static Widget usageVideoEditing({Color? color, double size = 48}) => usageVideo(color: color, size: size);
  static Widget usageAIML({Color? color, double size = 48}) => usageAi(color: color, size: size);
  static Widget usage3DCAD({Color? color, double size = 48}) => usageCad(color: color, size: size);

  static Widget budgetEntry({Color? color, double size = 48}) => budgetLow(color: color, size: size);

  static Widget checkerProcessor({Color? color, double size = 24}) => checkerCpu(color: color, size: size);
  static Widget checkerMemory({Color? color, double size = 24}) => checkerRam(color: color, size: size);
  static Widget checkerGraphics({Color? color, double size = 24}) => checkerGpu(color: color, size: size);
}