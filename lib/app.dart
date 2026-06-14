import 'package:bus_ticketing/core/router/app.router.dart';
import 'package:bus_ticketing/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GogoBusApp extends StatelessWidget{
  const GogoBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "GogoBus",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }

}