import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CertificatesScreen extends ConsumerStatefulWidget {
  const CertificatesScreen({super.key});

  @override
  ConsumerState<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends ConsumerState<CertificatesScreen> {
  String _search = '';

  static const List<Map<String, String>> _certificates = [
    {
      'id': 'CERT-7701',
      'title': '7464 Konut Kiralama İzin Belgesi',
      'issuer': 'T.C. Kültür ve Turizm Bakanlığı',
      'category': 'Turizm Kiralama',
      'issueDate': '2025-01-15',
      'expiryDate': '2026-01-15',
      'status': 'ACTIVE',
      'serialNumber': 'TR-TUR-2025-7701',
    },
    {
      'id': 'CERT-9920',
      'title': 'Taşınmaz Ticareti Yetki Belgesi',
      'issuer': 'T.C. Ticaret Bakanlığı',
      'category': 'Emlak Lisansı',
      'issueDate': '2024-06-10',
      'expiryDate': '2029-06-10',
      'status': 'ACTIVE',
      'serialNumber': '3400812-001',
    },
    {
      'id': 'CERT-3304',
      'title': 'ISO 27001 Bilgi Güvenliği Sertifikası',
      'issuer': 'TÜRKAK / ISO Audit',
      'category': 'Sistem & Güvenlik',
      'issueDate': '2024-11-01',
      'expiryDate': '2025-11-01',
      'status': 'ACTIVE',
      'serialNumber': 'ISO-27001-2024-RES',
    },
    {
      'id': 'CERT-1102',
      'title': 'SSL/TLS Extended Validation Lisansı',
      'issuer': 'DigiCert Inc.',
      'category': 'Web & API Güvenliği',
      'issueDate': '2023-12-01',
      'expiryDate': '2024-12-01',
      'status': 'EXPIRED',
      'serialNumber': 'DC-EV-99281-EXP',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final query = _search.toLowerCase();
    final filtered = _certificates
        .where((c) =>
            c['title']!.toLowerCase().contains(query) ||
            c['serialNumber']!.toLowerCase().contains(query) ||
            c['issuer']!.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Certificates & Licenses',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Legal permits, tourism licenses, ISO standards & digital certificates',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSearchBar(),
                const SizedBox(height: 16),
                _buildStatsRow(),
                const SizedBox(height: 20),
                _sectionHeader('Legal Compliance Certificates', Icons.workspace_premium_outlined, AppColors.primary),
                const SizedBox(height: 12),
                ...filtered.map((c) => _buildCertificateCard(c)).toList(),
                if (filtered.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Text(
                        'No certificates found',
                        style: GoogleFonts.outfit(fontSize: 13, color: AppColors.textSecondaryDark),
                      ),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (v) => setState(() => _search = v),
            style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search certificates, serials, issuers...',
              hintStyle: GoogleFonts.outfit(color: AppColors.textSecondaryDark, fontSize: 13),
              prefixIcon: const Icon(Icons.search, color: AppColors.textSecondaryDark, size: 18),
              filled: true,
              fillColor: AppColors.darkSurface,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Icon(Icons.add, size: 18),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      ('Active', '3 Belge', Icons.verified_user_outlined, AppColors.success),
      ('Expiring Soon', '1 Belge', Icons.calendar_month_outlined, AppColors.warning),
      ('Verification', 'Resmi Onaylı', Icons.workspace_premium_outlined, AppColors.primaryLight),
    ];
    return Row(
      children: stats.map((s) {
        final (title, value, icon, color) = s;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.darkCard.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.darkBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(height: 8),
                Text(value, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(height: 2),
                Text(title, style: GoogleFonts.outfit(fontSize: 9, color: AppColors.textSecondaryDark)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCertificateCard(Map<String, String> cert) {
    final isActive = cert['status'] == 'ACTIVE';
    final color = isActive ? AppColors.success : AppColors.error;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.workspace_premium, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cert['title']!, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                const SizedBox(height: 4),
                Text(
                  '${cert['issuer']} · ${cert['category']}',
                  style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark),
                ),
                const SizedBox(height: 4),
                Text(
                  'Serial: ${cert['serialNumber']}',
                  style: GoogleFonts.jetBrainsMono(fontSize: 10, color: AppColors.textSecondaryDark.withValues(alpha: 0.7)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(isActive ? Icons.check_circle_outline : Icons.error_outline, color: color, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            isActive ? 'Aktif & Geçerli' : 'Süresi Doldu',
                            style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w800, color: color),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Exp: ${cert['expiryDate']}',
                      style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
