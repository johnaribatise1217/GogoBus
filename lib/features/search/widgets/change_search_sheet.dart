import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:bus_ticketing/core/utils/formatters.dart';
import 'package:bus_ticketing/features/home/models/terminal_data.dart';
import 'package:bus_ticketing/features/home/widgets/app_bottom_sheet.dart';
import 'package:bus_ticketing/features/home/widgets/date_picker_sheet.dart';
import 'package:bus_ticketing/features/home/widgets/location_picker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeSearchResult {
  final Terminal departure;
  final Terminal destination;
  final DateTime date;

  const ChangeSearchResult({
    required this.departure,
    required this.destination,
    required this.date,
  });
}

class ChangeSearchSheet {
  ChangeSearchSheet._();

  static Future<ChangeSearchResult?> show({
    required BuildContext context,
    required Terminal departure,
    required Terminal destination,
    required DateTime date,
  }) {
    return AppBottomSheet.show<ChangeSearchResult>(
      context: context,
      title: 'Change Search',
      child: _ChangeSearchBody(
        initialDeparture: departure,
        initialDestination: destination,
        initialDate: date,
      ),
    );
  }
}

class _ChangeSearchBody extends StatefulWidget {
  final Terminal initialDeparture;
  final Terminal initialDestination;
  final DateTime initialDate;

  const _ChangeSearchBody({
    required this.initialDeparture,
    required this.initialDestination,
    required this.initialDate,
  });

  @override
  State<_ChangeSearchBody> createState() => _ChangeSearchBodyState();
}

class _ChangeSearchBodyState extends State<_ChangeSearchBody> {
  late Terminal _departure;
  late Terminal _destination;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _departure = widget.initialDeparture;
    _destination = widget.initialDestination;
    _date = widget.initialDate;
  }

  Future<void> _pickDeparture() async {
    final result = await LocationPickerSheet.show(
      context: context,
      isDeparture: true,
      selected: _departure,
    );
    if (result != null) {
      setState(() => _departure = result);
    }
  }

  Future<void> _pickDestination() async {
    final result = await LocationPickerSheet.show(
      context: context,
      isDeparture: false,
      selected: _destination,
    );
    if (result != null) {
      setState(() => _destination = result);
    }
  }

  Future<void> _pickDate() async {
    final result = await DatePickerSheet.show(
      context: context,
      selected: _date,
    );
    if (result != null) {
      setState(() => _date = result);
    }
  }

  void _swap() {
    setState(() {
      final temp = _departure;
      _departure = _destination;
      _destination = temp;
    });
  }

  void _handleSearch() {
    Navigator.pop(
      context,
      ChangeSearchResult(
        departure: _departure,
        destination: _destination,
        date: _date,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete the form below to purchase\nGOGOBUS tickets',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),

                Stack(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _pickDeparture,
                          child: _field(
                            label: 'Departure',
                            value: _departure.city,
                            icon: Icons.radio_button_checked,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: _pickDestination,
                          child: _field(
                            label: 'Destination',
                            value: _destination.city,
                            icon: Icons.location_on_outlined,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 15,
                      top: 75,
                      child: GestureDetector(
                        onTap: _swap,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.swap_vert_rounded,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                GestureDetector(
                  onTap: _pickDate,
                  child: _field(
                    label: 'Date',
                    value: formatDate(_date),
                    icon: Icons.calendar_today_outlined,
                    highlighted: true,
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: _handleSearch,
                  child: const Text('Search Tickets'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _field({
    required String label,
    required String value,
    required IconData icon,
    bool highlighted = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: highlighted ? AppColors.accent : AppColors.divider,
              width: highlighted ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: AppColors.textHint),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.textHint),
            ],
          ),
        ),
      ],
    );
  }
}
