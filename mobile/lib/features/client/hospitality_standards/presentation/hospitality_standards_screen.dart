import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class HospitalityStandardsScreen extends StatelessWidget {
  const HospitalityStandardsScreen({super.key});

  static const _standards = [
    _Standard('Check-in Experience', Icons.login_outlined, 'Keyless entry, welcome kit, digital guidebook', 95),
    _Standard('Cleanliness Protocol', Icons.cleaning_services_outlined, 'Hospital-grade cleaning between stays', 98),
    _Standard('Amenities Quality', Icons.star_border_outlined, 'Premium toiletries, linens, coffee setup', 92),
    _Standard('Response Time', Icons.timer_outlined, 'Guest messages answered < 1 hour', 88),
    _Standard('Safety & Security', Icons.security_outlined, 'Smoke/CO detectors, first-aid, fire ext.', 100),
    _Standard('Local Guidebook', Icons.map_outlined, 'Curated local recommendations', 80),
    _Standard('Smart Home', Icons.home_outlined, 'Smart thermostat, locks, TV setup', 75),
  ];

  @override
  Widget build(BuildContext context) {
    final avgScore = _standards.fold(0, (s, st) => s + st.score) ~/ _standards.length;

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
            title: Text('Hospitality Standards', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white)),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Overall score
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [AppColors.primary.withValues(alpha: 0.3), AppColors.info.withValues(alpha: 0.1)]),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: CircularProgressIndicator(
                              value: avgScore / 100,
                              strokeWidth: 6,
                              backgroundColor: Colors.white12,
                              valueColor: AlwaysStoppedAnimation(AppColors.primary),
                            ),
                          ),
                          Text('$avgScore', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 20)),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Overall Score', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                            const SizedBox(height: 4),
                            Text('Based on ${_standards.length} standards', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Superhost Eligible', style: GoogleFonts.outfit(color: AppColors.success, fontSize: 11, fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text('Standards', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 12),
                ..._standards.map((s) => _StandardTile(standard: s)),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Standard {
  final String name;
  final IconData icon;
  final String description;
  final int score;
  const _Standard(this.name, this.icon, this.description, this.score);
}

class _StandardTile extends StatelessWidget {
  final _Standard standard;
  const _StandardTile({required this.standard});

  Color get _scoreColor {
    if (standard.score >= 90) return AppColors.success;
    if (standard.score >= 75) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
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
              color: _scoreColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(standard.icon, color: _scoreColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(standard.name, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                const SizedBox(height: 2),
                Text(standard.description, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: standard.score / 100,
                    backgroundColor: Colors.white12,
                    valueColor: AlwaysStoppedAnimation(_scoreColor),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text('${standard.score}%', style: GoogleFonts.outfit(color: _scoreColor, fontWeight: FontWeight.w700, fontSize: 14)),
        ],
      ),
    );
  }
}
