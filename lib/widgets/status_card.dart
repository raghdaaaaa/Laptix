import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:laptix/Core/Constants/app_colors.dart';
import 'package:laptix/Core/Constants/app_assets.dart';

class LabeledDropdown<T> extends StatelessWidget {
  final String label;
  final String iconPath;
  final T value;
  final List<T> items;
  final String Function(T) itemText;
  final ValueChanged<T?> onChanged;

  const LabeledDropdown({
    super.key,
    required this.label,
    required this.iconPath,
    required this.value,
    required this.items,
    required this.itemText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: AppColors.secondaryTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor, width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              icon: SvgPicture.asset(
                AppAssets.iconChevronDown,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              ),
              items: items
                  .map((item) => DropdownMenuItem<T>(
                        value: item,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              iconPath,
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              itemText(item),
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.charcoal,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: onChanged,
              dropdownColor: AppColors.cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}