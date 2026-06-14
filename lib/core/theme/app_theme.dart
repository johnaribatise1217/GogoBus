import 'package:google_fonts/google_fonts.dart';
import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface
      ),

      //typography
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.white
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        labelLarge: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        )
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(

          backgroundColor: WidgetStateProperty.all(AppColors.accent),
          foregroundColor: WidgetStateProperty.all(AppColors.white),

          minimumSize: WidgetStateProperty.all(
            const Size(double.infinity, 54),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: WidgetStateProperty.all(0),
          overlayColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return const Color(0xFFB8720A);
              }
              if (states.contains(WidgetState.focused)) {
                return const Color(0xFFD4890F);
              }
              return Colors.transparent;
            },
          ),
        ),
      ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: AppColors.accent,
      //     foregroundColor: AppColors.white,
      //     minimumSize: const Size(double.infinity, 54),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(15),
      //     ),
      //     textStyle: GoogleFonts.poppins(
      //       fontSize: 15,
      //       fontWeight: FontWeight.w600,
      //     ),
      //     elevation: 0,
      //   ),
      // ),

      //Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error),
        ),
        hintStyle: GoogleFonts.poppins(
          color: AppColors.textHint,
          fontSize: 17,
        ),
      ),
    );
  }
}