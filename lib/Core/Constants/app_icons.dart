import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laptix/Core/Constants/app_assets.dart';

class AppIcons {
  AppIcons._();

  // Navigation - Custom SVG Icons
  static Widget navHome({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.navHome,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget navHomeActive({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.navHomeActive,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget navChecker({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.navChecker,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget navCheckerActive({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.navCheckerActive,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget navExplore({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.navExplore,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget navExploreActive({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.navExploreActive,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget navProfile({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.navProfile,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget navProfileActive({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.navProfileActive,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );

  // Actions - Custom SVG Icons
  static Widget iconSearch({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconSearch,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconChevronRight({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconChevronRight,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconChevronLeft({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconChevronLeft,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconChevronDown({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconChevronDown,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconCheck({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconCheck,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconCheckCircle({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconCheckCircle,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconWarning({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconWarning,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconInfo({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconInfo,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconStar({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconStar,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconVerified({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconVerified,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconArrowForward({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconArrowForward,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconArrowBack({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconArrowBack,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconClose({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconClose,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconMenu({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconMenu,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget iconAdd({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.iconAdd,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );

  // Major Icons - Custom SVG
  static Widget majorComputerScience({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.majorComputerScience,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget majorEngineering({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.majorEngineering,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget majorBusiness({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.majorBusiness,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget majorDesign({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.majorDesign,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget majorMedia({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.majorMedia,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget majorOther({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.majorOther,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );

  // Usage Icons - Custom SVG
  static Widget usageAndroidDev({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.usageAndroidDev,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget usageGaming({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.usageGaming,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget usageGraphicDesign({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.usageGraphicDesign,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget usageVideoEditing({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.usageVideoEditing,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget usage3DCAD({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.usage3DCAD,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget usageStudy({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.usageStudy,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget usageProgramming({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.usageProgramming,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget usageWebDev({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.usageWebDev,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget usageAIML({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.usageAIML,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );

  // Budget Icons - Custom SVG
  static Widget budgetEntry({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.budgetEntry,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget budgetMid({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.budgetMid,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget budgetHigh({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.budgetHigh,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget budgetPro({Color? color, double size = 48}) => SvgPicture.asset(
        AppAssets.budgetPro,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );

  // Specification Icons - Custom SVG
  static Widget specProcessor({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.specProcessor,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget specMemory({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.specMemory,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget specStorage({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.specStorage,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
  static Widget specGraphics({Color? color, double size = 24}) => SvgPicture.asset(
        AppAssets.specGraphics,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );

  // Getters for SVG widgets matching exact Figma exports
  static Widget arrowBackIos({Color? color, double size = 20}) => SvgPicture.asset(
        AppAssets.iconChevronLeft,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );

  static Widget close({Color? color, double size = 20}) => SvgPicture.asset(
        AppAssets.iconClose,
        colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
        width: size,
        height: size,
      );
}