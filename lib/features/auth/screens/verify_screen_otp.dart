import 'dart:ui';

import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyScreenOtp extends StatefulWidget {
  final String email;
  const VerifyScreenOtp({super.key, required this.email});

  @override
  State<VerifyScreenOtp> createState() => _VerifyScreenOtp();
}

class _VerifyScreenOtp extends State<VerifyScreenOtp> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _isVerifying = false;

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _maskedEmail {
    final parts = widget.email.split('@');
    if (parts.length != 2 || parts[0].isEmpty) return widget.email;
    final name = parts[0];
    final masked = name.length <= 2
        ? name
        : '${name[0]}${'*' * (name.length - 2)}${name[name.length - 1]}';
    return '$masked@${parts[1]}';
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 6) {
      _handleVerify();
    }
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  void _showSuccessOverlay() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim, secondaryAnim, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 6 * anim.value,
            sigmaY: 6 * anim.value,
          ),
          child: Opacity(
            opacity: anim.value,
            child: Container(
              color: Colors.black.withValues(alpha: 0.2 * anim.value),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: const Border(
                          top: BorderSide(color: AppColors.success, width: 3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Code Successfully Confirmed!',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Please complete your profile to continue.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleVerify() {
    if (_otpCode.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter the full 6-digit code',
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
    setState(() => _isVerifying = true);
    // TODO: replace with real Dio call to /verify-otp
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isVerifying = false);
      _showSuccessOverlay();

      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) context.go("/complete-account");
      });
      // Show success toast then navigate
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Row(
      //       children: [
      //         const Icon(
      //           Icons.check_circle,
      //           color: AppColors.success,
      //           size: 20,
      //         ),
      //         const SizedBox(width: 10),
      //         Expanded(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 'Code Successfully Confirmed!',
      //                 style: GoogleFonts.poppins(
      //                   fontWeight: FontWeight.w600,
      //                   fontSize: 13,
      //                   color: AppColors.textDark,
      //                 ),
      //               ),
      //               Text(
      //                 'Please complete your profile to continue.',
      //                 style: GoogleFonts.poppins(
      //                   fontSize: 12,
      //                   color: AppColors.textSecondary,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //     backgroundColor: AppColors.white,
      //     behavior: SnackBarBehavior.floating,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //       side: const BorderSide(color: AppColors.success, width: 1),
      //     ),
      //     duration: const Duration(seconds: 3),
      //   ),
      // );
    });
  }

  void _handleResend() {
    // Clear all boxes and refocus first
    for (final controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'A new code has been sent to your email',
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    // TODO: call /resend-otp endpoint
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
              color: AppColors.surface,
              //status bar height + your normal padding to the top
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => context.go('/register'),
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
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Verify OTP",
                        style: GoogleFonts.manrope(
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'We have sent a code to the registered email\n$_maskedEmail',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return OtpBox(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          onChanged: (value) => _onChanged(value, index),
                        );
                      }),
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: _handleResend,
                        child: Text(
                          'Did not receive the code?',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _isVerifying ? null : _handleVerify,
                      child: _isVerifying
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.white,
                              ),
                            )
                          : const Text('Verification'),
                    ),
                    const SizedBox(height: 12),

                    OutlinedButton(
                      onPressed: _handleResend,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 54),
                        side: const BorderSide(color: AppColors.divider),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Resend Code',
                        style: GoogleFonts.manrope(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.manrope(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                        ),
                        children: [
                          const TextSpan(text: "Is the email correct?"),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () => context.pop(),
                              child: Text(
                                'Change email',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const OtpBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: focusNode,
      builder: (context, state) {
        final isFocused = focusNode.hasFocus;
        return Container(
          width: 48,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isFocused ? AppColors.accent : AppColors.divider,
              width: isFocused ? 2 : 1,
            ),
          ),
          child: Center(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: onChanged,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.manrope(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
              decoration: const InputDecoration(
                counterText: '',
                filled: false,
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        );
      },
    );
  }
}
