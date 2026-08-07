import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/services.dart';

class SEOGeneratorScreen extends StatefulWidget {
  const SEOGeneratorScreen({super.key});

  @override
  State<SEOGeneratorScreen> createState() => _SEOGeneratorScreenState();
}

class _SEOGeneratorScreenState extends State<SEOGeneratorScreen> {
  String _propertyId = 'PROP-546038';
  bool _copied = false;

  static const String _jsonLdCode = '''
{
  "@context": "https://schema.org",
  "@type": "SingleFamilyResidence",
  "name": "Cihangir Lüks Rezidans 2+1",
  "description": "7464 sayılı kanuna %100 uyumlu, yüksek kısa ve orta dönem konaklama getirili lüks daire.",
  "address": {
    "@type": "PostalAddress",
    "addressLocality": "Beyoğlu",
    "addressRegion": "İstanbul",
    "addressCountry": "TR"
  },
  "geo": {
    "@type": "GeoCoordinates",
    "latitude": 41.0322,
    "longitude": 28.9835
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.92",
    "reviewCount": "128"
  }
}''';

  Future<void> _copy() async {
    await Clipboard.setData(const ClipboardData(text: _jsonLdCode));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        'SEO Generator',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Structured data, investment scores & rental yield generator',
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
                _sectionHeader('Generated Metadata', Icons.public_outlined, AppColors.success),
                const SizedBox(height: 12),
                _buildMetaTags(),
                const SizedBox(height: 20),
                _sectionHeader('JSON-LD Schema', Icons.code_outlined, AppColors.primaryLight),
                const SizedBox(height: 12),
                _buildJsonLd(),
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: TextEditingController(text: _propertyId),
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Property ID (e.g. PROP-546038)',
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
              onChanged: (v) => setState(() => _propertyId = v),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: Text('Generate', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaTags() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _metaRow('Meta Title (TR)', 'Cihangir Lüks Rezidans 2+1 - Reservatior Hybrid Rental'),
          const SizedBox(height: 14),
          _metaRow(
            'Meta Description',
            'İstanbul Beyoğlu Cihangir\'de %7.8 tahmini kira getirili, 7464 sayılı kanuna uyumlu lüks 2+1 daire. Kurumsal yönetim garantisi ile kiralayın.',
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Investment Suitability Score:',
                style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                ),
                child: Text(
                  '94 / 100 A+',
                  style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.success),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metaRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w600, letterSpacing: 0.5, color: AppColors.textSecondaryDark),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.darkSurface.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: Text(
            value,
            style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white, height: 1.4),
          ),
        ),
      ],
    );
  }

  Widget _buildJsonLd() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Spacer(),
              InkWell(
                onTap: _copy,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Icon(_copied ? Icons.check_circle : Icons.copy, color: _copied ? AppColors.success : AppColors.primaryLight, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        _copied ? 'Copied' : 'Copy Code',
                        style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w700, color: _copied ? AppColors.success : AppColors.primaryLight),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 260),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.darkBorder),
            ),
            child: SingleChildScrollView(
              child: Text(
                _jsonLdCode,
                style: GoogleFonts.jetBrainsMono(fontSize: 11, color: AppColors.success, height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
