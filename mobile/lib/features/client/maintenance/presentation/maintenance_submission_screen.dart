import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MaintenanceSubmissionScreen extends ConsumerStatefulWidget {
  const MaintenanceSubmissionScreen({super.key});

  @override
  ConsumerState<MaintenanceSubmissionScreen> createState() => _MaintenanceSubmissionScreenState();
}

class _MaintenanceSubmissionScreenState extends ConsumerState<MaintenanceSubmissionScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isUrgent = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitRequest() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen tüm alanları doldurun'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Mock sending the data to the backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Talebiniz alındı! Yöneticiye iletildi.'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Yeni Bakım Talebi',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Arıza Bildirimi',
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).animate().fadeIn().slideY(),
            const SizedBox(height: 8),
            Text(
              'Karşılaştığınız sorunu lütfen bize detaylıca anlatın.',
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ).animate().fadeIn().slideY(delay: const Duration(milliseconds: 100)),
            const SizedBox(height: 32),
            
            // Title Input
            _buildLabel('Başlık / Kategori'),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Örn: Mutfak Lavabosu Sızdırıyor'),
            ).animate().fadeIn().slideX(delay: const Duration(milliseconds: 200)),
            const SizedBox(height: 24),

            // Description Input
            _buildLabel('Detaylı Açıklama'),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration('Lütfen arızanın ne zaman başladığını ve detaylarını yazın...'),
            ).animate().fadeIn().slideX(delay: const Duration(milliseconds: 300)),
            const SizedBox(height: 24),

            // Urgency Toggle
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _isUrgent ? Colors.redAccent.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _isUrgent ? Colors.redAccent.withValues(alpha: 0.5) : Colors.white24,
                ),
              ),
              child: SwitchListTile(
                title: Text(
                  'Bu acil bir durum mu?',
                  style: TextStyle(color: _isUrgent ? Colors.redAccent : Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Su baskını, elektrik kaçağı gibi acil müdahale gerektiren durumlar.',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                value: _isUrgent,
                activeColor: Colors.redAccent,
                onChanged: (val) => setState(() => _isUrgent = val),
              ),
            ).animate().fadeIn().slideY(delay: const Duration(milliseconds: 400)),
            
            const SizedBox(height: 40),
            
            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _submitRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Talebi Gönder',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 500)).scale(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white24),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.gold),
      ),
    );
  }
}
