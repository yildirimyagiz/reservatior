import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/providers/listing_provider.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/models/models.dart';

class ListingsScreen extends ConsumerStatefulWidget {
  const ListingsScreen({super.key});

  @override
  ConsumerState<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends ConsumerState<ListingsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _filterStatus = 'all';
  bool _isGridView = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final listingsAsync = ref.watch(listingListProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(colors),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMarketingHeader(colors),
                  SizedBox(height: 32),
                  _buildStatsArea(colors),
                  SizedBox(height: 32),
                  _buildFilters(colors),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
          listingsAsync.when(
            data: (data) {
              final filtered = data.where((l) {
                final matchSearch = (l.title ?? "").toLowerCase().contains(_searchQuery.toLowerCase());
                // In mock we don't have status yet, so we just filter by search
                return matchSearch;
              }).toList();

              if (filtered.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text('mobile.auto.no_listings_found'.tr(), style: TextStyle(color: colors.textSecondary)),
                  ),
                );
              }

              return SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                sliver: _isGridView 
                  ? _buildGridView(filtered, colors)
                  : _buildListView(filtered, colors),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(child: Text('${'admin.shared.connectionError'.tr()}: $e', style: const TextStyle(color: AppColors.error))),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: Icon(Icons.add_rounded, color: Colors.white),
        label: Text('mobile.auto.new_listing'.tr(), style: GoogleFonts.outfit(fontWeight: FontWeight.bold, letterSpacing: 1)),
      ).animate().scale(delay: 400.ms),
    );
  }

  Widget _buildSliverAppBar(ThemeAwareColors colors) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 16),
      sliver: SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: colors.textPrimary, size: 20),
              ),
              Container(
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  children: [
                    _buildViewToggle(Icons.grid_view_rounded, true, colors),
                    _buildViewToggle(Icons.list_alt_rounded, false, colors),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildViewToggle(IconData icon, bool isGrid, ThemeAwareColors colors) {
    final active = _isGridView == isGrid;
    return GestureDetector(
      onTap: () => setState(() => _isGridView = isGrid),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Icon(
          icon, 
          color: active ? Colors.white : colors.textSecondary.withOpacity(0.5),
          size: 18,
        ),
      ),
    );
  }

  Widget _buildMarketingHeader(ThemeAwareColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.pink.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.pink.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.rocket_launch_rounded, color: Colors.pink, size: 12),
              SizedBox(width: 6),
              Text('mobile.auto.campaign_control_panel'.tr(),
                style: GoogleFonts.outfit(
                  color: Colors.pink,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text('mobile.auto.listing_management'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        Text('mobile.auto.boost_your_listing_performance_using_doping'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsArea(ThemeAwareColors colors) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('mobile.leftovers.live_listings'.tr(), '12', Icons.visibility_outlined, Colors.green, colors),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('Featured', '4', Icons.bolt_rounded, Colors.amber, colors),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color, ThemeAwareColors colors) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.outfit(
                  color: colors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.outfit(
                  color: colors.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(ThemeAwareColors colors) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (v) => setState(() => _searchQuery = v),
        style: TextStyle(color: colors.textPrimary, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'mobile.auto.search_by_title_or_property_name'.tr(),
          hintStyle: TextStyle(color: colors.textSecondary.withOpacity(0.5)),
          border: InputBorder.none,
          icon: Icon(Icons.search_rounded, color: colors.textSecondary.withOpacity(0.5), size: 20),
        ),
      ),
    );
  }

  Widget _buildGridView(List<Listing> listings, ThemeAwareColors colors) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final l = listings[index];
          return _buildListingCard(l, colors);
        },
        childCount: listings.length,
      ),
    );
  }

  Widget _buildListView(List<Listing> listings, ThemeAwareColors colors) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final l = listings[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: _buildListingTile(l, colors),
          );
        },
        childCount: listings.length,
      ),
    );
  }

  Widget _buildListingCard(Listing l, ThemeAwareColors colors) {
    final isDoped = true; // Randomly dope for demo
    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDoped ? Colors.amber.withOpacity(0.5) : colors.border),
        boxShadow: isDoped ? [BoxShadow(color: Colors.amber.withOpacity(0.1), blurRadius: 10)] : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              child: Stack(
                children: [
                  Container(color: Colors.blueGrey.withOpacity(0.1)),
                  Center(child: Icon(Icons.image_outlined, color: Colors.white24, size: 40)),
                  if (isDoped)
                    Positioned(
                      top: 12,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.bolt, color: Colors.black, size: 10),
                            SizedBox(width: 4),
                            Text('mobile.auto.doped'.tr(),
                              style: GoogleFonts.outfit(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.title ?? 'mobile.leftovers.untitled_listing'.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  '${l.propertyId.split('-').first} • Istanbul',
                  style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 11),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₺${(l.price ?? 0).toInt()}',
                      style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                    Icon(Icons.more_horiz_rounded, color: colors.textSecondary.withOpacity(0.5), size: 18),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.surface,
                foregroundColor: colors.textPrimary,
                elevation: 0,
                minimumSize: const Size(double.infinity, 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), 
                  side: BorderSide(color: colors.border),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.video_library_outlined, size: 14, color: Colors.pink),
                  SizedBox(width: 6),
                  Text('mobile.auto.prepare_reel'.tr(), style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListingTile(Listing l, ThemeAwareColors colors) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.home_work_outlined, color: AppColors.primary, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.title ?? 'mobile.leftovers.untitled_listing'.tr(),
                  style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '₺${(l.price ?? 0).toInt()} • ACTIVE',
                  style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chevron_right_rounded, color: colors.textSecondary.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
