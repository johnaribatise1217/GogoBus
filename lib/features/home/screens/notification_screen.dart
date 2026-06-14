import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const SafeArea(
        child: Center(child: Text('Notification — coming soon')),
      ),
    );
  }
}