import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class AmbassadorsScreen extends StatelessWidget {
  const AmbassadorsScreen({super.key});

  static const _ambassadors = [
    _Ambassador('Zeynep Kaya', 'Istanbul · TR', 847, 4.95, 'Platinum', 'Luxury & Investment specialist'),
    _Ambassador('Ahmed Al-Rashid', 'Dubai · AE', 1203, 4.98, 'Diamond', 'Off-plan & expat relocation'),
    _Ambassador('Sophie Laurent', 'Paris · FR', 612, 4.91, 'Gold', 'Prestige properties & rentals'),
    _Ambassador('James Whitfield', 'London · UK', 934, 4.93, 'Platinum', 'Prime Central London expert'),
    _Ambassador('Carlos Mendez', 'Barcelona · ES', 481, 4.87, 'Gold', 'Short-term rental optimization'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 140,
            backgroundColor: AppColors.darkBg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary.withValues(alpha: 0.3), AppColors.darkBg],
                  ),
                ),
                child: Align(
                  alignment: const Alignment(0, 0.6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Brand Ambassadors', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22)),
                      Text('Top-performing global representatives', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _AmbassadorCard(amb: _ambassadors[i]),
                childCount: _ambassadors.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _Ambassador {
  final String name;
  final String region;
  final int referrals;
  final double rating;
  final String tier;
  final String specialty;
  const _Ambassador(this.name, this.region, this.referrals, this.rating, this.tier, this.specialty);
}

class _AmbassadorCard extends StatelessWidget {
  final _Ambassador amb;
  const _AmbassadorCard({required this.amb});

  Color get _tierColor {
    switch (amb.tier) {
      case 'Diamond': return const Color(0xFF67E8F9);
      case 'Platinum': return const Color(0xFFE2E8F0);
      default: return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _tierColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: _tierColor.withValues(alpha: 0.2),
            child: Text(amb.name[0], style: GoogleFonts.outfit(color: _tierColor, fontWeight: FontWeight.w800, fontSize: 20)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(amb.name, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(color: _tierColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                    child: Text(amb.tier, style: GoogleFonts.outfit(color: _tierColor, fontSize: 9, fontWeight: FontWeight.w700)),
                  ),
                ]),
                Text(amb.region, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 11)),
                const SizedBox(height: 4),
                Text(amb.specialty, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(children: [
                Icon(Icons.star, color: AppColors.warning, size: 13),
                const SizedBox(width: 2),
                Text('${amb.rating}', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
              ]),
              const SizedBox(height: 4),
              Text('${amb.referrals} refs', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
