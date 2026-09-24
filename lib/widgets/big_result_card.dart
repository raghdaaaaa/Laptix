import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class BigResultCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Widget title;   
  final String subtitle;
  final bool filled;  

  const BigResultCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color = AppColors.primaryColor,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, color: Colors.white, size: 34),
        ),
        const SizedBox(height: 16),
        DefaultTextStyle(
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColor.charcoal,
          ),
          textAlign: TextAlign.center,
          child: title,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.urbanist(
            fontSize: 13,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
      ],
    );

    if (!filled) return content;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: content,
    );
  }
}