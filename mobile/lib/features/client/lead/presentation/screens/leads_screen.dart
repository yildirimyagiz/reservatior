import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/theme_provider.dart';
import 'package:reservatior/shared/providers/lead_provider.dart';
import 'package:reservatior/shared/models/models.dart';

class LeadsScreen extends ConsumerStatefulWidget {
  const LeadsScreen({super.key});

  @override
  ConsumerState<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends ConsumerState<LeadsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.watch(themeAwareColorsProvider);
    final leadsAsync = ref.watch(leadListProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(colors),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMarketingHeader(colors),
                  SizedBox(height: 32),
                  _buildSearchAndTabs(colors),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
          leadsAsync.when(
            data: (leads) {
              final filtered = leads.where((l) => (l.firstName ?? '' + ' ' + (l.lastName ?? '')).toLowerCase().contains(_searchQuery.toLowerCase())).toList();
              
              return SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final l = filtered[index];
                      return _buildLeadCard(l, colors);
                    },
                    childCount: filtered.length,
                  ),
                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
      ).animate().scale(delay: 500.ms),
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
              CircleAvatar(
                radius: 18,
                backgroundColor: colors.surface,
                child: Icon(Icons.filter_list_rounded, color: colors.textSecondary, size: 18),
              ),
            ],
          ),
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
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.groups_rounded, color: Colors.blue, size: 12),
              SizedBox(width: 6),
              Text('mobile.auto.customer_relationship_management'.tr(),
                style: GoogleFonts.outfit(
                  color: Colors.blue,
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text('mobile.auto.lead_management'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        Text('mobile.auto.manage_your_customer_pipeline_and_conversion_with_ai_insights'.tr(),
          style: GoogleFonts.outfit(
            color: colors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndTabs(ThemeAwareColors colors) {
    return Column(
      children: [
        Container(
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
              hintText: 'mobile.auto.search_by_client_name'.tr(),
              hintStyle: TextStyle(color: colors.textSecondary.withOpacity(0.5)),
              border: InputBorder.none,
              icon: Icon(Icons.search_rounded, color: colors.textSecondary.withOpacity(0.5), size: 20),
            ),
          ),
        ),
        SizedBox(height: 24),
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primary,
          unselectedLabelColor: colors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: [
            Tab(text: 'NEW'),
            Tab(text: 'CONTACTED'),
            Tab(text: 'OFFER'),
            Tab(text: 'CLOSED'),
          ],
        ),
      ],
    );
  }

  Widget _buildLeadCard(Lead l, ThemeAwareColors colors) {
    final statusColor = Colors.blue; 
    final score = 85 + (l.id.hashCode % 10);
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(
                  (l.firstName ?? 'U')[0].toUpperCase(),
                  style: GoogleFonts.outfit(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${l.firstName ?? ""} ${l.lastName ?? ""}', style: GoogleFonts.outfit(color: colors.textPrimary, fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 4),
                    Text(l.email ?? 'mobile.leftovers.no_email'.tr(), style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star_rounded, color: Colors.green, size: 12),
                    SizedBox(width: 4),
                    Text('$score', style: GoogleFonts.outfit(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem('INTEREST', 'mobile.leftovers.villa_istanbul'.tr(), colors),
              _buildInfoItem('SOURCE', 'Instagram', colors),
              _buildInfoItem('DATE', 'Today', colors),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildQuickAction(Icons.phone_rounded, 'Call', Colors.blue, colors),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildQuickAction(Icons.chat_bubble_outline_rounded, 'WhatsApp', Colors.green, colors),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildQuickAction(Icons.email_outlined, 'Email', Colors.amber, colors),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, ThemeAwareColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(color: colors.textSecondary.withOpacity(0.5), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
        SizedBox(height: 4),
        Text(value, style: GoogleFonts.outfit(color: colors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color color, ThemeAwareColors colors) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Center(
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}
