import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

// ---------------------------------------------------------------------------
// Compare-list: saved property comparisons (client view)
// ---------------------------------------------------------------------------

final _compareListProvider = StateProvider<List<_CompareItem>>((ref) => [
      _CompareItem(
        id: '1',
        title: 'Luxury Penthouse — Istanbul',
        location: 'Beşiktaş, Istanbul',
        price: '\$2,400,000',
        area: '320 m²',
        rooms: '4+1',
        score: 92,
      ),
      _CompareItem(
        id: '2',
        title: 'Modern Villa — Dubai',
        location: 'Palm Jumeirah, Dubai',
        price: '\$3,150,000',
        area: '480 m²',
        rooms: '5+2',
        score: 87,
      ),
      _CompareItem(
        id: '3',
        title: 'City Apartment — London',
        location: 'Canary Wharf, London',
        price: '£1,200,000',
        area: '110 m²',
        rooms: '2+1',
        score: 78,
      ),
    ]);

class CompareListScreen extends ConsumerWidget {
  const CompareListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(_compareListProvider);

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
              'Compare List',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            actions: [
              if (items.isNotEmpty)
                TextButton(
                  onPressed: () =>
                      ref.read(_compareListProvider.notifier).state = [],
                  child: Text(
                    'Clear all',
                    style: GoogleFonts.outfit(
                      color: AppColors.error,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: items.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.compare_arrows,
                              color: Colors.white24, size: 56),
                          const SizedBox(height: 16),
                          Text(
                            'No properties saved for comparison',
                            style: GoogleFonts.outfit(
                                color: Colors.white38, fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () => context.push('/search'),
                            child: Text('Browse properties',
                                style: GoogleFonts.outfit(
                                    color: AppColors.primary)),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == 0) {
                          return _SummaryBanner(count: items.length);
                        }
                        final item = items[index - 1];
                        return _CompareCard(
                          item: item,
                          onRemove: () {
                            final notifier =
                                ref.read(_compareListProvider.notifier);
                            notifier.state = [
                              ...notifier.state
                                ..removeWhere((e) => e.id == item.id)
                            ];
                          },
                        );
                      },
                      childCount: items.length + 1,
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: items.length >= 2
          ? _CompareBar(count: items.length)
          : null,
    );
  }
}

// ---------------------------------------------------------------------------
// Widgets
// ---------------------------------------------------------------------------

class _SummaryBanner extends StatelessWidget {
  final int count;
  const _SummaryBanner({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.25),
            AppColors.info.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.compare_arrows, color: AppColors.primary, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$count properties saved — tap "Compare" to view side-by-side',
              style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareCard extends StatelessWidget {
  final _CompareItem item;
  final VoidCallback onRemove;
  const _CompareCard({required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final scoreColor = item.score >= 85
        ? AppColors.success
        : item.score >= 70
            ? AppColors.warning
            : AppColors.error;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Score badge
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: scoreColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: scoreColor.withValues(alpha: 0.4)),
            ),
            child: Center(
              child: Text(
                '${item.score}',
                style: GoogleFonts.outfit(
                  color: scoreColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.location,
                  style:
                      GoogleFonts.outfit(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _Chip(item.price, Icons.attach_money),
                    const SizedBox(width: 6),
                    _Chip(item.area, Icons.square_foot),
                    const SizedBox(width: 6),
                    _Chip(item.rooms, Icons.bed_outlined),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white38, size: 18),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _Chip(this.label, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.darkBorder,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white54, size: 11),
          const SizedBox(width: 4),
          Text(label,
              style:
                  GoogleFonts.outfit(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }
}

class _CompareBar extends StatelessWidget {
  final int count;
  const _CompareBar({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      color: AppColors.darkCard,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.compare_arrows),
        label: Text(
          'Compare $count Properties',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () => context.push('/invest/compare'),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Model
// ---------------------------------------------------------------------------

class _CompareItem {
  final String id;
  final String title;
  final String location;
  final String price;
  final String area;
  final String rooms;
  final int score;

  const _CompareItem({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.area,
    required this.rooms,
    required this.score,
  });
}
