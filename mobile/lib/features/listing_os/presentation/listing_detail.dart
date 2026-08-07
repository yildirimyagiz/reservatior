import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class ListingDetailScreen extends StatelessWidget {
  final String title;
  final String price;
  final String location;
  final String status;

  const ListingDetailScreen({
    super.key,
    required this.title,
    required this.price,
    required this.location,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = status == 'Aktif'
        ? AppColors.success
        : status == 'Kirada'
            ? AppColors.info
            : AppColors.warning;

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: AppColors.darkBg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.white, size: 22),
                tooltip: 'Düzenle',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('İlan Düzenleme ekranı açılıyor...', style: GoogleFonts.outfit()),
                      backgroundColor: AppColors.darkCard,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.white, size: 22),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.4),
                      AppColors.darkBg,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
                        ),
                        child: const Icon(Icons.home_work_outlined, size: 64, color: AppColors.primaryLight),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'İlan Görsel Galerisi',
                        style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimaryDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: statusColor.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: AppColors.primaryLight, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      location,
                      style: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 15),
                    ),
                  ],
                ).animate().fadeIn(delay: 50.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.darkCard.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fiyat', style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondaryDark)),
                          const SizedBox(height: 2),
                          Text(
                            price,
                            style: GoogleFonts.outfit(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.calendar_month_outlined, size: 18),
                        label: Text('Takvimi Gör', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2433),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF10B981).withOpacity(0.35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified_user, color: Color(0xFF10B981), size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Tapu & Değerleme Uygunluğu (AI Verified)',
                            style: GoogleFonts.outfit(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildComplianceBadge(Icons.auto_awesome, 'Vatandaşlık / Golden Visa', r'100% Uygun ($400k+)'),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildComplianceBadge(Icons.account_balance, 'Banka Kredisi (Mortgage)', 'SPK / RICS Onaylı'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '💡 Tapu tarihi ve beyan bedeli Reservatior ML Servisi (Web-Tapu / SPK OCR) tarafından doğrulanmıştır.',
                        style: GoogleFonts.outfit(color: Colors.white54, fontSize: 11, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 120.ms),
                const SizedBox(height: 24),
                Text(
                  'Açıklama',
                  style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimaryDark),
                ),
                const SizedBox(height: 10),
                Text(
                  'Bu mülk, modern mimarisi, yüksek kaliteli eşyaları ve harika lokasyonu ile birinci sınıf bir yaşam alanı sunmaktadır. Akıllı ev sistemleri, yüksek hızlı internet, 7/24 güvenlik ve özel otopark imkanı mevcuttur.',
                  style: GoogleFonts.outfit(fontSize: 15, height: 1.6, color: AppColors.textSecondaryDark),
                ).animate().fadeIn(delay: 150.ms),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Icon(Icons.auto_awesome_outlined, color: Color(0xFF8B5CF6), size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'AI Tahmin Motoru & Analizler',
                      style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimaryDark),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    children: [
                      _buildInsightRow('Önerilen Optimum Fiyat', price, const Color(0xFF8B5CF6)),
                      const Divider(height: 20, color: AppColors.darkBorder),
                      _buildInsightRow('Bölgesel Talep Düzeyi', 'Yüksek (%92)', AppColors.success),
                      const Divider(height: 20, color: AppColors.darkBorder),
                      _buildInsightRow('Tahmini Boş Kalma Riski', 'Çok Düşük (%4)', AppColors.info),
                    ],
                  ),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.textSecondaryDark),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 14, color: valueColor),
        ),
      ],
    );
  }

  Widget _buildComplianceBadge(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF10B981)),
          const SizedBox(height: 6),
          Text(title, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(subtitle, style: GoogleFonts.outfit(color: const Color(0xFFA7F3D0), fontSize: 12, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
