import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:bus_ticketing/features/onboarding/models/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingSlide extends StatelessWidget{
  final OnboardingData data;
  const OnboardingSlide({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
     children: [
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20),
         child: Column(
           children: [
             Text(
               data.title,
               textAlign: TextAlign.center,
               style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  height: 1.4 // line height
               ),
             ),
             const SizedBox(height: 12),
             Text(
               data.subtitle,
               textAlign: TextAlign.center,
               style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteMuted,
                  height: 1.4 // line height
               ),
             )
           ],
         ),
       ),
       const SizedBox(height: 25),
       SizedBox(
         height: screenHeight * 0.4,
         width: double.infinity,
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 32),
           child: Image.asset(
             data.imagePath,
             fit: BoxFit.contain,
             errorBuilder: (context, error, stackTrace) => _placeHolder(),
           ),
         ),
       ),
     ],
    );
  }

}

Widget _placeHolder() {
  return Container(
    margin: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.primaryMid,
      borderRadius: BorderRadius.circular(20)
    ),
    child: const Center(
      child: Icon(
        Icons.directions_bus, size: 80, color: AppColors.whiteMuted,
      ),
    ),
  );
}