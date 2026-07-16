import 'dart:ui';

import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:bus_ticketing/features/auth/screens/sms_retrieval_implementation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class VerifyScreenOtp extends StatefulWidget {
  final String email;

  const VerifyScreenOtp({
    super.key,
    required this.email,
  });

  @override
  State<VerifyScreenOtp> createState() => _VerifyScreenOtpState();
}

class _VerifyScreenOtpState extends State<VerifyScreenOtp> {
  final TextEditingController _otpController = TextEditingController();
  late final SmsRetrieverImpl _smsRetriever;

  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _smsRetriever = SmsRetrieverImpl(
      SmartAuth.instance,
    );
  }

  @override
  void dispose() {
    _smsRetriever.dispose();
    _otpController.dispose();
    super.dispose();
  }

  String get _maskedEmail {
    final parts = widget.email.split('@');

    if (parts.length != 2) return widget.email;

    final name = parts.first;

    final masked = name.length <= 2
      ? name
      : '${name[0]}${'*' * (name.length - 2)}${name[name.length - 1]}';

    return '$masked@${parts.last}';
  }

  Future<void> _handleVerify() async {
    if (_otpController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the 6-digit code"),
        ),
      );
      return;
    }

    setState(() => _isVerifying = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isVerifying = false);

    context.go("/complete-account");
  }

  void _handleResend() {
    _otpController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("OTP sent successfully"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: media.viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    media.size.height -
                    media.padding.top -
                    media.padding.bottom,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: AppColors.textDark,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: media.size.height * .05),

                    Text(
                      "Verify OTP",
                      style: GoogleFonts.manrope(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "We have sent a code to the registered email\n$_maskedEmail",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: media.size.height * .05),

                    Center(
                      child: Pinput(
                        controller: _otpController,
                        length: 6,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        smsRetriever: _smsRetriever,
                        onCompleted: (_) => _handleVerify(),
                        defaultPinTheme: PinTheme(
                          width: 52,
                          height: 60,
                          textStyle: GoogleFonts.manrope(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.divider,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 52,
                          height: 60,
                          textStyle: GoogleFonts.manrope(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.accent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Center(
                      child: Text(
                        "Did not receive the code?",
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),

                    SizedBox(height: media.size.height * .18),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            _isVerifying ? null : _handleVerify,
                        child: _isVerifying
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text("Verification"),
                      ),
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: _handleResend,
                        child: const Text("Resend Code"),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.manrope(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                          children: [
                            const TextSpan(
                              text: "Is the email correct? ",
                            ),
                            WidgetSpan(
                              alignment:
                                  PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap: () => context.pop(),
                                child: Text(
                                  "Change email",
                                  style:
                                      GoogleFonts.manrope(
                                    color:
                                        AppColors.accent,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}