import 'dart:io';

import 'package:bus_ticketing/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CompleteAccountScreen extends StatefulWidget {
  const CompleteAccountScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CompleteAccountScreenState();
}

class _CompleteAccountScreenState extends State<CompleteAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final addressController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  File? _profileImage;

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context);

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      // TODO: wire to Dio — upload _profileImage + address fields

      debugPrint('Address: ${addressController.text}');
      debugPrint('State: ${stateController.text}');
      debugPrint('City: ${cityController.text}');
      debugPrint('Image: ${_profileImage?.path}');

      context.go('/home');
    }
  }

  Widget _imageSourceTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.white, size: 22),
      ),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  void _showImageSource() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upload profile picture from',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 24, color: AppColors.divider),
                const SizedBox(height: 15),
                _imageSourceTile(
                  icon: Icons.photo_library_outlined,
                  label: 'Gallery',
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
                const SizedBox(height: 15),
                _imageSourceTile(
                  icon: Icons.camera_alt_outlined,
                  label: 'Camera',
                  onTap: () => _pickImage(ImageSource.camera),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    stateController.dispose();
    cityController.dispose();
    super.dispose();
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
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => context.go('/verify-otp'),
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
                    const SizedBox(width: 20),
                    Text(
                      "Complete Your Account",
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 32,),
                      //image profile
                      Stack(
                        children: [
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              shape: BoxShape.circle,
                              image: _profileImage != null
                                ? DecorationImage(
                                    image: FileImage(_profileImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            ),
                            child: _profileImage == null
                              ? const Icon(
                                  Icons.person_outline_rounded,
                                  size: 44,
                                  color: AppColors.primary,
                                )
                              : null,
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      GestureDetector(
                        onTap: _showImageSource,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.camera_alt_outlined,
                                color: AppColors.accent,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
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

                      const SizedBox(height: 50,),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(28),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Complete Address Information',
                              style: GoogleFonts.manrope(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textDark,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Street address
                            _fieldLabel('Street Address'),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: addressController,
                              decoration: const InputDecoration(
                                hintText: 'e.g 12 Allen Avenue, Ikeja',
                                prefixIcon: Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.textHint,
                                  size: 20,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Address is required';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            // State / Province
                            _fieldLabel('State / Province'),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: stateController,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                hintText: 'e.g Lagos',
                                prefixIcon: Icon(
                                  Icons.map_outlined,
                                  color: AppColors.textHint,
                                  size: 20,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'State / Province is required';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 18),

                            // City / Town
                            _fieldLabel('City / Town'),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: cityController,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                hintText: 'e.g Ikeja',
                                prefixIcon: Icon(
                                  Icons.location_city_outlined,
                                  color: AppColors.textHint,
                                  size: 20,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'City / Town is required';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 32),

                            ElevatedButton(
                              onPressed: _handleSave,
                              child: const Text('Save & Continue'),
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              )
            )
          ],
        ),
      ),
    );
  }
}
