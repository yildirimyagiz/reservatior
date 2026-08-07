import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContentPublisherScreen extends ConsumerWidget {
  const ContentPublisherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        'Content Publisher & SEO',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Automatic content production, social media & SEO distribution',
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
                const SizedBox(height: 4),
                _buildKpiGrid(),
                const SizedBox(height: 20),
                _sectionHeader('Channel Performance', Icons.share_outlined, AppColors.info),
                const SizedBox(height: 12),
                ..._buildChannels(),
                const SizedBox(height: 20),
                _sectionHeader('Recent Content', Icons.article_outlined, AppColors.primaryLight),
                const SizedBox(height: 12),
                ..._buildRecentContent(),
                const SizedBox(height: 20),
                _sectionHeader('AI Content Pipeline', Icons.auto_awesome_outlined, AppColors.success),
                const SizedBox(height: 12),
                _buildPipeline(),
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

  Widget _buildKpiGrid() {
    final kpis = [
      ('Published', '342', Icons.check_circle_outline, AppColors.info, 0),
      ('Pending Review', '18', Icons.schedule_outlined, AppColors.warning, 60),
      ('Active Channels', '7', Icons.share_outlined, AppColors.info, 120),
      ('Avg SEO Score', '87/100', Icons.ads_click, AppColors.primaryLight, 180),
      ('Total Views', '245K', Icons.visibility_outlined, AppColors.primaryLight, 240),
      ('Conversion', '3.2%', Icons.trending_up, AppColors.success, 300),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.9,
      ),
      itemCount: kpis.length,
      itemBuilder: (context, index) {
        final (title, value, icon, color, delay) = kpis[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.darkCard.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              const Spacer(),
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: delay.ms).slideY(begin: 0.05, end: 0);
      },
    );
  }

  List<Widget> _buildChannels() {
    final channels = [
      ('Website (SEO Pages)', '156', '120K', '92', 'active', Icons.language),
      ('Google Business', '89', '45K', '88', 'active', Icons.search),
      ('Instagram', '67', '52K', null, 'active', Icons.camera_alt_outlined),
      ('LinkedIn', '34', '18K', null, 'active', Icons.work_outline),
      ('YouTube', '12', '8K', null, 'paused', Icons.play_circle_outline),
      ('Property Portals', '98', '89K', '85', 'active', Icons.link),
      ('Email Newsletter', '24', '12K', null, 'active', Icons.mail_outline),
    ];
    return channels.map((c) {
      final (name, published, views, seo, status, icon) = c;
      final isActive = status == 'active';
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.darkCard.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryLight, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('$published published · $views views', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
                ],
              ),
            ),
            if (seo != null)
              Text(seo, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.info)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (isActive ? AppColors.success : AppColors.warning).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                status.toUpperCase(),
                style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w800, color: isActive ? AppColors.success : AppColors.warning),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> _buildRecentContent() {
    final items = [
      ('Kensington 3BR — Luxury Living Guide', 'SEO Page', '2,340', '94', 'published', '2h ago'),
      ('Chelsea Market Report Q3 2024', 'Blog Post', '1,890', '91', 'published', '5h ago'),
      ('Investment Guide: South London', 'Landing Page', '4,200', '88', 'published', '1d ago'),
      ("Agent Sarah's Listings Showcase", 'Social Post', '890', null, 'published', '1d ago'),
      ('Manchester Waterfront Virtual Tour', 'Video', '3,100', null, 'pending', '—'),
      ('Dubai Investment Opportunities', 'Newsletter', '0', null, 'draft', '—'),
    ];
    return items.map((c) {
      final (title, type, views, seo, status, time) = c;
      final color = status == 'published' ? AppColors.info : status == 'pending' ? AppColors.warning : AppColors.textSecondaryDark;
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.darkCard.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('$type · $views views', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
                ],
              ),
            ),
            if (seo != null)
              Text(seo, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.success)),
            const SizedBox(width: 6),
            Text(time, style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildPipeline() {
    final steps = ['Brief', 'Created', 'SEO Opt.', 'Review', 'Publish', 'Track'];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (i) {
              return Column(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i <= 4 ? AppColors.primary : AppColors.darkMuted,
                    ),
                    child: Center(
                      child: Text('${i + 1}', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white, fontSize: 14)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 56,
                    child: Text(
                      steps[i],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(fontSize: 9, color: AppColors.textSecondaryDark),
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
