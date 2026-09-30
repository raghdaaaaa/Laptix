import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary & Secondary Brand Colors
  static const Color primaryColor = Color(0xFF1E3A8A); // Deep Blue
  static const Color secondaryColor = Color(0xFF06B6D4); // Cyan

  // Background & Surface Colors
  static const Color backgroundColor = Color(0xFFF3F4F6); // Gray 100
  static const Color backgroundLight = Color(0xFFF9FAFB); // Gray 50
  static const Color cardColor = Color(0xFFFFFFFF); // White
  static const Color inputBackgroundColor = Color(0xFFF9FAFB); // Gray 50

  // Text Colors
  static const Color primaryTextColor = Color(0xFF1F2937); // Gray 800
  static const Color secondaryTextColor = Color(0xFF6B7280); // Gray 500
  static const Color hintTextColor = Color(0xFF9CA3AF); // Gray 400
  static const Color charcoal = Color(0xFF1F2937); // Dark gray
  static const Color white = Color(0xFFFFFFFF);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Border & Divider Colors
  static const Color borderColor = Color(0xFFE5E7EB); // Gray 200
  static const Color dividerColor = Color(0xFFE5E7EB);

  // State / Feedback Colors
  static const Color successColor = Color(0xFF10B981); // Emerald 500
  static const Color successBackgroundColor = Color(0xFFECFDF5); // Emerald 50
  static const Color successBorderColor = Color(0xFFD1FAE5); // Emerald 100
  static const Color successTextColor = Color(0xFF064E3B); // Emerald 900
  static const Color successSecondaryTextColor = Color(0xFF047857); // Emerald 700

  static const Color warningColor = Color(0xFFF59E0B); // Amber 500
  static const Color warningBackgroundColor = Color(0xFFFFF8E1); // Amber 50
  static const Color warningBorderColor = Color(0xFFFEF3C7); // Amber 100
  static const Color warningTextColor = Color(0xFF78350F); // Amber 900

  static const Color errorColor = Color(0xFFEF4444); // Red 500
  static const Color errorBackgroundColor = Color(0xFFFEF2F2); // Red 50
  static const Color errorBorderColor = Color(0xFFFEE2E2); // Red 100
  static const Color errorTextColor = Color(0xFF7F1D1D); // Red 900

  // Other specific accents
  static const Color indigoAccent = Color(0xFF6366F1); // Indigo
  static const Color purpleAccent = Color(0xFF8B5CF6); // Purple
  static const Color orangeAccent = Color(0xFFF97316); // Orange
  static const Color pinkAccent = Color(0xFFEC4899); // Pink
  static const Color blackColor = Color(0xFF000000); // Black

  // Overlay Colors
  static const Color cyanOverlay = Color(0x1A06B6D4); // 10% cyan
  static const Color blueOverlay = Color(0x1A1E3A8A); // 10% blue
  static const Color blackOverlay10 = Color(0x1A000000); // 10% black
  static const Color blackOverlay20 = Color(0x33000000); // 20% black
  static const Color blackOverlay30 = Color(0x4D000000); // 30% black
  static const Color blackOverlay50 = Color(0x80000000); // 50% black

  // Shadow Colors
  static const Color shadowColorPrimary = Color(0x1E1E3A8A); // Primary 12%
  static const Color shadowColorPrimaryMedium = Color(0x2E1E3A8A); // Primary 18%
  static const Color shadowColorBlack = Color(0x14000000); // Black 8%
  static const Color shadowColorBlackMedium = Color(0x1A000000); // Black 10%

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1E3A8A), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF1E3A8A), Color(0xFF1E40AF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bottomGradientOverlay = LinearGradient(
    colors: [Color(0x00FFFFFF), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}