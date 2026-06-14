import 'package:bus_ticketing/features/home/widgets/home_components.dart';
import 'package:flutter/material.dart';

enum HomeState { loading, empty, populated }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeState _state = HomeState.populated;

  @override
  void initState() {
    super.initState();
    // remove once Dio is wired
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _state = HomeState.populated);
    });
    _state = HomeState.loading;
  }

   @override
  Widget build(BuildContext context) {
    switch (_state) {
      case HomeState.loading:
        return const HomeSkeleton();
      case HomeState.empty:
        return const HomeContent(hasUpcomingTrip: false, hasHistory: false);
      case HomeState.populated:
        return const HomeContent(hasUpcomingTrip: true, hasHistory: true);
    }
  }
}
