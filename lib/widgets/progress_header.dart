import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class StepHeader extends StatelessWidget {
  final String title;
  final String highlight;
  final String? subtitle;

  const StepHeader({
    super.key,
    required this.title,
    required this.highlight,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.urbanist(
      fontSize: 28,
      height: 1.2,
      fontWeight: FontWeight.w800,
      color: AppColors.primaryColor,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: titleStyle,
            children: [
              TextSpan(text: '$title '),
              TextSpan(
                text: highlight,
                style: titleStyle.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: GoogleFonts.urbanist(
              fontSize: 15,
              height: 1.4,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }
}