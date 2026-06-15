import 'package:bus_ticketing/features/home/models/terminal_data.dart';
import 'package:bus_ticketing/features/home/widgets/date_picker_sheet.dart';
import 'package:bus_ticketing/features/home/widgets/home_components.dart';
import 'package:bus_ticketing/features/home/widgets/location_picker_sheet.dart';
import 'package:flutter/material.dart';

enum HomeState { loading, empty, populated }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeState _state = HomeState.populated;

  //booking form states
  Terminal? _selectedDeparture;
  Terminal? _selectedDestination;
  DateTime? _selectedDate;

  Future<void> _onDeparturePressed() async {
    final departure = await LocationPickerSheet.show(
      context: context,
      isDeparture: true,
      selected: _selectedDeparture,
    );
    if (departure != null) {
      setState(() => _selectedDeparture = departure);
    }
  }

  Future<void> _onDestinationPressed() async {
    final destination = await LocationPickerSheet.show(
      context: context,
      isDeparture: false,
      selected: _selectedDestination,
    );
    if (destination != null) {
      setState(() => _selectedDestination = destination);
    }
  }

  Future<void> _onDatePressed() async {
    final date = await DatePickerSheet.show(
      context: context,
      selected: _selectedDate,
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  void _onSwapPressed() {
    setState(() {
      final temp = _selectedDeparture;
      _selectedDeparture = _selectedDestination;
      _selectedDestination = temp;
    });
  }


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
      case HomeState.populated:
        return HomeContent(
          hasUpcomingTrip: _state == HomeState.populated,
          hasHistory: _state == HomeState.populated,
          selectedDeparture: _selectedDeparture,
          selectedDestination: _selectedDestination,
          selectedDate: _selectedDate,
          onDeparturePressed: _onDeparturePressed,
          onDestinationPressed: _onDestinationPressed,
          onDatePressed: _onDatePressed,
          onSwapPressed: _onSwapPressed,
        );
    }
  }
}
