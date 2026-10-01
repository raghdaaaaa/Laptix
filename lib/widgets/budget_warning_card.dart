import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/Core/Constants/app_colors.dart';

class BudgetWarningCard extends StatelessWidget {
  const BudgetWarningCard({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warningBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.warningColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.budgetWarningTitle,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.warningTextColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.5,
              color: AppColors.warningTextColor,
            ),
          ),
        ],
      ),
    );
  }
}