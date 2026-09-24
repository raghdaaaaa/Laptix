import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class SpecificationCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const SpecificationCard({
    super.key,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.urbanist(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.urbanist(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColor.charcoal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.urbanist(
              fontSize: 11,
              height: 1.3,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}