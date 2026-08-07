import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class ExperiencesScreen extends StatefulWidget {
  const ExperiencesScreen({super.key});

  @override
  State<ExperiencesScreen> createState() => _ExperiencesScreenState();
}

class _ExperiencesScreenState extends State<ExperiencesScreen> {
  String _selectedCategory = 'All';

  static const _categories = ['All', 'Tours', 'Dining', 'Wellness', 'Adventure', 'Culture'];

  static const _experiences = [
    _Experience('Bosphorus Sunset Cruise', 'Tours', 'Istanbul', '\$85', 4.9, Icons.sailing_outlined),
    _Experience('Private Chef Dinner', 'Dining', 'Dubai', '\$240', 4.8, Icons.restaurant_outlined),
    _Experience('Desert Safari Experience', 'Adventure', 'Dubai', '\$120', 4.7, Icons.terrain_outlined),
    _Experience('Hammam & Spa Day', 'Wellness', 'Istanbul', '\$95', 4.9, Icons.spa_outlined),
    _Experience('Flamenco Show & Tapas', 'Culture', 'Barcelona', '\$75', 4.6, Icons.music_note_outlined),
    _Experience('Yacht Charter (Half-day)', 'Tours', 'Mallorca', '\$350', 4.8, Icons.directions_boat_outlined),
    _Experience('Rooftop Yoga Session', 'Wellness', 'London', '\$55', 4.5, Icons.self_improvement_outlined),
    _Experience('Art Gallery Private Tour', 'Culture', 'Paris', '\$90', 4.7, Icons.museum_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selectedCategory == 'All'
        ? _experiences
        : _experiences.where((e) => e.category == _selectedCategory).toList();

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
            title: Text('Experiences', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white)),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 44,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final cat = _categories[i];
                  final selected = _selectedCategory == cat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = cat),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : AppColors.darkCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: selected ? AppColors.primary : AppColors.darkBorder),
                      ),
                      child: Text(cat,
                          style: GoogleFonts.outfit(
                              color: selected ? Colors.white : Colors.white54,
                              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                              fontSize: 13)),
                    ),
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _ExperienceCard(exp: filtered[i]),
                childCount: filtered.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _Experience {
  final String name;
  final String category;
  final String location;
  final String price;
  final double rating;
  final IconData icon;
  const _Experience(this.name, this.category, this.location, this.price, this.rating, this.icon);
}

class _ExperienceCard extends StatelessWidget {
  final _Experience exp;
  const _ExperienceCard({required this.exp});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.primary.withValues(alpha: 0.3), AppColors.info.withValues(alpha: 0.2)]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(exp.icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exp.name, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(height: 3),
                Text('${exp.category} · ${exp.location}', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
                const SizedBox(height: 6),
                Row(children: [
                  Icon(Icons.star, color: AppColors.warning, size: 14),
                  const SizedBox(width: 3),
                  Text('${exp.rating}', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12)),
                ]),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(exp.price, style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 4),
              Text('per person', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
