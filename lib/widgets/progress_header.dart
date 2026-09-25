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
    final highlightStyle = GoogleFonts.inter(
      fontSize: 40,
      height: 44 / 40,
      letterSpacing: -0.025 * 40,
      fontWeight: FontWeight.w800,
      color: const Color(0xFF1E3A8A),
    );

    final titleStyle = GoogleFonts.inter(
      fontSize: 40,
      height: 44 / 40,
      letterSpacing: -0.025 * 40,
      fontWeight: FontWeight.w800,
      color: const Color(0xFF1F2937),
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
        Text.rich(
          TextSpan(children: spans),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 24),
          Text(
            subtitle!,
            style: GoogleFonts.inter(
              fontSize: 18,
              height: 29.25 / 18,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ],
    );
  }
}