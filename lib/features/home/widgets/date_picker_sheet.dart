import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:bus_ticketing/features/home/widgets/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePickerSheet {
  DatePickerSheet._();

  static Future<DateTime?> show({
    required BuildContext context,
    DateTime? selected,
  }) {
    return AppBottomSheet.show<DateTime>(
      context: context,
      title: 'Select Departure Date',
      child: _DatePickerBody(selected: selected),
    );
  }
}

class _DatePickerBody extends StatefulWidget {
  final DateTime? selected;
  const _DatePickerBody({this.selected});

  @override
  State<StatefulWidget> createState() => _DatePickerBodyState();
}

class _DatePickerBodyState extends State<_DatePickerBody> {
  late DateTime _focusedMonth;
  DateTime? _selectedDate;
  final DateTime _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selected;
    _focusedMonth = widget.selected ?? _today;
  }

  bool _isPastDate(DateTime day) {
    final todayDateOnly = DateTime(_today.year, _today.month, _today.day);
    final dayDateOnly = DateTime(day.year, day.month, day.day);
    return dayDateOnly.isBefore(todayDateOnly);
  }

  String _formatFullDate(DateTime date) {
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday',
    ];
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];
    return '$weekday, $month ${date.day}, ${date.year}';
  }

  void _handleSave() {
    Navigator.pop(context, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //table_calendar handles month navigation, weekday headers,
          // and day cell layout
          TableCalendar(
            firstDay: _today,
            lastDay: DateTime(_today.year + 1, 12, 31),
            focusedDay: _focusedMonth,
            currentDay: _today,
            selectedDayPredicate: (day) =>
              _selectedDate != null && isSameDay(_selectedDate, day),

            //only allow today and future dates to be selectable
            enabledDayPredicate: (day) => !_isPastDate(day),

            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedMonth = focusedDay;
              });
            },

            onPageChanged: (focusedDay) {
              setState(() => _focusedMonth = focusedDay);
            },

            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: GoogleFonts.manrope(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                color: AppColors.textSecondary,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
              weekendStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),

            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,

              //  default day text
              defaultTextStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textDark,
              ),

              // disabled (past) day text
              disabledTextStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textHint,
              ),

              // today: outlined circle
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.accent, width: 1.5),
              ),
              todayTextStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),

              // selected: filled circle
              selectedDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
              ),
              selectedTextStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // legend row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendItem(
                color: AppColors.textHint,
                label: 'Not available',
                isFilled: true,
              ),
              const SizedBox(width: 16),
              _legendItem(
                color: AppColors.accent,
                label: 'Today',
                isFilled: false,
              ),
              const SizedBox(width: 16),
              _legendItem(
                color: AppColors.accent,
                label: 'Selected',
                isFilled: true,
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 16),

          // selected date summary
          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The selected date for travel',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _selectedDate != null
                        ? _formatFullDate(_selectedDate!)
                        : 'No date selected',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          //save button
          ElevatedButton(
            onPressed: _selectedDate != null ? _handleSave : null,
            child: const Text('Save'),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _legendItem({
    required Color color,
    required String label,
    required bool isFilled,
  }) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? color : Colors.transparent,
            border: isFilled ? null : Border.all(color: color, width: 1.5),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
