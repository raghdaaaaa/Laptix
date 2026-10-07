import 'package:flutter/material.dart';
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
    final highlightStyle = TextStyle(
      fontFamily: 'InterTight',
      fontSize: 30,
      height: 35.5 / 30,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w800,
      color: AppColors.primaryColor,
    );

    final titleStyle = TextStyle(
      fontFamily: 'InterTight',
      fontSize: 30,
      height: 35.5 / 30,
      letterSpacing: -0.3,
      fontWeight: FontWeight.w800,
      color: AppColors.primaryTextColor,
    );

    final words = title.split(highlight);
    final spans = <TextSpan>[];

    for (int i = 0; i < words.length; i++) {
      spans.add(TextSpan(text: words[i], style: titleStyle));
      if (i < words.length - 1) {
        spans.add(TextSpan(text: highlight, style: highlightStyle));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: spans)),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              height: 1.5,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryTextColor,
            ),
          ),
        ],
      ],
    );
  }
}