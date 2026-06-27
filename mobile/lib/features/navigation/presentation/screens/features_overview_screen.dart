import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/providers/ai/gemini_hub_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/navigation/feature_helper.dart';

class FeaturesOverviewScreen extends ConsumerStatefulWidget {
  const FeaturesOverviewScreen({super.key});

  @override
  ConsumerState<FeaturesOverviewScreen> createState() => _FeaturesOverviewScreenState();
}

class _FeaturesOverviewScreenState extends ConsumerState<FeaturesOverviewScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final Set<String> _expandedCategories = {'AI & ML'};
  late AnimationController _bgAnimationController;

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
  void initState() {
    super.initState();
    _bgAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _bgAnimationController.dispose();
    super.dispose();
  }

  (IconData, Color, Color, Color) _getStylingForCategory(String category) {
    switch (category) {
      case 'AI & ML':
        return (Icons.auto_awesome, const Color(0xFFF472B6), const Color(0xFFDB2777), const Color(0xFF831843));
      case 'Financial':
        return (Icons.payments_outlined, const Color(0xFF34D399), const Color(0xFF059669), const Color(0xFF064E3B));
      case 'Property':
        return (Icons.business_outlined, const Color(0xFFFBBF24), const Color(0xFFD97706), const Color(0xFF78350F));
      case 'CRM & Users':
        return (Icons.people_alt_outlined, const Color(0xFF60A5FA), const Color(0xFF2563EB), const Color(0xFF1E3A8A));
      case 'Legal':
        return (Icons.gavel_outlined, const Color(0xFFA78BFA), const Color(0xFF7C3AED), const Color(0xFF4C1D95));
      case 'Systems':
      default:
        return (Icons.settings_suggest_outlined, const Color(0xFF38BDF8), const Color(0xFF0284C7), const Color(0xFF0C4A6E));
    }
  }

  @override
  Widget build(BuildContext context) {
    final allGroups = FeatureHelper.getFeatureGroups();

    return Scaffold(
      backgroundColor: const Color(0xFF030712), // Extremely dark blue/black
      body: Stack(
        children: [
          // Dynamic animated background blobs
          _buildAnimatedBackground(),
          
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildHeroAppBar(),
              _buildSearchBar(),
              _buildChatPanel(),
              _buildCategoryTabs(),
              ..._buildExpandableCategories(allGroups),
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _bgAnimationController,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: -100 + 50 * math.sin(_bgAnimationController.value * 2 * math.pi),
              left: -100 + 50 * math.cos(_bgAnimationController.value * 2 * math.pi),
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.15),
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 1.0, end: 1.2, duration: 4.seconds),
            ),
            Positioned(
              bottom: 100 + 30 * math.cos(_bgAnimationController.value * 2 * math.pi),
              right: -50 + 80 * math.sin(_bgAnimationController.value * 2 * math.pi),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.purple.withOpacity(0.1),
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 1.2, end: 1.0, duration: 5.seconds),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(color: Colors.transparent),
              ),
            ),
          ],
        );
      },
    );
  }

  SliverAppBar _buildHeroAppBar() {
    return SliverAppBar(
      expandedHeight: 280,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
        ),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: ClipRRect(
        child: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
          title: Row(
            children: [
              Text(
                'Platform Ecosystem',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                ),
                child: Text(
                  '200+ MODULES',
                  style: GoogleFonts.outfit(
                    color: AppColors.primaryLight,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.2),
          background: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=2000&auto=format&fit=crop', // A sleek, dark futuristic tech background
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF030712).withOpacity(0.2),
                      const Color(0xFF030712).withOpacity(0.8),
                      const Color(0xFF030712),
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 16),
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      ref.read(geminiHubProvider.notifier).sendMessage(value);
                      FocusScope.of(context).unfocus();
                    }
                  },
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search or chat with Gemini...',
                    hintStyle: GoogleFonts.outfit(color: Colors.white.withOpacity(0.4)),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(Icons.search_rounded, color: AppColors.primary),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 18),
                  ),
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final geminiState = ref.watch(geminiHubProvider);
                  
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (geminiState.messages.isNotEmpty || _searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white54, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                            ref.read(geminiHubProvider.notifier).clearChat();
                          },
                        ),
                      GestureDetector(
                        onTap: () {
                          final query = _searchController.text;
                          if (query.trim().isNotEmpty) {
                            ref.read(geminiHubProvider.notifier).sendMessage(query);
                            FocusScope.of(context).unfocus();
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: geminiState.isLoading
                              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryLight))
                              : const Icon(Icons.send_rounded, color: AppColors.primaryLight, size: 18),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
      ),
    );
  }

  SliverToBoxAdapter _buildChatPanel() {
    return SliverToBoxAdapter(
      child: Consumer(
        builder: (context, ref, child) {
          final geminiState = ref.watch(geminiHubProvider);
          if (geminiState.messages.isEmpty) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Container(
              height: 300, // Fixed height for scrolling chat
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withOpacity(0.2)),
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: geminiState.messages.length,
                itemBuilder: (context, index) {
                  final msg = geminiState.messages[index];
                  final isUser = msg['role'] == 'user';
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            if (!isUser) ...[
                              const Icon(Icons.auto_awesome, color: AppColors.primaryLight, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                msg['intent']?.replaceAll('_', ' ') ?? 'AI ASSISTANT',
                                style: GoogleFonts.outfit(
                                  color: AppColors.primaryLight,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ] else ...[
                              Text(
                                'YOU',
                                style: GoogleFonts.outfit(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.person, color: Colors.white54, size: 16),
                            ]
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.white.withOpacity(0.1) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            msg['text'] ?? '',
                            style: GoogleFonts.outfit(color: Colors.white.withOpacity(0.9), fontSize: 14, height: 1.4),
                          ),
                        ),
                        if (!isUser && msg['actions'] != null && (msg['actions'] as List).isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: (msg['actions'] as List).map((action) {
                              return ActionChip(
                                onPressed: () {
                                  final route = action['route'] as String;
                                  if (route.startsWith('/')) {
                                    context.go(route);
                                  }
                                },
                                backgroundColor: AppColors.primary.withOpacity(0.2),
                                side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                avatar: Icon(FeatureHelper.getIconForModule(action['route'] ?? ''), size: 16, color: AppColors.primaryLight),
                                label: Text(
                                  action['label'],
                                  style: GoogleFonts.outfit(color: AppColors.primaryLight, fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                              );
                            }).toList(),
                          ),
                        ]
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1, end: 0);
                },
              ),
            ).animate().fadeIn().slideY(begin: 0.1, end: 0),
          );
        },
      ),
    );
  }

  SliverToBoxAdapter _buildCategoryTabs() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = _selectedCategory == category;
            
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: () => setState(() => _selectedCategory = category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: isSelected ? LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.8),
                        AppColors.primaryDark,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ) : null,
                    color: isSelected ? null : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected ? AppColors.primaryLight.withOpacity(0.5) : Colors.white.withOpacity(0.05),
                      width: 1,
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      )
                    ] : [],
                  ),
                  child: Center(
                    child: Text(
                      category,
                      style: GoogleFonts.outfit(
                        color: isSelected ? Colors.white : Colors.white60,
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: (250 + (index * 50)).ms).slideX(begin: 0.1),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildExpandableCategories(List<FeatureGroup> allGroups) {
    final List<Widget> slivers = [];
    
    // We iterate over categories, skipping 'All'
    for (final category in _categories.where((c) => c != 'All')) {
      // If a specific category is selected from the top chips, and it's not this one, skip
      if (_selectedCategory != 'All' && _selectedCategory != category) continue;
      
      final categoryGroups = allGroups.where((g) {
        final isCategory = g.category == category;
        if (!isCategory) return false;
        
        if (_searchQuery.isEmpty) return true;
        
        final matchesGroupName = g.getLocalizedName(context).toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesSubModule = g.subModules.any((sub) => sub['name']!.toLowerCase().contains(_searchQuery.toLowerCase()));
        
        return matchesGroupName || matchesSubModule;
      }).toList();
      
      if (categoryGroups.isEmpty) continue;
      
      // Auto-expand if search query is active, otherwise rely on _expandedCategories
      final isExpanded = _searchQuery.isNotEmpty || _expandedCategories.contains(category);
      final styling = _getStylingForCategory(category);
      
      // Header
      slivers.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_expandedCategories.contains(category)) {
                    _expandedCategories.remove(category);
                  } else {
                    _expandedCategories.add(category);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: styling.$4.withOpacity(0.3), // Dark background color from styling
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: styling.$3.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Icon(styling.$1, color: styling.$2, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$category (${categoryGroups.length})',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                      color: Colors.white54,
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn().slideX(begin: 0.05),
          ),
        ),
      );
      
      // Grid
      if (isExpanded) {
        slivers.add(
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.90,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final group = categoryGroups[index];
                  
                  return _PremiumEcosystemGroupCard(
                    group: group,
                    lightColor: styling.$2,
                    primaryColor: styling.$3,
                    darkBgColor: styling.$4,
                    category: category,
                    index: index,
                    onTap: () => FeatureHelper.showSubModulesBottomSheet(
                      context: context,
                      group: group,
                      lightColor: styling.$2,
                      primaryColor: styling.$3,
                      darkBgColor: styling.$4,
                      searchQuery: _searchQuery,
                    ),
                  );
                },
                childCount: categoryGroups.length,
              ),
            ),
          ),
        );
      }
    }
    
    return slivers;
  }

}

class _PremiumEcosystemGroupCard extends StatelessWidget {
  final FeatureGroup group;
  final Color lightColor;
  final Color primaryColor;
  final Color darkBgColor;
  final String category;
  final int index;
  final VoidCallback onTap;

  const _PremiumEcosystemGroupCard({
    required this.group,
    required this.lightColor,
    required this.primaryColor,
    required this.darkBgColor,
    required this.category,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              darkBgColor.withOpacity(0.8),
              const Color(0xFF0F172A).withOpacity(0.9),
            ],
          ),
          border: Border.all(
            color: lightColor.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: lightColor.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Stack(
          children: [
            Positioned(
              right: -15,
              bottom: -15,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor.withOpacity(0.2),
                  backgroundBlendMode: BlendMode.screen,
                ),
              ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 1.0, end: 1.5, duration: 3.seconds),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: lightColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: lightColor.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Icon(group.icon, color: lightColor, size: 20),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_outward_rounded, color: Colors.white.withOpacity(0.4), size: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Text(
                        '${group.subModules.length} ${context.locale.languageCode == 'tr' ? 'MODÜL' : 'MODULES'}',
                        style: GoogleFonts.outfit(
                          color: lightColor.withOpacity(0.9),
                          fontSize: 8,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      group.getLocalizedName(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ).animate()
        .fadeIn(delay: (100 + (index * 50)).ms)
        .slideY(begin: 0.1, duration: 400.ms, curve: Curves.easeOutCubic),
    );
  }
}

