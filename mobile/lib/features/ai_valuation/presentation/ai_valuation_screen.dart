import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/ai_property_valuation.dart';
import 'package:reservatior/shared/providers/ai_property_valuation_provider.dart';

class AiValuationScreen extends ConsumerWidget {
  const AiValuationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValuations = ref.watch(aiPropertyValuationListProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'AI Valuations',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'Model-driven property value predictions.',
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 16),
                asyncValuations.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => _EmptyCard(
                    icon: Icons.cloud_off,
                    title: 'No valuation data',
                    subtitle: '$e',
                  ),
                  data: (valuations) {
                    if (valuations.isEmpty) {
                      return _EmptyCard(
                        icon: Icons.auto_graph,
                        title: 'No valuations yet',
                        subtitle: 'Run a valuation from AI Studio',
                      );
                    }
                    final avgConfidence = valuations.fold<double>(
                          0,
                          (s, v) => s + v.confidenceScore,
                        ) /
                        valuations.length;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _KpiGrid(
                          items: [
                            (
                              'Valuations',
                              '${valuations.length}',
                              Icons.auto_graph,
                              AppColors.primary,
                            ),
                            (
                              'Avg confidence',
                              '${(avgConfidence * 100).toStringAsFixed(0)}%',
                              Icons.verified_outlined,
                              AppColors.success,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text('Latest valuations',
                            style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16)),
                        const SizedBox(height: 12),
                        ...valuations.map((v) =>
                            _ValuationTile(valuation: v)),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ValuationTile extends StatelessWidget {
  final AiPropertyValuation valuation;
  const _ValuationTile({required this.valuation});

  @override
  Widget build(BuildContext context) {
    final confidence = (valuation.confidenceScore * 100).clamp(0, 100);
    return InkWell(
      onTap: () => context.push('/properties/${valuation.propertyId}'),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.apartment, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valuation.property.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      Text(
                        '${valuation.property.city} · ${valuation.model.modelName}',
                        style: GoogleFonts.outfit(
                            color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                _StatusBadge(valuation.status),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _Metric(
                    label: 'Predicted value',
                    value: NumberFormat.compactCurrency(symbol: '\$')
                        .format(valuation.predictedValue),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _Metric(
                    label: 'Confidence',
                    value: '${confidence.toStringAsFixed(0)}%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: valuation.confidenceScore.clamp(0.0, 1.0),
                minHeight: 4,
                backgroundColor: AppColors.darkSurface,
                valueColor:
                    const AlwaysStoppedAnimation(AppColors.success),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Valued ${DateFormat.yMMMd().format(valuation.valuationDate)}',
              style: GoogleFonts.outfit(color: Colors.white24, fontSize: 10),
            ),
          ],
        ),
      ).animate().fadeIn(),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  GoogleFonts.outfit(color: Colors.white38, fontSize: 10)),
          const SizedBox(height: 2),
          Text(value,
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15)),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge(this.status);

  @override
  Widget build(BuildContext context) {
    final done = status.toUpperCase() == 'COMPLETED' ||
        status.toUpperCase() == 'SUCCESS';
    final color = done ? AppColors.success : AppColors.warning;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        status.replaceAll('_', ' '),
        style: GoogleFonts.outfit(
            color: color, fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  final List<(String, String, IconData, Color)> items;
  const _KpiGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.7,
      children: items
          .map((e) => Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.darkBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(e.$3, color: e.$4, size: 20),
                    const SizedBox(height: 8),
                    Text(
                      e.$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    Text(e.$1,
                        style: GoogleFonts.outfit(
                            color: Colors.white38, fontSize: 11)),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _EmptyCard({required this.icon, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white24, size: 32),
          const SizedBox(height: 10),
          Text(title,
              style: GoogleFonts.outfit(
                  color: Colors.white70, fontWeight: FontWeight.w600)),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(color: Colors.white38, fontSize: 12)),
            ),
        ],
      ),
    );
  }
}
