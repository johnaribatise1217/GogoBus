import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedScreen extends StatelessWidget{
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(
                    'assets/icons/logo-bus.png',
                    width: screenHeight * 0.18,
                    height: screenHeight * 0.18
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to GOGOBUS',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Safe and Comfortable Travel to Your Destination',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.whiteMuted,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Login button
                    ElevatedButton(
                      onPressed: () => context.go('/login'),
                      child: const Text('Login'),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.whiteMuted.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'or log in using',
                            style: GoogleFonts.poppins(
                              color: AppColors.whiteMuted,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.whiteMuted.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _socialButton('assets/icons/google_logo.png'),
                        const SizedBox(width: 12),
                        _socialButton('assets/icons/facebook_logo.png'),
                        const SizedBox(width: 12),
                        _socialButton('assets/icons/apple_logo.png'),
                        const SizedBox(width: 12),
                        _socialButton('assets/icons/phone_logo.png'),
                      ],
                    ),
                    const SizedBox(height: 15),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String svgPath) {
    return Container(
      width: 83,
      height: 58,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Image.asset(
          svgPath,
          width: 30,
          height: 30,
          // placeholderBuilder: (_) => const Icon(
          //   Icons.circle_outlined,
          //   size: 24,
          //   color: AppColors.textSecondary,
          // ),
        ),
      ),
    );
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
}

