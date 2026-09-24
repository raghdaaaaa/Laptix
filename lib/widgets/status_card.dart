import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class LabeledDropdown<T> extends StatelessWidget {
  final String label;
  final IconData icon;
  final T value;
  final List<T> items;
  final String Function(T) itemText;
  final ValueChanged<T?> onChanged;

  const LabeledDropdown({
    super.key,
    required this.label,
    required this.icon,
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
          style: GoogleFonts.urbanist(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
              items: items
                  .map((item) => DropdownMenuItem<T>(
                        value: item,
                        child: Row(
                          children: [
                            Icon(icon, size: 18, color: AppColors.primaryColor),
                            const SizedBox(width: 10),
                            Text(
                              itemText(item),
                              style: GoogleFonts.urbanist(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColor.charcoal,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}