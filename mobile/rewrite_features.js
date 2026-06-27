const fs = require('fs');
const fileContent = fs.readFileSync('lib/features/navigation/presentation/screens/features_overview_screen.dart', 'utf8');

// Extract the features array
const arrayStart = fileContent.indexOf('return [');
const arrayEnd = fileContent.lastIndexOf('];') + 2;
const featuresArray = fileContent.substring(arrayStart, arrayEnd);

const newDartCode = `import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesOverviewScreen extends ConsumerStatefulWidget {
  const FeaturesOverviewScreen({super.key});

  @override
  ConsumerState<FeaturesOverviewScreen> createState() => _FeaturesOverviewScreenState();
}

class _FeaturesOverviewScreenState extends ConsumerState<FeaturesOverviewScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'AI & ML',
    'Financial',
    'Property',
    'CRM & Users',
    'Legal',
    'Systems'
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _getCategoryForModule(String name) {
    final lower = name.toLowerCase();
    
    // AI & ML
    if (lower.contains('ai') || lower.contains('ml') || lower.contains('predict') || lower.contains('analysis') || lower.contains('analytics') || lower.contains('recommendation') || lower.contains('valuation')) {
      return 'AI & ML';
    }
    
    // Financial
    if (lower.contains('payment') || lower.contains('finance') || lower.contains('financial') || lower.contains('escrow') || lower.contains('earning') || lower.contains('budget') || lower.contains('commission') || lower.contains('tax') || lower.contains('currency') || lower.contains('discount') || lower.contains('payout') || lower.contains('expense') || lower.contains('ledger')) {
      return 'Financial';
    }

    // Property & Assets
    if (lower.contains('property') || lower.contains('listing') || lower.contains('amenity') || lower.contains('floor') || lower.contains('mortgage') || lower.contains('rental') || lower.contains('home') || lower.contains('facility') || lower.contains('maintenance')) {
      return 'Property';
    }

    // CRM & Users
    if (lower.contains('user') || lower.contains('agent') || lower.contains('guest') || lower.contains('lead') || lower.contains('client') || lower.contains('message') || lower.contains('communication') || lower.contains('contact') || lower.contains('review') || lower.contains('ambassador')) {
      return 'CRM & Users';
    }

    // Legal & Compliance
    if (lower.contains('contract') || lower.contains('attorney') || lower.contains('compliance') || lower.contains('signature') || lower.contains('right') || lower.contains('legal') || lower.contains('solicitor')) {
      return 'Legal';
    }

    // Default to Systems
    return 'Systems';
  }

  (IconData, Color, Color) _getStylingForCategory(String category) {
    switch (category) {
      case 'AI & ML':
        return (Icons.auto_awesome, Colors.purpleAccent, Colors.deepPurple);
      case 'Financial':
        return (Icons.payments_outlined, Colors.greenAccent, Colors.green);
      case 'Property':
        return (Icons.business_outlined, Colors.orangeAccent, Colors.deepOrange);
      case 'CRM & Users':
        return (Icons.people_alt_outlined, Colors.blueAccent, Colors.blue);
      case 'Legal':
        return (Icons.gavel_outlined, Colors.redAccent, Colors.red);
      case 'Systems':
      default:
        return (Icons.settings_suggest_outlined, Colors.cyanAccent, Colors.cyan);
    }
  }

  @override
  Widget build(BuildContext context) {
    final allFeatures = _getAllFeatures();
    
    final filteredFeatures = allFeatures.where((f) {
      final matchesSearch = f['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || _getCategoryForModule(f['name']!) == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildHeroAppBar(),
          _buildSearchBar(),
          _buildCategoryTabs(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1, // more square for rich content
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final feature = filteredFeatures[index];
                  final category = _getCategoryForModule(feature['name']!);
                  final styling = _getStylingForCategory(category);
                  
                  return _EcosystemCard(
                    name: feature['name']!,
                    route: feature['route']!,
                    icon: styling.$1,
                    lightColor: styling.$2,
                    darkColor: styling.$3,
                    category: category,
                  );
                }, 
                childCount: filteredFeatures.length
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  SliverAppBar _buildHeroAppBar() {
    return SliverAppBar(
      expandedHeight: 240,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.darkBg.withOpacity(0.9),
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
            title: Text(
              'Ecosystem Dashboard',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            background: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const NetworkImage('https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=2000&auto=format&fit=crop'), // Abstract tech network
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(AppColors.darkBg.withOpacity(0.7), BlendMode.darken),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 60,
                    left: 20,
                    child: Text(
                      'Reservatior',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          onChanged: (value) => setState(() => _searchQuery = value),
          decoration: InputDecoration(
            hintText: 'Search 200+ intelligent modules...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
            prefixIcon: const Icon(Icons.search, color: AppColors.primary),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildCategoryTabs() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 60,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = _selectedCategory == category;
            
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: InkWell(
                onTap: () => setState(() => _selectedCategory = category),
                borderRadius: BorderRadius.circular(20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      category,
                      style: GoogleFonts.outfit(
                        color: isSelected ? Colors.white : Colors.white54,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Map<String, String>> _getAllFeatures() {
    ${featuresArray}
  }
}

class _EcosystemCard extends StatelessWidget {
  final String name;
  final String route;
  final IconData icon;
  final Color lightColor;
  final Color darkColor;
  final String category;

  const _EcosystemCard({
    required this.name,
    required this.route,
    required this.icon,
    required this.lightColor,
    required this.darkColor,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // Generate a beautiful, slightly readable title
    String title = name;
    if (title.startsWith('mobile.modules.')) {
      title = title.replaceAll('mobile.modules.', '').replaceAll('.tr()', '').replaceAll('_', ' ');
      title = title.split(' ').map((word) => word.isNotEmpty ? '\${word[0].toUpperCase()}\${word.substring(1)}' : '').join(' ');
    } else {
      // It might be a translated string, leave it.
      // We will try to capitalize it nicely.
    }

    return InkWell(
      onTap: () => context.push(route),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              darkColor.withOpacity(0.15),
              Colors.black.withOpacity(0.5),
            ],
          ),
          border: Border.all(
            color: lightColor.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: lightColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: lightColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: lightColor, size: 24),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 12),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.toUpperCase(),
                  style: GoogleFonts.outfit(
                    color: lightColor.withOpacity(0.8),
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
`;

fs.writeFileSync('lib/features/navigation/presentation/screens/features_overview_screen.dart', newDartCode);
