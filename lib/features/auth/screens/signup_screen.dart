import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _agreedToTerms = false;
  String _selectedCountryCode = '+234';

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? _phoneError;

  void _handleSignUp(BuildContext context) {
    //manually handle phone number validation , since it is wrapped in a container
    setState(() {
      _phoneError = phoneController.text.trim().isEmpty
          ? 'Phone number is required'
          : phoneController.text.trim().length < 7
          ? 'Enter a valid phone number'
          : null;
    });

    //check all fields of the form are validated
    final isFormValid = formKey.currentState!.validate();
    final isPhoneValid = _phoneError == null;

    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // toast notification at bottom of screen
          content: Text(
            'Please agree to the Terms & Conditions',
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

    if (isFormValid && isPhoneValid) {
      final fullPhone = '$_selectedCountryCode${phoneController.text.trim()}';
      debugPrint('Registering: ${emailController.text} | Phone: $fullPhone');
      context.go('/verify-otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 55),
                Image.asset('assets/icons/logo-bus.png', height: 50, width: 50),
                const SizedBox(height: 15),
                Text(
                  'Sign Up',
                  style: GoogleFonts.manrope(
                    color: AppColors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Create an account and get an unforgettable travel experience',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    color: AppColors.whiteMuted,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: fullNameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: "Enter Full Name",
                    prefixIcon: Icon(
                      Icons.badge_outlined,
                      color: AppColors.textHint,
                      size: 20,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Full name is required';
                    }
                    if (value.trim().length < 2) {
                      return 'Enter a valid name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.textHint,
                      size: 20,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.trim().contains('@') ||
                        !value.trim().contains('.')) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                //country code and phone number container
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Row(
                    children: [
                      CountryCodePicker(
                        onChanged: (country) {
                          //When user picks a country, update our state
                          setState(() {
                            _selectedCountryCode = country.dialCode ?? '+62';
                          });
                        },
                        initialSelection: 'NG', // Nigeria
                        favorite: const ['+234', '+62', '+1', '+44'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                        textStyle: GoogleFonts.poppins(
                          color: AppColors.textDark,
                          fontSize: 14,
                        ),
                        flagWidth: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      Container(width: 1, height: 28, color: AppColors.divider),
                      Expanded(
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: '000-0000-0000',
                            hintStyle: GoogleFonts.poppins(
                              color: AppColors.textHint,
                              fontSize: 14,
                            ),
                            // Remove all borders here since the
                            // parent Container is acting as the border
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Phone number is required';
                            }
                            if (value.trim().length < 7) {
                              return 'Enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (_phoneError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _phoneError!,
                        style: GoogleFonts.poppins(
                          color: AppColors.error,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Create Password',
                    prefixIcon: const Icon(
                      Icons.lock_outline_rounded,
                      color: AppColors.textHint,
                      size: 20,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      child: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textHint,
                        size: 20,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    if (value.trim().length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agreedToTerms,
                        onChanged: (value) {
                          setState(() => _agreedToTerms = value ?? false);
                        },
                        activeColor: AppColors.accent,
                        checkColor: AppColors.white,
                        side: const BorderSide(
                          color: AppColors.whiteMuted,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Expanded so the text wraps properly and doesn't overflow
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            color: AppColors.whiteMuted,
                            fontSize: 13,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  'By clicking the Register button, I have read and agree to the ',
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  // TODO: open terms bottom sheet
                                },
                                child: Text(
                                  'Terms & Conditions',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(text: ' of GOGOBUS.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                ElevatedButton(
                  onPressed: () => _handleSignUp(context),
                  child: const Text('Sign Up'),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I already have an account ',
                      style: GoogleFonts.poppins(
                        color: AppColors.whiteMuted,
                        fontSize: 13,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Text(
                        'Log In to Account',
                        style: GoogleFonts.poppins(
                          color: AppColors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
