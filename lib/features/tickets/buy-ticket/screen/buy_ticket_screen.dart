import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:bus_ticketing/core/utils/formatters.dart';
import 'package:bus_ticketing/features/home/models/terminal_data.dart';
import 'package:bus_ticketing/features/search/models/schedule.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyTicketScreen extends StatefulWidget {
  final Schedule schedule;
  final Terminal departure;
  final Terminal destination;
  final DateTime date;
  final int passengers;

  const BuyTicketScreen({
    super.key,
    required this.schedule,
    required this.departure,
    required this.destination,
    required this.date,
    required this.passengers,
  });

  @override
  State<BuyTicketScreen> createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String _dialCode = '+234';
  bool _isMember = true;
  bool _agreedToTerms = false;

  //TODO
  //selected passenger name, would come from user profile via Riverpod
  final String _memberName = 'Aribatise John';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (!_formKey.currentState!.validate()) return;

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please agree to the Terms & Conditions and Privacy Policy',
            style: GoogleFonts.poppins(fontSize: 13),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    context.push(
      '/ticket-summary',
      extra: {
        'schedule': widget.schedule,
        'departure': widget.departure,
        'destination': widget.destination,
        'date': widget.date,
        'passengers': widget.passengers,
        'phone': '$_dialCode${_phoneController.text.trim()}',
        'passengerName': _memberName,
        'isMember': _isMember,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.surface,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go('/ticket-details', extra: {
                      'departure': widget.departure,
                      'destination': widget.destination,
                      'date': widget.date,
                      'schedule': widget.schedule
                    }),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.textDark,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Buy Ticket',
                    style: GoogleFonts.manrope(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    )
                  ),
                ],
              )
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionCard(child: Column(
                      children: [
                        _sectionHeader(
                          title: 'Order Information',
                          onChangeTap: () => context.pop()
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: AppColors.divider, height: 0.5,),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                          children: [
                            _routeCol(
                              city: widget.departure.city,
                              time: widget.schedule.departureTime,
                              isLeft: true,
                            ),
                            const Icon(Icons.arrow_forward_rounded,
                                color: AppColors.primary, size: 16),
                            _routeCol(
                              city: widget.destination.city,
                              time: widget.schedule.arrivalTime,
                              isLeft: false,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        //date + passengers
                        Row(
                          mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                          children: [
                            _labelValue(
                              label: 'Date',
                              value: _formatLongDate(widget.date),
                            ),
                            _labelValue(
                              label: 'Number of Passengers',
                              value: '${widget.passengers} person',
                              alignRight: false,
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        const Divider(color: AppColors.divider),
                        const SizedBox(height: 12),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.directions_bus_rounded,
                                      color: AppColors.white,
                                      size: 16),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    children: [
                                      Text(
                                        widget.schedule.busNumber,
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textDark,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                formatNaira(widget.schedule.priceNaira),
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),

                    const SizedBox(height: 16,),

                    _sectionCard(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionHeader(title: "Passenger Information"),
                        const SizedBox(height: 14,),
                        const Divider(color: AppColors.divider),
                        const SizedBox(height: 12),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Passenger',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: AppColors.textDark,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                const SizedBox(height: 6,),
                                Text(
                                  'Status:',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: AppColors.textDark,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            _toggleChip(
                              label: 'Member',
                              isSelected: _isMember,
                              onTap: () =>
                                setState(() => _isMember = true),
                            ),
                            const SizedBox(width: 8),
                            _toggleChip(
                              label: 'Non-member',
                              isSelected: !_isMember,
                              onTap: () =>
                                setState(() => _isMember = false),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // member name dropdown (static for now)
                        if (_isMember) ...[
                          Text(
                            'Select Member Name',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                Border.all(color: AppColors.divider),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.person_outline_rounded,
                                  size: 18,
                                  color: AppColors.textSecondary),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _memberName,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.textHint),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        //phone number
                        Text(
                          'Phone Number',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border:
                              Border.all(color: AppColors.divider),
                          ),
                          child: Row(
                            children: [
                              CountryCodePicker(
                                onChanged: (c) => setState(
                                  () => _dialCode = c.dialCode ?? '+234'),
                                initialSelection: 'NG',
                                favorite: const ['+234'],
                                textStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: AppColors.textDark),
                                flagWidth: 24,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8),
                              ),
                              Container(
                                width: 1,
                                height: 28,
                                color: AppColors.divider),
                              Expanded(
                                child: TextFormField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    hintText: '80-0000-0000',
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    filled: false,
                                    contentPadding:
                                      EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 16),
                                  ),
                                  validator: (v) {
                                    if (v == null ||
                                      v.trim().isEmpty) {
                                      return 'Phone number is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // -- phone note --
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                              AppColors.warning.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.warning
                                .withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline_rounded,
                                size: 14, color: AppColors.warning),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'The e-ticket will be sent to the number above, please ensure that the passenger\'s WhatsApp number is written correctly.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: AppColors.warning,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        //terms and conditions
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: _agreedToTerms,
                                onChanged: (v) => setState(
                                  () => _agreedToTerms = v ?? false),
                                activeColor: AppColors.accent,
                                checkColor: AppColors.white,
                                side: const BorderSide(
                                  color: AppColors.primary,
                                  width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                    BorderRadius.circular(4)),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                    height: 1.5,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'I agree to the GOGOBUS '),
                                    WidgetSpan(
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          'Terms & Conditions',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.accent,
                                            decoration:
                                              TextDecoration.underline,
                                            decorationColor:
                                              AppColors.accent,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const TextSpan(text: ' and the '),
                                    WidgetSpan(
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          'Privacy Policy',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.accent,
                                            decoration:
                                              TextDecoration.underline,
                                            decorationColor:
                                              AppColors.accent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ))
                  ],
                )
              )
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              color: AppColors.surface,
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).padding.bottom + 13,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price (${widget.passengers} passenger)',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        formatNaira(widget.schedule.priceNaira *
                          widget.passengers),
                        style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ]
                  ),
                  const SizedBox(height: 15,),

                  ElevatedButton(
                    onPressed: _handleContinue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Continue'),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward_rounded,
                          size: 20, color: AppColors.white, fontWeight: FontWeight.w700,),
                      ],
                    ),
                  ),
                ],
              )
            )
          ]
        )
      ),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _sectionHeader({required String title, VoidCallback? onChangeTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        if (onChangeTap != null)
          GestureDetector(
            onTap: onChangeTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: AppColors.divider, width: 1.5),
              ),
              child: Row(
                children: [
                  const Icon(Icons.edit_outlined,
                    size: 14, color: AppColors.accent),
                  const SizedBox(width: 4),
                  Text(
                    'Change',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _routeCol({
    required String city,
    required String time,
    required bool isLeft,
  }) {
    return Column(
      crossAxisAlignment:
        isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Text(
          city,
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _labelValue({
    required String label,
    required String value,
    bool alignRight = false,
  }) {
    return Column(
      crossAxisAlignment:
        alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _toggleChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
            ? AppColors.accent.withValues(alpha: 0.15)
            : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color:
              isSelected ? AppColors.accent : AppColors.divider,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.accent : AppColors.textDark,
          ),
        ),
      ),
    );
  }

  String _formatLongDate(DateTime date) {
    const weekdays = [
      'Monday', 'Tuesday', 'Wednesday',
      'Thursday', 'Friday', 'Saturday', 'Sunday'
    ];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
