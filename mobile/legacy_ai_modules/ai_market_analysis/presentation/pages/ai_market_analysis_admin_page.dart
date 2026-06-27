import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/models/ai_market_analysis.dart';
import 'package:reservatior/shared/providers/ai_market_analysis_provider.dart';
import 'package:reservatior/features/client/ai_market_analysis/presentation/widgets/ai_market_analysis_list_widget.dart';
import 'package:reservatior/features/client/ai_market_analysis/presentation/widgets/ai_market_analysis_form_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class AiMarketAnalysisAdminPage extends ConsumerWidget {
  const AiMarketAnalysisAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final itemsAsync = ref.watch(aiMarketAnalysisListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg.withOpacity(0.8),
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'mobile.ai.analytics.title'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.5,
                color: AppColors.primary,
              ),
            ),
            Text(
              'mobile.ai.analytics.subtitle'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          _pulseAction(Icons.radar_rounded, Colors.orange),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.8, -0.6),
            radius: 1.2,
            colors: [AppColors.primary.withOpacity(0.05), Colors.transparent],
          ),
        ),
        child: itemsAsync.when(
          data: (data) {
            final filteredData = user?.organizationId != null
                ? data.where((item) {
                    try {
                      return (item as dynamic).orgId == user!.organizationId;
                    } catch (_) {
                      return true;
                    }
                  }).toList()
                : data;

            if (filteredData.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                          Icons.auto_awesome_mosaic_rounded,
                          color: Colors.white10,
                          size: 80,
                        )
                        .animate(onPlay: (c) => c.repeat())
                        .shimmer(duration: 3.seconds),
                    SizedBox(height: 24),
                    Text(
                      'mobile.ai.analytics.noSignals'.tr(),
                      style: GoogleFonts.outfit(
                        color: Colors.white24,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'mobile.ai.analytics.initiate'.tr(),
                      style: GoogleFonts.outfit(
                        color: Colors.white10,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              backgroundColor: AppColors.darkSurface,
              color: AppColors.primary,
              onRefresh: () async => ref.refresh(aiMarketAnalysisListProvider),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  top: 130,
                  left: 16,
                  right: 16,
                  bottom: 100,
                ),
                physics: const BouncingScrollPhysics(),
                child: AiMarketAnalysisListWidget(
                  items: filteredData as List<AiMarketAnalysis>,
                ),
              ),
            );
          },
          loading: () => SingleChildScrollView(
            padding: const EdgeInsets.only(top: 130),
            child: Column(
              children: List.generate(6, (index) => const _ShimmerItem())
                  .animate(interval: 50.ms)
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.1),
            ),
          ),
          error: (e, s) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.bolt_rounded,
                  color: Colors.redAccent,
                  size: 48,
                ).animate(onPlay: (c) => c.repeat()).shake(),
                SizedBox(height: 16),
                Text(
                  'mobile.ai.analytics.errorTitle'.tr(),
                  style: GoogleFonts.outfit(
                    color: Colors.white54,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'mobile.ai.analytics.errorDesc'.tr(),
                  style: GoogleFonts.outfit(
                    color: Colors.white24,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 32),
                OutlinedButton(
                  onPressed: () => ref.refresh(aiMarketAnalysisListProvider),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'mobile.ai.analytics.retry'.tr(),
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        elevation: 12,
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add_chart_rounded, color: Colors.white),
        label: Text(
          'mobile.ai.analytics.scan'.tr(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ).animate().slideY(begin: 1, end: 0, delay: 400.ms),
    );
  }

  Widget _pulseAction(IconData icon, Color color) {
    return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(icon, color: color, size: 20),
          ),
        )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .shimmer(duration: 2.seconds, color: color.withOpacity(0.2));
  }

  void _showForm(
    BuildContext context,
    WidgetRef ref, {
    AiMarketAnalysis? item,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: AiMarketAnalysisFormWidget(
          item: item,
          onSubmit: (val) {
            if (item == null)
              ref.read(aiMarketAnalysisCreateProvider.notifier).state = val;
            else
              ref.read(aiMarketAnalysisUpdateProvider.notifier).state = {
                'id': item.id,
                'data': val,
              };
            Navigator.pop(ctx);
          },
        ),
      ),
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  const _ShimmerItem();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkSurface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.05),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
