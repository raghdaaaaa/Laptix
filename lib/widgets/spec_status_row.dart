import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

enum SpecStatus { perfect, optimal, good, poor }

class SpecStatusRow extends StatelessWidget {
  final IconData icon;
  final String label;  
  final String value;   
  final SpecStatus status;

  const SpecStatusRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.status,
  });

  ({String text, Color color, IconData icon}) get _statusStyle {
    switch (status) {
      case SpecStatus.perfect:
        return (text: 'Perfect', color: Colors.green, icon: Icons.check_circle);
      case SpecStatus.optimal:
        return (text: 'Optimal', color: Colors.green, icon: Icons.check_circle);
      case SpecStatus.good:
        return (text: 'Good', color: Colors.orange, icon: Icons.info);
      case SpecStatus.poor:
        return (text: 'Poor', color: Colors.red, icon: Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _statusStyle;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          StatusIconBox(icon: icon, color: AppColors.primaryColor, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: GoogleFonts.urbanist(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: Colors.grey.shade500,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColor.charcoal,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                s.text,
                style: GoogleFonts.urbanist(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: s.color,
                ),
              ),
              const SizedBox(width: 4),
              Icon(s.icon, size: 16, color: s.color),
            ],
          ),
        ],
      ),
    );
  }
}