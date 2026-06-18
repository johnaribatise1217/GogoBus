import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:bus_ticketing/features/home/models/terminal_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Shimmer.fromColors(
          baseColor: AppColors.divider,
          highlightColor: AppColors.background,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _block(width: 140, height: 18),
                    _block(width: 32, height: 32, radius: 16),
                  ],
                ),
                const SizedBox(height: 20),

                // Subtitle lines
                _block(width: 120, height: 14),
                const SizedBox(height: 8),
                _block(width: double.infinity, height: 14),

                const SizedBox(height: 20),

                // Form card
                _block(width: double.infinity, height: 280, radius: 20),

                const SizedBox(height: 20),

                // Buspoint row
                _block(width: double.infinity, height: 70, radius: 16),

                const SizedBox(height: 24),

                // History header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _block(width: 100, height: 16),
                    _block(width: 60, height: 16),
                  ],
                ),
                const SizedBox(height: 16),

                // History cards
                _block(width: double.infinity, height: 130, radius: 16),
                const SizedBox(height: 12),
                _block(width: double.infinity, height: 130, radius: 16),
                const SizedBox(height: 12),
                _block(width: double.infinity, height: 130, radius: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _block({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class EmptyHistoryState extends StatelessWidget {
  const EmptyHistoryState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        children: [
          Icon(Icons.folder_off_outlined, size: 64, color: AppColors.textHint),
          const SizedBox(height: 16),
          Text(
            'There is nothing here.',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You do not have any trip history yet, please fill out the form above to start purchasing bus tickets.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final bool hasUpcomingTrip;
  final bool hasHistory;

  final Terminal? selectedDeparture;
  final Terminal? selectedDestination;
  final DateTime? selectedDate;
  final VoidCallback onDeparturePressed;
  final VoidCallback onDestinationPressed;
  final VoidCallback onDatePressed;
  final VoidCallback onSwapPressed;
  final VoidCallback onSearchPressed;

  const HomeContent({
    super.key,
    required this.hasUpcomingTrip,
    required this.hasHistory,
    required this.selectedDeparture,
    required this.selectedDestination,
    required this.selectedDate,
    required this.onDeparturePressed,
    required this.onDestinationPressed,
    required this.onDatePressed,
    required this.onSwapPressed,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                decoration: const BoxDecoration(color: AppColors.primary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: AppColors.white,
                            ),
                            children: [
                              const TextSpan(text: 'Hello, '),
                              const TextSpan(
                                text: 'Aribatise John',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.help_outline_rounded,
                            color: AppColors.primary,
                            size: 18,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Welcome to GOGOBUS',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.whiteMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Safe and Comfortable Travel to Your Destination',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              Transform.translate(
                offset: const Offset(0, -20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BookingFormCard(
                    selectedDeparture: selectedDeparture,
                    selectedDestination: selectedDestination,
                    selectedDate: selectedDate,
                    onDeparturePressed: onDeparturePressed,
                    onDestinationPressed: onDestinationPressed,
                    onDatePressed: onDatePressed,
                    onSwapPressed: onSwapPressed,
                    onSearchPressed: onSearchPressed,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              //Buspoint row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const BuspointCard(),
              ),

              const SizedBox(height: 24),

              //Upcoming trip card
              if (hasUpcomingTrip)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const UpcomingTripCard(),
                ),

              if (hasUpcomingTrip) const SizedBox(height: 24),

              //History section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'History',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: Text(
                            hasHistory ? '24' : '0',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (hasHistory)
                      Row(
                        children: [
                          Text(
                            'View All',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 12,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              if (hasHistory)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: List.generate(3, (i) => const HistoryCard())
                        .expand((card) => [card, const SizedBox(height: 12)])
                        .toList(),
                  ),
                )
              else
                const EmptyHistoryState(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingFormCard extends StatelessWidget {
  final Terminal? selectedDeparture;
  final Terminal? selectedDestination;
  final DateTime? selectedDate;
  final VoidCallback onDeparturePressed;
  final VoidCallback onDestinationPressed;
  final VoidCallback onDatePressed;
  final VoidCallback onSwapPressed;
  final VoidCallback onSearchPressed;

  const BookingFormCard({
    super.key,
    required this.selectedDeparture,
    required this.selectedDestination,
    required this.selectedDate,
    required this.onDeparturePressed,
    required this.onDestinationPressed,
    required this.onDatePressed,
    required this.onSwapPressed,
    required this.onSearchPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Complete the form below to purchase\nGOGOBUS tickets',
            style: GoogleFonts.poppins(
              fontSize: 13,
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
                    onTap: onDeparturePressed,
                    child: _selectField(
                      label: 'Departure',
                      hint: selectedDeparture?.city ?? 'Select departure point',
                      icon: Icons.radio_button_checked,
                      isFilled: selectedDeparture != null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: onDestinationPressed,
                    child: _selectField(
                      label: 'Destination',
                      hint: selectedDestination?.city ?? 'Select destination',
                      icon: Icons.location_on_outlined,
                      isFilled: selectedDestination != null,
                    ),
                  ),
                ],
              ),

              Positioned(
                right: 15,
                top: 75,
                child: GestureDetector(
                  onTap: onSwapPressed,
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

          Text(
            'Date',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onDatePressed,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: selectedDate != null
                        ? AppColors.primary
                        : AppColors.textHint,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    selectedDate != null
                      ? _formatDate(selectedDate!)
                      : 'dd/mm/yyyy',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: selectedDate != null
                        ? AppColors.textDark
                        : AppColors.textHint,
                      fontWeight: selectedDate != null
                        ? FontWeight.w600
                        : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: onSearchPressed,
            child: const Text('Search Ticket'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Widget _selectField({
    required String label,
    required String hint,
    required IconData icon,
    required bool isFilled,
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
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isFilled ? AppColors.primary : AppColors.textHint,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hint,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: isFilled ? AppColors.textDark : AppColors.textHint,
                    fontWeight: isFilled ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.textHint,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BuspointCard extends StatelessWidget {
  const BuspointCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              color: AppColors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buspoint',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '850 pt',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.redeem_rounded,
                  size: 16,
                  color: AppColors.accent,
                ),
                const SizedBox(width: 6),
                Text(
                  'Redeem',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingTripCard extends StatelessWidget {
  const UpcomingTripCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.directions_bus_rounded,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bus Number',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.whiteMuted,
                        ),
                      ),
                      Text(
                        'S 4455 BC',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Pending Boarding',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Route row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Madiun',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    '12:00 WIB',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.whiteMuted,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.whiteMuted.withValues(alpha: 0.3),
                        ),
                      ),
                      const Icon(
                        Icons.directions_bus_rounded,
                        color: AppColors.accent,
                        size: 16,
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: AppColors.whiteMuted.withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Yogyakarta',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    '17:00 WIB',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.whiteMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(
            color: AppColors.whiteMuted.withValues(alpha: 0.15),
            height: 1,
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _tag(icon: Icons.person_outline_rounded, label: '1'),
                  const SizedBox(width: 8),
                  _tag(icon: Icons.restaurant_outlined, label: 'Meal Service'),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // TODO: navigate to trip detail
                },
                child: Row(
                  children: [
                    Text(
                      'Detail',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.white,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tag({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.whiteMuted),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: AppColors.whiteMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Departure',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'Yogyakarta',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Destination',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'Madiun',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 14,
                color: AppColors.textHint,
              ),
              const SizedBox(width: 6),
              Text(
                'Wed, 24 Oct 2024',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                '17:00 WIB',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _tagLight(icon: Icons.person_outline_rounded, label: '1'),
              const SizedBox(width: 8),
              _tagLight(icon: Icons.cookie_outlined, label: 'Snack Only'),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  'Finished',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tagLight({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
