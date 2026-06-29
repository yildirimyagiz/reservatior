import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CheckoutScreen extends StatefulWidget {
  final String propertyId;
  final Property property;

  const CheckoutScreen({
    super.key,
    required this.propertyId,
    required this.property,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isProcessing = false;
  bool _isSuccess = false;

  // Super App Cross-sell States
  bool _addVipTransfer = false;
  bool _addCityTour = false;

  double get _basePrice => widget.property.listingPrice ?? 1500.0;
  double get _totalPrice => _basePrice + (_addVipTransfer ? 150.0 : 0) + (_addCityTour ? 250.0 : 0);

  void _handlePayment() async {
    setState(() {
      _isProcessing = true;
    });

    // Simulate API call to Open Banking Escrow
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isProcessing = false;
      _isSuccess = true;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ödeme Başarılı! Tutar Escrow havuzuna alındı.'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
    }

    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go('/hub'); // or /dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF09090E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Ödeme & Escrow',
          style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.apartment, color: Colors.white54, size: 40),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.property.type?.toString() ?? 'PROPERTY',
                          style: GoogleFonts.outfit(
                            color: const Color(0xFF10B981),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.property.name,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.property.city ?? '',
                          style: GoogleFonts.outfit(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // SafeStay Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.verified_user_rounded, color: Color(0xFF10B981), size: 24),
                      const SizedBox(width: 12),
                      Text(
                        'Reservatior SafeStay™ Koruması Aktif',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFF10B981),
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bu ödeme Açık Bankacılık ile Bloke edilir. Tutar, ev sahibine hemen geçmez. Siz tesise giriş yaptıktan (check-in) 24 saat sonra bir sorun bildirmezseniz ev sahibinin hesabına aktarılır.',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFF10B981).withOpacity(0.8),
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),

            // Super App Special Offers
            Text(
              'Super App Özel Teklifler',
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.02),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    value: _addVipTransfer,
                    onChanged: (val) => setState(() => _addVipTransfer = val ?? false),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('VIP Havalimanı Transferi', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('+\$150', style: GoogleFonts.outfit(color: const Color(0xFF10B981), fontWeight: FontWeight.bold)),
                      ]
                    ),
                    subtitle: Text('S-Class veya V-Class ile lüks karşılama.', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
                    secondary: const Icon(Icons.local_taxi, color: Color(0xFF10B981)),
                    activeColor: const Color(0xFF10B981),
                    checkColor: Colors.black,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const Divider(color: Colors.white10),
                  CheckboxListTile(
                    value: _addCityTour,
                    onChanged: (val) => setState(() => _addCityTour = val ?? false),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Exclusive Şehir Turu', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('+\$250', style: GoogleFonts.outfit(color: const Color(0xFF10B981), fontWeight: FontWeight.bold)),
                      ]
                    ),
                    subtitle: Text('Özel rehber eşliğinde 4 saatlik panoramik tur.', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
                    secondary: const Icon(Icons.tour, color: Color(0xFF10B981)),
                    activeColor: const Color(0xFF10B981),
                    checkColor: Colors.black,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
            const SizedBox(height: 32),

            Text(
              'Ödeme Bilgileri',
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // Dummy Form
            _buildTextField('Kart Üzerindeki İsim', 'Ad Soyad'),
            const SizedBox(height: 16),
            _buildTextField('Kart Numarası', '0000 0000 0000 0000', icon: Icons.credit_card),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTextField('Son Kullanma', 'AA/YY')),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('CVC/CVV', '123')),
              ],
            ),
            const SizedBox(height: 48),

            // Pay Button
            GestureDetector(
              onTap: (_isProcessing || _isSuccess) ? null : _handlePayment,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF10B981), Color(0xFF059669)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: _isProcessing
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : _isSuccess
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle, color: Colors.white, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'BAŞARILI',
                                style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.lock, color: Colors.white, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                'ŞİMDİ ÖDE (\$${_totalPrice.toStringAsFixed(0)})',
                                style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
                              ),
                            ],
                          ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, color: Colors.white38, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    '256-bit SSL şifreleme ile korunmaktadır',
                    style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextField(
            style: GoogleFonts.outfit(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.outfit(color: Colors.white24),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              prefixIcon: icon != null ? Icon(icon, color: Colors.white38) : null,
            ),
          ),
        ),
      ],
    );
  }
}
