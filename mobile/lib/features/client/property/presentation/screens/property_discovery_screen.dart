import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/models/property.dart';
import 'package:reservatior/shared/providers/property_provider.dart';
import 'package:reservatior/features/client/property/presentation/widgets/advanced_search_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_map_advanced_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/property_card_advanced_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/discovery_categories_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/featured_properties_widget.dart';
import 'package:reservatior/features/client/property/presentation/widgets/neighborhood_insights_widget.dart';


class PropertyDiscoveryScreen extends ConsumerStatefulWidget {
  const PropertyDiscoveryScreen({super.key});

  @override
  ConsumerState<PropertyDiscoveryScreen> createState() =>
      _PropertyDiscoveryScreenState();
}

class _PropertyDiscoveryScreenState
    extends ConsumerState<PropertyDiscoveryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;
  String _searchQuery = '';
  int _currentViewIndex = 0;

  final List<String> _viewTypes = ['DISCOVER', 'MAP', 'LIST', 'ANALYTICS'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _pageController = PageController();

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProperties = ref.watch(filteredPropertiesProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildSliverAppBar(innerBoxIsScrolled),
          SliverToBoxAdapter(child: _buildAdvancedSearchBar()),
          SliverToBoxAdapter(child: _buildViewTypeSelector()),
        ],
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            _tabController.animateTo(index);
            setState(() => _currentViewIndex = index);
          },
          children: [
            _buildDiscoverView(filteredProperties),
            _buildMapView(filteredProperties),
            _buildListView(filteredProperties),
            _buildAnalyticsView(),
          ],
        ),
      ),
      floatingActionButton: _buildContextualFAB(),
    );
  }

  Widget _buildSliverAppBar(bool innerBoxIsScrolled) {
    return SliverAppBar(
      expandedHeight: 180,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.darkBg,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none_rounded,
            color: Colors.white70,
          ),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [AppColors.primary.withOpacity(0.2), AppColors.darkBg],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -50,
                top: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withOpacity(0.05),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('mobile.auto.neural_discovery'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 4),
            Text('mobile.auto.global_inventory'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
      ),
    );
  }

  Widget _buildAdvancedSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
              _isSearching = value.isNotEmpty;
            });
            ref.read(propertySearchProvider.notifier).search(value);
          },
          decoration: InputDecoration(
            hintText: 'mobile.auto.neural_search'.tr(),
            hintStyle: const TextStyle(color: Colors.white24),
            icon: Icon(
              Icons.search_rounded,
              color: AppColors.primary,
              size: 20,
            ),
            border: InputBorder.none,
            suffixIcon: _isSearching
                ? IconButton(
                    icon: Icon(Icons.close, size: 18),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(propertySearchProvider.notifier).clear();
                      setState(() => _isSearching = false);
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildViewTypeSelector() {
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(24, 8, 24, 16),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        labelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.w900,
          fontSize: 10,
          letterSpacing: 1,
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white38,
        dividerColor: Colors.transparent,
        tabs: _viewTypes.map((t) => Tab(text: t)).toList(),
      ),
    );
  }

  Widget _buildDiscoverView(List<Property> properties) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(24, 0, 24, 100),
      children: [
        const DiscoveryCategoriesWidget(),
        SizedBox(height: 32),
        _sectionHeader('mobile.leftovers.featured_opportunities'.tr(), () {}),
        SizedBox(height: 16),
        FeaturedPropertiesWidget(properties: properties.take(6).toList()),
        SizedBox(height: 32),
        const NeighborhoodInsightsWidget(),
        SizedBox(height: 32),
        _sectionHeader('mobile.leftovers.market_feed'.tr(), () {}),
        SizedBox(height: 16),
        ...properties.map(
          (p) => Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: PropertyCardAdvancedWidget(
              property: p,
              viewType: PropertyViewType.list,
              onTap: () => context.push('/property/${p.id}'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMapView(List<Property> properties) {
    return PropertyMapAdvancedWidget(
      properties: properties,
      onPropertyTap: (p) => context.push('/property/${p.id}'),
    );
  }

  Widget _buildListView(List<Property> properties) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(24, 0, 24, 100),
      itemCount: properties.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: PropertyCardAdvancedWidget(
          property: properties[index],
          viewType: PropertyViewType.list,
          onTap: () => context.push('/property/${properties[index].id}'),
        ),
      ),
    );
  }

  Widget _buildAnalyticsView() {
    return ListView(
      padding: EdgeInsets.all(24),
      children: [
        Text('mobile.auto.market_intelligence'.tr(),
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 24),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Center(
            child: Text('mobile.auto.neural_trends_data_flowing'.tr(),
              style: TextStyle(color: Colors.white24),
            ),
          ),
        ),
        SizedBox(height: 24),
        ...['Istanbul', 'London', 'Dubai', 'mobile.leftovers.new_york'.tr()].map(
          (city) => ListTile(
            leading: Icon(
              Icons.location_city_rounded,
              color: Colors.white54,
            ),
            title: Text(
              city,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              '+12.4%',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title, VoidCallback onMore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            color: Colors.white38,
            letterSpacing: 2,
          ),
        ),
        Icon(
          Icons.arrow_forward_rounded,
          size: 16,
          color: AppColors.primary.withOpacity(0.5),
        ),
      ],
    );
  }

  Widget? _buildContextualFAB() {
    if (_currentViewIndex == 0 || _currentViewIndex == 2) {
      return FloatingActionButton.extended(
        onPressed: _showAdvancedFilters,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        icon: Icon(Icons.tune_rounded),
        label: Text('mobile.auto.filters'.tr(),
          style: GoogleFonts.outfit(fontWeight: FontWeight.w900),
        ),
      ).animate().scale(duration: 300.ms);
    }
    return null;
  }

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AdvancedSearchWidget(),
    );
  }
}
