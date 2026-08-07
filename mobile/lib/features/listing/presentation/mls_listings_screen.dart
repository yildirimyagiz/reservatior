import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/mls_external_listing.dart';
import 'package:reservatior/shared/models/mls_listing_enhancement.dart';
import 'package:reservatior/shared/providers/mls_external_listing_provider.dart';
import 'package:reservatior/shared/providers/mls_listing_enhancement_provider.dart';

class MlsListingsScreen extends ConsumerStatefulWidget {
  const MlsListingsScreen({super.key});

  @override
  ConsumerState<MlsListingsScreen> createState() => _MlsListingsScreenState();
}

class _MlsListingsScreenState extends ConsumerState<MlsListingsScreen> {
  bool _showEnhanced = false;

  @override
  Widget build(BuildContext context) {
    final asyncExternal = ref.watch(mlsExternalListingListProvider);
    final asyncEnhancements = ref.watch(mlsListingEnhancementListProvider);

    final external = asyncExternal.value ?? <MlsExternalListing>[];
    final enhancements = asyncEnhancements.value ?? <MlsListingEnhancement>[];

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'MLS Listings',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'External listings',
                      selected: !_showEnhanced,
                      onTap: () => setState(() => _showEnhanced = false),
                    ),
                    _FilterChip(
                      label: 'Enhancements',
                      selected: _showEnhanced,
                      onTap: () => setState(() => _showEnhanced = true),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (!_showEnhanced)
                  asyncExternal.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('Could not load listings',
                        style: GoogleFonts.outfit(color: Colors.white54)),
                    data: (data) {
                      if (external.isEmpty) {
                        return _EmptyCard(message: 'No external listings');
                      }
                      return Column(
                        children: external
                            .map((l) => _ExternalTile(listing: l))
                            .toList(),
                      );
                    },
                  )
                else
                  asyncEnhancements.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('Could not load enhancements',
                        style: GoogleFonts.outfit(color: Colors.white54)),
                    data: (data) {
                      if (enhancements.isEmpty) {
                        return _EmptyCard(message: 'No enhancements yet');
                      }
                      return Column(
                        children: enhancements
                            .map((h) => _EnhancementTile(enhancement: h))
                            .toList(),
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        backgroundColor: AppColors.darkSurface,
        selectedColor: AppColors.primary.withValues(alpha: 0.3),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.darkBorder,
        ),
        labelStyle: GoogleFonts.outfit(
          color: selected ? Colors.white : Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final String message;
  const _EmptyCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Text(
        message,
        style: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
      ),
    );
  }
}

class _ExternalTile extends StatelessWidget {
  final MlsExternalListing listing;
  const _ExternalTile({required this.listing});

  @override
  Widget build(BuildContext context) {
    final color =
        listing.status == 'ACTIVE' ? AppColors.success : AppColors.warning;
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
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.language, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${listing.connection.name} · #${listing.externalId}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                Text(
                  listing.mappedListingId != null
                      ? 'Mapped to #${listing.mappedListingId}'
                      : 'Not mapped',
                  style: GoogleFonts.outfit(
                      color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Text(
              listing.status ?? 'UNKNOWN',
              style: GoogleFonts.outfit(
                  color: color, fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ).animate().fadeIn(),
    );
  }
}

class _EnhancementTile extends StatelessWidget {
  final MlsListingEnhancement enhancement;
  const _EnhancementTile({required this.enhancement});

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
                child: Icon(Icons.auto_awesome,
                    color: AppColors.primary, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      enhancement.listing.title ??
                          enhancement.listing.property.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      'MLS #${enhancement.mlsNumber ?? '—'}',
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ),
              ),
              if (enhancement.mlsStatus != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.info.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.info.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    enhancement.mlsStatus!,
                    style: GoogleFonts.outfit(
                        color: AppColors.info,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.update, color: Colors.white24, size: 13),
              const SizedBox(width: 4),
              Text(
                enhancement.lastMlsUpdate != null
                    ? 'Updated ${DateFormat.yMMMd().add_Hm().format(enhancement.lastMlsUpdate!)}'
                    : 'No MLS update yet',
                style: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
              ),
            ],
          ),
        ],
      ).animate().fadeIn(),
    );
  }
}
