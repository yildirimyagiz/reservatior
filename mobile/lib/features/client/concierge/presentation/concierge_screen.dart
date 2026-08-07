import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class ConciergeScreen extends StatelessWidget {
  const ConciergeScreen({super.key});

  static const _services = [
    _Service('Airport Transfer', Icons.local_airport_outlined, 'Book premium rides to/from airport', AppColors.primary),
    _Service('Property Styling', Icons.design_services_outlined, 'Professional staging & interior advice', AppColors.info),
    _Service('Legal Assistance', Icons.gavel_outlined, 'On-demand legal review', AppColors.warning),
    _Service('Cleaning & Maintenance', Icons.cleaning_services_outlined, 'White-glove turnover service', AppColors.success),
    _Service('Home Insurance', Icons.shield_outlined, 'Quick insurance quotes & binding', AppColors.error),
    _Service('Photography', Icons.camera_alt_outlined, 'HDR listing photography & virtual tours', AppColors.primary),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Concierge',
              style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _HeroBanner(
                  icon: Icons.room_service_outlined,
                  title: 'Premium Concierge',
                  subtitle: 'On-demand lifestyle & property services at your fingertips.',
                  color: AppColors.primary,
                ),
                const SizedBox(height: 24),
                Text('Services', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 12),
                ..._services.map((s) => _ServiceCard(service: s)),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared widgets used across lifestyle screens
// ---------------------------------------------------------------------------

class _HeroBanner extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  const _HeroBanner({required this.icon, required this.title, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.1)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.outfit(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Service {
  final String name;
  final IconData icon;
  final String description;
  final Color color;
  const _Service(this.name, this.icon, this.description, this.color);
}

class _ServiceCard extends StatelessWidget {
  final _Service service;
  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: service.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(service.icon, color: service.color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(service.name, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 2),
                Text(service.description, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white24),
        ],
      ),
    );
  }
}
