import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const SafeArea(
        child: Center(
          child: Text('Activity — coming soon')
        ),
      ),
    );
  }
}