import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:bus_ticketing/features/onboarding/models/onboarding_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/onboarding_slide.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();

}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  void onPageChanged(int index) {
    setState(() => currentPage = index);
  }

  @override
  void handleNext(){
    if(currentPage < onboardingSlides.length - 1){
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut
      );
    } else {
      //navigate to get started
      context.go('/get-started');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentPage == onboardingSlides.length - 1;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 20),
                child: TextButton(
                  onPressed: () => context.go('/get-started'),
                  child: Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteMuted,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 36),

            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: onPageChanged,
                itemCount: onboardingSlides.length,
                itemBuilder: (context, index) {
                  return OnboardingSlide(data: onboardingSlides[index]);
                },
              ),
            ),

            SmoothPageIndicator(
              controller: pageController,
              count: onboardingSlides.length,
              effect: const WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: AppColors.accent,
                dotColor: AppColors.whiteMuted,
                spacing: 8,
              ),
            ),

            const SizedBox(height: 36),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Get Started / Next button
                  ElevatedButton(
                    onPressed: handleNext,
                    child: Text(isLastPage ? 'Get Started' : 'Next'),
                  ),

                  const SizedBox(height: 16),

                  // Register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteMuted,
                          fontSize: 13,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.go('/register'),
                        child: Text(
                          'Register Account',
                          style: GoogleFonts.poppins(
                            color: AppColors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        )
      ),
    );
  }

}