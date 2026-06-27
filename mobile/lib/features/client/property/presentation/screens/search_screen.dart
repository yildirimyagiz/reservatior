import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/widgets/skeleton_loader.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:shared_preferences/shared_preferences.dart';

// Filter State Providers
final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final selectedPropertyTypeProvider = StateProvider.autoDispose<String?>((ref) => null);
final priceRangeProvider = StateProvider.autoDispose<RangeValues>((ref) => const RangeValues(0, 10000000));
final searchRegionProvider = StateProvider.autoDispose<String>((ref) => 'GLOBAL');

enum PropertyViewType { grid, list, map }

final propertyViewTypeProvider = StateProvider.autoDispose<PropertyViewType>((ref) => PropertyViewType.grid);

// Price calculation helper
double? calculatePropertyPrice(Property property) {
  if (property.listings.isNotEmpty) {
    final listing = property.listings.first;
    if (listing.pricingRule.isNotEmpty) {
      final activeRule = listing.pricingRule.firstWhere(
        (rule) => rule.isActive == true,
        orElse: () => listing.pricingRule.first,
      );
      if (activeRule.basePrice != null) return activeRule.basePrice!;
    }
    return listing.price?.toDouble();
  }
  return property.listingPrice?.toDouble();
}

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 20 && !_isScrolled) setState(() => _isScrolled = true);
      else if (_scrollController.offset <= 20 && _isScrolled) setState(() => _isScrolled = false);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final propertiesAsync = ref.watch(propertyListProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;
          return isWide ? _buildSplitView(colors, propertiesAsync) : _buildMobileView(colors, propertiesAsync);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) return const SizedBox.shrink();
          return _buildFloatingViewToggle(colors);
        },
      ),
    );
  }

  Widget _buildSplitView(ThemeAwareColors colors, AsyncValue<List<Property>> propertiesAsync) {
    return Row(
      children: [
        // Left Panel (List/Grid + Filters)
        Expanded(
          flex: 5,
          child: Stack(
            children: [
              _buildContentList(colors, propertiesAsync, isSplitView: true),
              Positioned(
                top: 0, left: 0, right: 0,
                child: SafeArea(bottom: false, child: _buildFloatingSearchHeader(context, colors)),
              ),
            ],
          ),
        ),
        // Right Panel (Map)
        Expanded(
          flex: 7,
          child: propertiesAsync.when(
            data: (properties) => _buildMapView(properties, colors, isSplitView: true),
            loading: () => Center(child: CircularProgressIndicator(color: AppColors.primary)),
            error: (e, s) => Center(child: Text('Error', style: TextStyle(color: Colors.red))),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileView(ThemeAwareColors colors, AsyncValue<List<Property>> propertiesAsync) {
    return Stack(
      children: [
        // Background Map (if selected) or main list
        Positioned.fill(
          child: _buildContentList(colors, propertiesAsync, isSplitView: false),
        ),
        // Floating Search Header
        Positioned(
          top: 0, left: 0, right: 0,
          child: SafeArea(
            bottom: false,
            child: _buildFloatingSearchHeader(context, colors),
          ),
        ),
      ],
    );
  }

  Widget _buildContentList(ThemeAwareColors colors, AsyncValue<List<Property>> propertiesAsync, {required bool isSplitView}) {
    final viewType = ref.watch(propertyViewTypeProvider);
    if (!isSplitView && viewType == PropertyViewType.map) {
      return propertiesAsync.when(
        data: (properties) => _buildMapView(properties, colors, isSplitView: false),
        loading: () => Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, s) => const SizedBox.shrink(),
      );
    }

    return propertiesAsync.when(
      data: (properties) {
        final query = ref.watch(searchQueryProvider);
        final type = ref.watch(selectedPropertyTypeProvider);
        
        // Show Explore Dashboard if no filters are active, but inject the actual database properties to it
        if (query.isEmpty && type == null) return _buildExploreDashboard(properties, colors, isSplitView);
        
        if (properties.isEmpty) return _buildEmptyState(colors, true);
        return _buildSearchResults(properties, colors, isSplitView);
      },
      loading: () => _buildLoadingState(viewType),
      error: (e, s) => Center(child: Text('Error loading properties: $e')),
    );
  }

  Widget _buildLoadingState(PropertyViewType viewType) {
    if (viewType == PropertyViewType.list) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 140, bottom: 120, left: 16, right: 16),
        itemCount: 6,
        itemBuilder: (context, index) => const PropertyListTileSkeleton(),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.only(top: 140, bottom: 120, left: 16, right: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.75),
      itemCount: 6,
      itemBuilder: (context, index) => const PropertyCardSkeleton(),
    );
  }

  Widget _buildFloatingSearchHeader(BuildContext context, ThemeAwareColors colors) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.fromLTRB(16, _isScrolled ? 8 : 16, 16, 16),
      decoration: BoxDecoration(
        color: colors.surface.withOpacity(0.85),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: colors.border.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('mobile.auto.where'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                            TextField(
                              controller: _searchController,
                              style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500),
                              decoration: InputDecoration(
                                hintText: 'mobile.auto.city_state_zip'.tr(),
                                hintStyle: GoogleFonts.outfit(color: colors.textSecondary.withOpacity(0.5), fontSize: 14),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (v) => ref.read(searchQueryProvider.notifier).state = v,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 32, width: 1, color: colors.border),
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () {}, // Future date picker
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('mobile.auto.when'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                              const SizedBox(height: 2),
                              Text('mobile.auto.add_dates'.tr(), style: GoogleFonts.outfit(color: colors.textSecondary.withOpacity(0.5), fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showFilterSheet(context, colors),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF1BFFFF)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.tune_rounded, color: Colors.black, size: 20),
                      ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 2000.ms, color: Colors.white24),
                    ),
                  ],
                ),
              ),
              if (ref.watch(propertyViewTypeProvider) != PropertyViewType.map)
                _buildQuickFilterRow(colors),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1);
  }

  Widget _buildQuickFilterRow(ThemeAwareColors colors) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(bottom: 12),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildDropdownChip('Region', ['GLOBAL', 'AE', 'AR', 'AU', 'BR', 'CA', 'CN', 'DE', 'ES', 'FR', 'IN', 'IT', 'JP', 'KR', 'MX', 'MY', 'NL', 'NZ', 'SA', 'SG', 'TH', 'TR', 'UK', 'US'], colors),
          _buildDropdownChip('Listing', ListingType.values.map((e) => e.name).toList(), colors),
          _buildDropdownChip('Category', PropertyCategory.values.map((e) => e.name).toList(), colors),
          _buildDropdownChip('Type', PropertyType.values.map((e) => e.name).toList(), colors),
          _buildDropdownChip('Price', ['mobile.leftovers.any_price'.tr(), 'Under \$1M', '\$1M - \$5M', '\$5M - \$10M', '\$10M+'], colors),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildDropdownChip(String label, List<String> options, ThemeAwareColors colors) {
    String currentLabel = label;
    if (label == 'Region') {
      final region = ref.watch(searchRegionProvider);
      if (region != 'GLOBAL') currentLabel = region;
    }
    
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (label == 'Type') {
          ref.read(selectedPropertyTypeProvider.notifier).state = value;
        } else if (label == 'Region') {
          ref.read(searchRegionProvider.notifier).state = value;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('selected_region_code', value);
          ref.invalidate(propertyListProvider); // Trigger re-fetch from backend with new region
        }
      },
      itemBuilder: (context) => options.map((option) => PopupMenuItem(
        value: option,
        child: Text(option, style: GoogleFonts.outfit(color: colors.textPrimary)),
      )).toList(),
      color: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: (label == 'Region' && currentLabel != 'Region') ? AppColors.primary.withOpacity(0.2) : colors.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: (label == 'Region' && currentLabel != 'Region') ? AppColors.primary : colors.border.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label == 'Region') ...[
              const Icon(Icons.public_rounded, size: 14, color: AppColors.primary),
              const SizedBox(width: 4),
            ],
            Text(currentLabel, style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.w500, fontSize: 13)),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down_rounded, color: colors.textSecondary, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreDashboard(List<Property> properties, ThemeAwareColors colors, bool isSplitView) {
    return ListView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 150, bottom: 120, left: 16, right: 16),
      children: [
        _buildAIPromptWidget(colors),
        const SizedBox(height: 32),
        // Trending Searches Section
        _buildTrendingSearches(colors),
        const SizedBox(height: 32),
        _buildSectionTitle('mobile.auto.popular_locations'.tr(), Icons.location_city_rounded, colors),
        const SizedBox(height: 16),
        _buildStaggeredLocationsGrid(),
        
        if (properties.isNotEmpty) ...[
          const SizedBox(height: 32),
          _buildSectionTitle('mobile.auto.recommended_for_you'.tr(), Icons.auto_awesome_rounded, colors),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isSplitView ? 2 : 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: properties.length > 6 ? 6 : properties.length,
            itemBuilder: (context, index) => _buildPropertyItem(properties[index], colors),
          ),
          const SizedBox(height: 16),
          Center(
            child: TextButton.icon(
              onPressed: () => ref.read(searchQueryProvider.notifier).state = ' ',
              icon: Icon(Icons.grid_view_rounded, size: 16, color: AppColors.primary),
              label: Text('View All Properties', style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ),
          ),
        ]
      ],
    ).animate().fadeIn();
  }

  Widget _buildSectionTitle(String title, IconData icon, ThemeAwareColors colors) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(title, style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: colors.textPrimary)),
        ),
      ],
    ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.05);
  }

  Widget _buildTrendingSearches(ThemeAwareColors colors) {
    final trends = [
      {'icon': Icons.trending_up_rounded, 'label': 'Waterfront Villas', 'tag': '+24%'},
      {'icon': Icons.apartment_rounded, 'label': 'Penthouse Istanbul', 'tag': 'Hot'},
      {'icon': Icons.villa_rounded, 'label': 'Bodrum Luxury', 'tag': '+18%'},
      {'icon': Icons.location_city_rounded, 'label': 'Dubai Marina', 'tag': 'New'},
      {'icon': Icons.landscape_rounded, 'label': 'Amalfi Coast', 'tag': '+12%'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Trending Searches', Icons.trending_up_rounded, colors),
        const SizedBox(height: 12),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: trends.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final t = trends[index];
              return GestureDetector(
                onTap: () {
                  _searchController.text = t['label'] as String;
                  ref.read(searchQueryProvider.notifier).state = t['label'] as String;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: colors.border.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(t['icon'] as IconData, size: 14, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(t['label'] as String, style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(t['tag'] as String, style: GoogleFonts.outfit(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: (index * 80).ms).slideX(begin: 0.1);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAIPromptWidget(ThemeAwareColors colors) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Text('mobile.auto.ai_suggestions'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.2))),
            child: Row(
              children: [
                Expanded(
                  child: Text('mobile.auto.looking_for_waterfront_villas_with_infinite_pools_explore_our_new_collection_in_amalfi_coast'.tr(), style: GoogleFonts.outfit(color: Colors.white, fontSize: 14)),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: Icon(Icons.send_rounded, color: const Color(0xFF2E3192), size: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 3000.ms, color: Colors.white12);
  }

  Widget _buildStaggeredLocationsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.8,
      children: [
        _buildLocationCard('Malibu', 'mobile.leftovers.12_properties'.tr(), 'https://images.unsplash.com/photo-1549487679-88c9df4ba1d4?w=800'),
        Column(
          children: [
            Expanded(flex: 3, child: _buildLocationCard('mobile.leftovers.dubai_marina'.tr(), 'mobile.leftovers.8_properties'.tr(), 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=800')),
            const SizedBox(height: 16),
            Expanded(flex: 4, child: _buildLocationCard('Montecito', 'mobile.leftovers.5_properties'.tr(), 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800')),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationCard(String title, String subtitle, String imgUrl) {
    return GestureDetector(
      onTap: () {
        _searchController.text = title;
        ref.read(searchQueryProvider.notifier).state = title;
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(imgUrl, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[900],
                child: const Center(child: Icon(Icons.image_not_supported, color: Colors.white24, size: 32)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withOpacity(0.8), Colors.transparent, Colors.transparent]),
              ),
            ),
            Positioned(
              bottom: 16, left: 16, right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: AppColors.primary, size: 12),
                      const SizedBox(width: 4),
                      Text(subtitle, style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<Property> properties, ThemeAwareColors colors, bool isSplitView) {
    final viewType = ref.watch(propertyViewTypeProvider);
    if (viewType == PropertyViewType.list) {
      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 140, bottom: 120, left: 16, right: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: properties.length,
        itemBuilder: (context, index) => _buildPropertyListTile(properties[index], colors),
      );
    }
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 140, bottom: 120, left: 16, right: 16),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isSplitView ? 2 : 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: properties.length,
      itemBuilder: (context, index) => _buildPropertyItem(properties[index], colors),
    );
  }

  Widget _buildPropertyItem(Property property, ThemeAwareColors colors) {
    final price = calculatePropertyPrice(property);
    // Simulate AI match score for premium feel
    final matchScore = 85 + (property.id.hashCode % 15);
    final hasVirtualTour = property.photos.length > 2; // Simulate AR/VR availability

    return GestureDetector(
      onTap: () => context.push('/properties/${property.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colors.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'property_image_${property.id}',
                    child: property.photos.isNotEmpty
                      ? PageView.builder(
                          itemCount: property.photos.length,
                          itemBuilder: (c, i) => Image.network(property.photos[i].url, fit: BoxFit.cover),
                        )
                      : Image.network('https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&q=80', fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 12, left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.auto_awesome, color: Colors.amber, size: 12),
                          const SizedBox(width: 4),
                          Text('$matchScore% Match', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                  if (hasVirtualTour)
                    Positioned(
                      top: 12, right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.view_in_ar_rounded, color: Colors.white, size: 12),
                            const SizedBox(width: 4),
                            Text('3D Tour', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                          ],
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 12, right: 12,
                    child: GestureDetector(
                      onTap: () => ref.read(propertyFavoritesProvider.notifier).toggleFavorite(property.id),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          ref.watch(propertyFavoritesProvider).contains(property.id)
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: ref.watch(propertyFavoritesProvider).contains(property.id)
                              ? Colors.redAccent
                              : Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(price != null ? _formatPrice(price) : 'mobile.auto.tbd'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.w900, fontSize: 18)),
                  const SizedBox(height: 6),
                  Text(property.name, style: GoogleFonts.outfit(color: colors.textSecondary, fontWeight: FontWeight.w500, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: AppColors.primary, size: 14),
                      const SizedBox(width: 4),
                      Expanded(child: Text(property.city, style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOutQuart);
  }

  Widget _buildPropertyListTile(Property property, ThemeAwareColors colors) {
    final price = calculatePropertyPrice(property);
    final matchScore = 85 + (property.id.hashCode % 15);
    final hasVirtualTour = property.photos.length > 2;

    return GestureDetector(
      onTap: () => context.push('/properties/${property.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surface, 
          borderRadius: BorderRadius.circular(24), 
          border: Border.all(color: colors.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5)),
          ],
        ),
        child: Row(
          children: [
            Hero(
              tag: 'property_image_list_${property.id}',
              child: Container(
                width: 130, height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: NetworkImage(property.photos.isNotEmpty ? property.photos.first.url : 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800&q=80'), fit: BoxFit.cover),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 8, left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            const Icon(Icons.auto_awesome, color: Colors.amber, size: 10),
                            const SizedBox(width: 4),
                            Text('$matchScore%', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasVirtualTour)
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Text('3D TOUR AVAILABLE', style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 9, letterSpacing: 0.5)),
                    ),
                  Text(property.name, style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on_rounded, color: colors.textSecondary.withOpacity(0.7), size: 12),
                      const SizedBox(width: 4),
                      Text(property.city, style: TextStyle(color: colors.textSecondary.withOpacity(0.9), fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price != null ? _formatPrice(price) : 'mobile.auto.tbd'.tr(), style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.w900, fontSize: 18)),
                      Row(
                        children: [
                          Icon(Icons.bed_rounded, color: colors.textSecondary.withOpacity(0.5), size: 14),
                          const SizedBox(width: 4),
                          Text('${property.bedrooms ?? 0}', style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 12),
                          Icon(Icons.square_foot_rounded, color: colors.textSecondary.withOpacity(0.5), size: 14),
                          const SizedBox(width: 4),
                          Text('${property.areaSqm?.toInt() ?? 0}m²', style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
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
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOutQuart);
  }

  Widget _buildMapView(List<Property> properties, ThemeAwareColors colors, {required bool isSplitView}) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
    final Set<gmaps.Marker> markers = {};
    for (int i = 0; i < properties.length; i++) {
      final p = properties[i];
      final lat = p.lat ?? (34.0200 + (i * 0.01));
      final lng = p.lng ?? (-118.4900 + (i * 0.015));
      markers.add(gmaps.Marker(
        markerId: gmaps.MarkerId(p.id),
        position: gmaps.LatLng(lat, lng),
        infoWindow: gmaps.InfoWindow(title: p.name, snippet: '\$${p.listingPrice?.toStringAsFixed(0) ?? 'mobile.auto.tbd'.tr()}'),
        onTap: () => context.push('/properties/${p.id}'),
      ));
    }
    return Stack(
      children: [
        gmaps.GoogleMap(
          initialCameraPosition: const gmaps.CameraPosition(target: gmaps.LatLng(34.0200, -118.4900), zoom: 11),
          markers: markers,
          mapType: gmaps.MapType.normal,
          myLocationEnabled: false, zoomControlsEnabled: false, mapToolbarEnabled: false,
          style: isDark ? _darkMapStyle : null,
        ),
        if (!isSplitView)
          Positioned(
            bottom: 100, left: 0, right: 0, height: 160,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.85),
              itemCount: properties.length,
              itemBuilder: (context, index) => Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: _buildPropertyListTile(properties[index], colors)),
            ),
          ),
      ],
    );
  }

  static const String _darkMapStyle = '[{"elementType":"geometry","stylers":[{"color":"#1d2c4d"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#8ec3b9"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#1a3646"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#304a7d"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#0e1626"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#283d6a"}]}]';

  Widget _buildEmptyState(ThemeAwareColors colors, bool isSearching) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(isSearching ? Icons.search_off_rounded : Icons.explore_rounded, size: 64, color: colors.textSecondary.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text(isSearching ? 'mobile.auto.no_properties_found'.tr() : 'mobile.auto.explore_global_listings'.tr(), style: GoogleFonts.outfit(color: colors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(isSearching ? 'mobile.auto.try_adjusting_filters'.tr() : 'mobile.auto.start_searching'.tr(), textAlign: TextAlign.center, style: GoogleFonts.outfit(color: colors.textSecondary.withOpacity(0.5), fontSize: 13)),
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return '\$${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return '\$${(price / 1000).toStringAsFixed(0)}K';
    }
    return '\$${price.toStringAsFixed(0)}';
  }

  Widget _buildFloatingViewToggle(ThemeAwareColors colors) {
    final viewType = ref.watch(propertyViewTypeProvider);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.surface.withOpacity(0.95),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 5))],
        border: Border.all(color: colors.border.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(Icons.grid_view_rounded, 'Grid', PropertyViewType.grid, viewType, colors),
          _buildToggleButton(Icons.view_list_rounded, 'List', PropertyViewType.list, viewType, colors),
          _buildToggleButton(Icons.map_rounded, 'Map', PropertyViewType.map, viewType, colors),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.5);
  }

  Widget _buildToggleButton(IconData icon, String label, PropertyViewType type, PropertyViewType current, ThemeAwareColors colors) {
    final isSelected = type == current;
    return GestureDetector(
      onTap: () => ref.read(propertyViewTypeProvider.notifier).state = type,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(color: isSelected ? AppColors.primary : Colors.transparent, borderRadius: BorderRadius.circular(28)),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.black : colors.textPrimary, size: 18),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(label, style: GoogleFonts.outfit(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
            ]
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context, ThemeAwareColors colors) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _FilterSheet(ref: ref),
    );
  }
}

class _FilterSheet extends ConsumerWidget {
  final WidgetRef ref;
  const _FilterSheet({required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(themeAwareColorsProvider);
    final filterState = ref.watch(propertyFilterProvider);
    final filterNotifier = ref.read(propertyFilterProvider.notifier);

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(color: colors.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: colors.textSecondary.withOpacity(0.2), borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('mobile.auto.advanced_filters'.tr(), style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w900, color: colors.textPrimary)),
                TextButton(
                  onPressed: () => filterNotifier.resetFilters(),
                  child: const Text('Reset', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              physics: const BouncingScrollPhysics(),
              children: [
                _buildPriceSection(filterState, filterNotifier, colors),
                const SizedBox(height: 32),
                _buildRoomsSection(filterState, filterNotifier, colors),
                const SizedBox(height: 32),
                _buildTypeSection(filterState, filterNotifier, colors),
                const SizedBox(height: 32),
                _buildSortSection(filterState, filterNotifier, colors),
                const SizedBox(height: 32),
                _buildAmenitiesSection(filterState, filterNotifier, colors),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text('mobile.auto.apply_selection'.tr(), style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(PropertyFilterState state, PropertyFilterNotifier notifier, ThemeAwareColors colors) {
    final currentRange = RangeValues(state.minPrice ?? 0, state.maxPrice ?? 10000000);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('mobile.auto.price_range'.tr(), style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: colors.textPrimary)),
        const SizedBox(height: 24),
        RangeSlider(
          values: currentRange,
          onChanged: (v) => notifier.updatePriceRange(v.start, v.end),
          min: 0, max: 10000000, divisions: 100,
          activeColor: AppColors.primary,
          inactiveColor: colors.border,
          labels: RangeLabels('₺${currentRange.start.toInt()}', '₺${currentRange.end.toInt()}'),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('₺${(currentRange.start / 1000).toStringAsFixed(0)}K', style: TextStyle(color: colors.textSecondary, fontSize: 14)),
            Text('₺${(currentRange.end / 1000000).toStringAsFixed(1)}M+', style: TextStyle(color: colors.textSecondary, fontSize: 14)),
          ],
        ),
      ],
    );
  }

  Widget _buildRoomsSection(PropertyFilterState state, PropertyFilterNotifier notifier, ThemeAwareColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Rooms', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: colors.textPrimary)),
        const SizedBox(height: 16),
        Text('Bedrooms', style: TextStyle(color: colors.textSecondary, fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: ['ALL', '1', '2', '3', '4', '5+'].map((b) {
            final isSelected = (state.bedrooms ?? 'ALL') == b;
            return GestureDetector(
              onTap: () => notifier.updateBedrooms(b),
              child: _buildChip(b == 'ALL' ? 'Any' : b, isSelected, colors),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        Text('Bathrooms', style: TextStyle(color: colors.textSecondary, fontSize: 14)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: ['ALL', '1', '2', '3', '4+'].map((b) {
            final isSelected = (state.bathrooms ?? 'ALL') == b;
            return GestureDetector(
              onTap: () => notifier.updateBathrooms(b),
              child: _buildChip(b == 'ALL' ? 'Any' : b, isSelected, colors),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTypeSection(PropertyFilterState state, PropertyFilterNotifier notifier, ThemeAwareColors colors) {
    final types = PropertyType.values.map((e) => e.name).toList();
    types.insert(0, 'ALL');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Property Type', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: colors.textPrimary)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: types.map((t) {
            final isSelected = (state.propertyType ?? 'ALL') == t;
            return GestureDetector(
              onTap: () => notifier.updatePropertyType(t),
              child: _buildChip(t == 'ALL' ? 'Any Type' : t, isSelected, colors),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSortSection(PropertyFilterState state, PropertyFilterNotifier notifier, ThemeAwareColors colors) {
    final sorts = {
      'DEFAULT': 'Default',
      'PRICE_ASC': 'Price: Low to High',
      'PRICE_DESC': 'Price: High to Low',
      'NEWEST': 'Newest',
      'AREA_DESC': 'Largest Area'
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sort By', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: colors.textPrimary)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: sorts.entries.map((e) {
            final isSelected = (state.sortBy ?? 'DEFAULT') == e.key;
            return GestureDetector(
              onTap: () => notifier.updateSortBy(e.key),
              child: _buildChip(e.value, isSelected, colors),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAmenitiesSection(PropertyFilterState state, PropertyFilterNotifier notifier, ThemeAwareColors colors) {
    final amenities = [
      'AIR_CONDITIONING', 'UNDERFLOOR_HEATING', 'FIREPLACE', 'FIBER_INTERNET', 'FURNISHED',
      'SWIMMING_POOL', 'GYM', 'ELEVATOR', 'PARKING', 'SECURITY', 'SEA_VIEW', 'CITY_VIEW'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Amenities', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: colors.textPrimary)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: amenities.map((a) {
            final isSelected = (state.amenities ?? []).contains(a);
            return GestureDetector(
              onTap: () => notifier.toggleAmenity(a),
              child: _buildChip(a.replaceAll('_', ' '), isSelected, colors),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildChip(String label, bool isSelected, ThemeAwareColors colors) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withOpacity(0.1) : colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? AppColors.primary : colors.border),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? AppColors.primary : colors.textSecondary, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, fontSize: 13)),
    );
  }
}
