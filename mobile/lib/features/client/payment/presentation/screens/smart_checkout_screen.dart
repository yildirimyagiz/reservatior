import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/providers/payment_provider.dart';

class SmartCheckoutScreen extends ConsumerStatefulWidget {
  final double rentAmount;
  final String propertyName;
  final String propertyImage;
  final int leaseDuration;

  const SmartCheckoutScreen({
    super.key,
    this.rentAmount = 20000.0,
    this.propertyName = 'mobile.auto.bosphorus_premium_suite',
    this.propertyImage = 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?ixlib=rb-4.0.3&w=200&q=80',
    this.leaseDuration = 36,
  });

  @override
  ConsumerState<SmartCheckoutScreen> createState() => _SmartCheckoutScreenState();
}

class _SmartCheckoutScreenState extends ConsumerState<SmartCheckoutScreen> {
  bool _isProcessing = false;

  void _processPayment() async {
    setState(() => _isProcessing = true);
    try {
      final gateway = ref.read(paymentGatewayServiceProvider);
      
      final depositPortion = widget.rentAmount / 12;
      final commissionPortion = widget.rentAmount * 0.035;
      final total = widget.rentAmount + depositPortion + commissionPortion;
      final amountInCents = (total * 100).toInt().toString();

      await gateway.initPaymentSheet(amountInCents, 'try');
      
      if (!mounted) return;
      setState(() => _isProcessing = false);
      _showSuccessDialog();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isProcessing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 64),
            ).animate().scale(delay: 200.ms, curve: Curves.elasticOut),
            SizedBox(height: 24),
            Text('mobile.auto.pre_auth_successful'.tr(),
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('mobile.auto.funds_are_securely_blocked_at_your_bank_the_transfer_will_only_complete_once_the_lease_is_countersigned_and_keys_are_delivered'.tr(),
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(color: Colors.white60, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  context.pop(); // Go back home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text('mobile.auto.view_dashboard'.tr(), style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('mobile.auto.secure_escrow_checkout'.tr(), style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10B981).withOpacity(0.15),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPropertyCard(),
                SizedBox(height: 32),
                Text('mobile.auto.payment_method'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                _buildCreditCard(),
                SizedBox(height: 32),
                Text('mobile.auto.transaction_breakdown'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildBreakdown(),
                const SizedBox(height: 40),
                _buildSecurityBadge(),
                const SizedBox(height: 100), // Padding for bottom button
              ],
            ),
          ),
          
          // Bottom Sticky Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.darkBg,
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, offset: const Offset(0, -5)),
                ],
              ),
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  disabledBackgroundColor: const Color(0xFF10B981).withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 10,
                  shadowColor: const Color(0xFF10B981).withOpacity(0.5),
                ),
                child: _isProcessing
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.lock_outline_rounded, color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text('mobile.auto.authorize_secure_hold'.tr(),
                            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              widget.propertyImage,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.propertyName.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Sözleşme Süresi: ${widget.leaseDuration} Ay', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13)),
                SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: Text('mobile.auto.smart_lease_active'.tr(), style: GoogleFonts.outfit(color: AppColors.primaryLight, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1);
  }

  Widget _buildCreditCard() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.contactless_rounded, color: Colors.white70, size: 28),
              Text('mobile.auto.visa'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
            ],
          ),
          Text(
            'mobile.leftovers._4281'.tr(),
            style: GoogleFonts.outfit(color: Colors.white, fontSize: 22, letterSpacing: 4),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('mobile.auto.cardholder'.tr(), style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10, letterSpacing: 1)),
                  SizedBox(height: 4),
                  Text('mobile.auto.alexander_wright'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('mobile.auto.expires'.tr(), style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10, letterSpacing: 1)),
                  const SizedBox(height: 4),
                  Text('12/28', style: GoogleFonts.outfit(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1);
  }

  Widget _buildBreakdown() {
    final currencyFormatter = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');
    
    final depositPortion = widget.rentAmount / 12;
    final commissionPortion = widget.rentAmount * 0.035;
    final total = widget.rentAmount + depositPortion + commissionPortion;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reservatior Avantajı Aktif!', style: GoogleFonts.outfit(color: const Color(0xFF10B981), fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Komisyon ve depozito yükü aylara bölündü. Peşinat ödemiyorsunuz.', style: GoogleFonts.outfit(color: const Color(0xFF10B981).withOpacity(0.7), fontSize: 12)),
              ],
            ),
          ),
          _buildRow('İlk Ay Kirası', currencyFormatter.format(widget.rentAmount)),
          const SizedBox(height: 12),
          _buildRow('Aylık Depozito Payı (1/12)', currencyFormatter.format(depositPortion)),
          const SizedBox(height: 12),
          _buildRow('Aylık Komisyon Payı (%3.5)', currencyFormatter.format(commissionPortion), isHighlight: true),
          const SizedBox(height: 16),
          const Divider(color: Colors.white12),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Bu Ay Ödenecek Toplam', style: GoogleFonts.outfit(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              Text(currencyFormatter.format(total), style: GoogleFonts.outfit(color: const Color(0xFF10B981), fontSize: 24, fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1);
  }

  Widget _buildRow(String label, String amount, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 14)),
        Text(
          amount,
          style: GoogleFonts.outfit(
            color: isHighlight ? AppColors.primaryLight : Colors.white,
            fontSize: 14,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityBadge() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.gpp_good_rounded, color: Color(0xFF10B981), size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('mobile.auto.bank_grade_security'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('mobile.auto.your_funds_are_held_at_your_bank_until_lease_execution_zero_risk_of_fraud'.tr(), style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12, height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms);
  }
}
