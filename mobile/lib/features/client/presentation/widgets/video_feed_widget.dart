import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class VideoFeedWidget extends ConsumerWidget {
  const VideoFeedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8, height: 8,
                          decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                        ).animate(onPlay: (c) => c.repeat()).fade(duration: 1.seconds, curve: Curves.easeInOut),
                        SizedBox(width: 8),
                        Text(
                          'mobile.feed.reels'.tr(),
                          style: GoogleFonts.outfit(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: Colors.redAccent,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'mobile.home.latestTours'.tr(),
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => context.push('/reels'),
                  child: Row(
                    children: [
                      Text(
                        'mobile.home.watchAll'.tr(),
                        style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded, color: AppColors.primary, size: 14),
                    ],
                  ),
                ),
              ],
            ).animate().fadeIn(),
          ),

          const SizedBox(height: 16),

          // Reels Horizontal Carousel
          SizedBox(
            height: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildReelCard(
                  context,
                  title: 'mobile.auto.skyline_penthouse'.tr(),
                  location: 'mobile.leftovers.dubai_marina'.tr(),
                  views: '124K',
                  imgUrl: 'https://images.unsplash.com/photo-1600607687920-4e2a09cf159d?w=400',
                  delay: 100,
                ),
                _buildReelCard(
                  context,
                  title: 'mobile.auto.oceanfront_villa'.tr(),
                  location: 'Malibu',
                  views: '89K',
                  imgUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400',
                  delay: 200,
                ),
                _buildReelCard(
                  context,
                  title: 'mobile.auto.modern_estate'.tr(),
                  location: 'mobile.leftovers.bel_air'.tr(),
                  views: '210K',
                  imgUrl: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=400',
                  delay: 300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReelCard(BuildContext context, {required String title, required String location, required String views, required String imgUrl, required int delay}) {
    return GestureDetector(
      onTap: () => context.push('/reels'),
      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Thumbnail
            Image.network(imgUrl, fit: BoxFit.cover),
            
            // Overlay Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                  stops: const [0.0, 0.6],
                ),
              ),
            ),
            
            // Play Button Center
            Center(
              child: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
              ),
            ),

            // Top Badges
            Positioned(
              top: 12, left: 12, right: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.remove_red_eye_rounded, color: Colors.white70, size: 10),
                        const SizedBox(width: 4),
                        Text(views, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const Icon(Icons.favorite_border_rounded, color: Colors.white, size: 18),
                ],
              ),
            ),
            
            // Bottom Info
            Positioned(
              bottom: 12, left: 12, right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, color: Colors.white70, size: 10),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(color: Colors.white70, fontSize: 10),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1),
    );
  }
}
