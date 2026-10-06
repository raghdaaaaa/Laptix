import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laptix/Core/Constants/app_assets.dart';

class AppIcons {
  AppIcons._();

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

  static Widget arrowBackIos({Color? color, double size = 20}) => chevronLeft(color: color, size: size);

  static Widget iconChevronRight({Color? color, double size = 20}) => chevronRight(color: color, size: size);

  static Widget iconSearch({Color? color, double size = 20}) => search(color: color, size: size);
}