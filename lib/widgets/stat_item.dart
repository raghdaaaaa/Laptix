import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class StatItem extends StatelessWidget {
  final String value;
  final String label;

  const StatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.urbanist(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryTextColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: GoogleFonts.urbanist(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

class StatsRow extends StatelessWidget {
  final List<StatItem> stats;

  const StatsRow({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(stats.length * 2 - 1, (index) {
        if (index.isEven) return stats[index ~/ 2];
        return Container(
          width: 1,
          height: 36,
          color: Colors.grey.shade200,
        );
      }),
    );
  }
}