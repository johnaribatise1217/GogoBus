import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // prevents instantiation

  // Primary brand colors
  static const Color primary     = Color(0xFF013E4B);
  static const Color primaryMid  = Color(0xFF02536A); // slightly lighter for cards/surfaces
  static const Color primaryLight = Color(0xFF036A87);

  // Accent
  static const Color accent         = Color(0xFFF5951F);

  // Neutrals
  static const Color white          = Color(0xFFFFFFFF);
  static const Color whiteMuted     = Color(0xB3FFFFFF); // white 70%
  static const Color background     = Color(0xFFF7F8FA);
  static const Color surface        = Color(0xFFFFFFFF);

  // Text
  static const Color textDark       = Color(0xFF1C1C1E);
  static const Color textSecondary  = Color(0xFF6B7280);
  static const Color textHint       = Color(0xFF9CA3AF);

  // Social buttons
  static const Color socialBg       = Color(0xFFF5F5F5);

  // Status
  static const Color success        = Color(0xFF27AE60);
  static const Color error          = Color(0xFFEB5757);
  static const Color warning        = Color(0xFFF2994A);
  static const Color divider        = Color(0xFFE5E7EB);
}