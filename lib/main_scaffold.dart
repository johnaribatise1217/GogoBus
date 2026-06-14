import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  Widget _navItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isActive = navigationShell.currentIndex == index;
    final color = isActive ? AppColors.accent : AppColors.textHint;

    return Expanded(
      child: GestureDetector(
        onTap: () => navigationShell.goBranch(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: AppColors.textDark.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),

        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: [
                _navItem(
                  context,
                  index: 0,
                  icon: Icons.home_rounded,
                  label: 'Home',
                ),
                _navItem(
                  context,
                  index: 1,
                  icon: Icons.swap_horiz_rounded,
                  label: 'Activity',
                ),
                _navItem(
                  context,
                  index: 2,
                  icon: Icons.inbox_rounded,
                  label: 'Notification',
                ),
                _navItem(
                  context,
                  index: 3,
                  icon: Icons.person_rounded,
                  label: 'Profile',
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
