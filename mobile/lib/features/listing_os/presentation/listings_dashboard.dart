import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/listing_os/presentation/listing_detail.dart';

class ListingsDashboard extends StatelessWidget {
  const ListingsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.85),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 20, bottom: 18),
              title: Text(
                'Listing OS',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: AppColors.textPrimaryDark,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: AppColors.primaryLight, size: 24),
                tooltip: 'Yeni İlan Ekle',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Yeni İlan Ekleme Akışı başlatılıyor...', style: GoogleFonts.outfit()),
                      backgroundColor: AppColors.darkCard,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildStatGrid().animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Aktif İlanlar',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    Text(
                      'Toplam: 15',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _buildListingCard(
                  context,
                  title: 'Luxury Beach Villa',
                  location: 'Palm Jumeirah, Dubai',
                  status: 'Aktif',
                  price: '\$2,500 / gece',
                  views: '1.4k',
                  rating: '4.95',
                  accentColor: AppColors.success,
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
                _buildListingCard(
                  context,
                  title: 'Penthouse Apartment',
                  location: 'Manhattan, New York',
                  status: 'Kirada',
                  price: '\$4,800 / ay',
                  views: '2.8k',
                  rating: '4.88',
                  accentColor: AppColors.info,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),
                _buildListingCard(
                  context,
                  title: 'Modern Bosphorus Loft',
                  location: 'Beşiktaş, İstanbul',
                  status: 'İncelemede',
                  price: '₺85,000 / ay',
                  views: '920',
                  rating: '5.00',
                  accentColor: AppColors.warning,
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildOsKpiCard('Aktif İlanlar', '12', Icons.home_work_outlined, AppColors.success)),
            const SizedBox(width: 12),
            Expanded(child: _buildOsKpiCard('Bekleyen', '3', Icons.pending_actions_outlined, AppColors.warning)),
          ],
        ),
        const SizedBox(width: 12, height: 12),
        Row(
          children: [
            Expanded(child: _buildOsKpiCard('Görüntülenme', '4.2K', Icons.visibility_outlined, AppColors.primaryLight)),
            const SizedBox(width: 12),
            Expanded(child: _buildOsKpiCard('Doluluk Oranı', '%88', Icons.analytics_outlined, const Color(0xFF8B5CF6))),
          ],
        ),
      ],
    );
  }

  Widget _buildOsKpiCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.textSecondaryDark),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 22, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildListingCard(
    BuildContext context, {
    required String title,
    required String location,
    required String status,
    required String price,
    required String views,
    required String rating,
    required Color accentColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListingDetailScreen(
                title: title,
                price: price,
                location: location,
                status: status,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [accentColor.withValues(alpha: 0.3), AppColors.darkSurface],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                ),
                child: Icon(Icons.location_city_outlined, color: accentColor, size: 32),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: AppColors.textPrimaryDark,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: accentColor.withValues(alpha: 0.4)),
                          ),
                          child: Text(
                            status,
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondaryDark),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: GoogleFonts.outfit(fontSize: 13, color: AppColors.textSecondaryDark),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: AppColors.primaryLight,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 3),
                            Text(
                              rating,
                              style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.visibility_outlined, size: 14, color: AppColors.textSecondaryDark),
                            const SizedBox(width: 3),
                            Text(
                              views,
                              style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondaryDark),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
