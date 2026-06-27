import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// AI Arbitrage Upsell Banner Widget
/// 
/// Shows when a user searches for hotel bookings >= 3 days. 
/// Suggests switching to our own luxury residential inventory.
class AIUpsellBannerWidget extends StatelessWidget {
  final Map<String, dynamic> upsellData;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const AIUpsellBannerWidget({
    super.key,
    required this.upsellData,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final name = upsellData['name'] ?? 'Lüks Rezidans';
    final city = upsellData['city'] ?? '';
    final bedrooms = upsellData['bedrooms'] ?? 1;
    final price = upsellData['pricePerNight'];
    final currency = upsellData['currency'] ?? 'USD';
    final image = upsellData['image'] ?? '';
    final aiMessage = upsellData['aiMessage'] ?? '';
    final savingsPercent = upsellData['savingsPercent'] ?? 25;
    final days = upsellData['days'] ?? 5;
    final features = List<String>.from(upsellData['features'] ?? ['Tam Donanımlı Mutfak', 'WiFi']);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF7C3AED).withOpacity(0.15),
            const Color(0xFFDB2777).withOpacity(0.10),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF7C3AED).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background glow
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF7C3AED).withOpacity(0.08),
                ),
              ),
            ),
            
            // Dismiss button
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onDismiss,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white54, size: 16),
                ),
              ),
            ),
            
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: AI badge + savings
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7C3AED).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF7C3AED).withOpacity(0.4)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.auto_awesome, color: Color(0xFF7C3AED), size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  'AI Arbitrage',
                                  style: GoogleFonts.outfit(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF7C3AED),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.green.withOpacity(0.4)),
                            ),
                            child: Text(
                              '%$savingsPercent Daha Ucuz',
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Property image + info
                      Row(
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: AppColors.darkSurface,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.villa, color: Colors.white24, size: 32),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          
                          // Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Uzun Konaklama Fırsatı!',
                                  style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF7C3AED),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '$name • $city',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.bed, color: Colors.white38, size: 12),
                                    const SizedBox(width: 3),
                                    Text('$bedrooms', style: const TextStyle(color: Colors.white60, fontSize: 11)),
                                    const SizedBox(width: 8),
                                    Text(
                                      price != null ? '$currency ${price.toStringAsFixed(0)}/gece' : '',
                                      style: GoogleFonts.outfit(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.primaryLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // AI Message
                      Text(
                        '"$aiMessage"',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          color: Colors.white54,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Features + CTA
                      Row(
                        children: [
                          // Features chips
                          Expanded(
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: [
                                ...features.take(2).map((f) => _buildFeatureChip(f)),
                                _buildFeatureChip('SafeStay™', isAccent: true),
                              ],
                            ),
                          ),
                          // CTA Arrow
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.15);
  }

  Widget _buildFeatureChip(String label, {bool isAccent = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isAccent 
            ? const Color(0xFF7C3AED).withOpacity(0.15)
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isAccent 
              ? const Color(0xFF7C3AED).withOpacity(0.3) 
              : Colors.white10,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isAccent ? Icons.shield : Icons.check_circle,
            size: 10,
            color: isAccent ? const Color(0xFF7C3AED) : Colors.green,
          ),
          const SizedBox(width: 3),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: isAccent ? const Color(0xFF7C3AED) : Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
