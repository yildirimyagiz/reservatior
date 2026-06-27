import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/client/property_valuation/property_valuation_notifier.dart';
import 'package:reservatior/shared/models/property_valuation.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyValuationListPage extends ConsumerStatefulWidget {
  const PropertyValuationListPage({super.key});

  @override
  ConsumerState<PropertyValuationListPage> createState() =>
      _PropertyValuationListPageState();
}

class _PropertyValuationListPageState
    extends ConsumerState<PropertyValuationListPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _pageSize = 20;

  @override
  void initState() {
    super.initState();
    _loadValuations();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreValuations();
    }
  }

  void _loadValuations() {
    final filter = ref.read(propertyValuationFilterProvider);
    ref
        .read(propertyValuationNotifierProvider.notifier)
        .loadValuations(
          orgId: filter.orgId,
          propertyId: filter.propertyId,
          agentId: filter.agentId,
          status: filter.status,
          valuationType: filter.valuationType,
          page: 1,
          limit: _pageSize,
        );
  }

  void _loadMoreValuations() {
    _currentPage++;
    final filter = ref.read(propertyValuationFilterProvider);
    ref
        .read(propertyValuationNotifierProvider.notifier)
        .loadValuations(
          orgId: filter.orgId,
          propertyId: filter.propertyId,
          agentId: filter.agentId,
          status: filter.status,
          valuationType: filter.valuationType,
          page: _currentPage,
          limit: _pageSize,
        );
  }

  void _refreshValuations() {
    _currentPage = 1;
    _loadValuations();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(propertyValuationNotifierProvider);

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
              'mobile.ai.valuation.neuralAssets'.tr(),
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.5,
                color: AppColors.primary,
              ),
            ),
            Text(
              'mobile.ai.valuation.hub'.tr(),
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
          IconButton(
            icon: const Icon(
              Icons.refresh_rounded,
              color: Colors.white54,
              size: 20,
            ),
            onPressed: _refreshValuations,
          ),
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
        child: Column(
          children: [
            const SizedBox(height: 120),
            _buildStatsCards(state.stats),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Divider(color: Colors.white10),
            ),
            Expanded(child: _buildValuationsList(state)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        elevation: 12,
        onPressed: _navigateToCreateValuation,
        icon: const Icon(Icons.add_chart_rounded, color: Colors.white),
        label: Text(
          'mobile.ai.valuation.newValuation'.tr(),
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

  Widget _buildStatsCards(Map<String, dynamic> stats) {
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _StatCard(
            title: 'mobile.ai.valuation.assets'.tr(),
            subtitle: 'mobile.ai.valuation.totalTracking'.tr(),
            value: (stats['totalValuations'] ?? '0').toString(),
            icon: Icons.account_balance_rounded,
            color: Colors.blue,
          ),
          _StatCard(
            title: 'mobile.ai.valuation.yield'.tr(),
            subtitle: 'mobile.ai.valuation.portfolioRoi'.tr(),
            value: '7.2%',
            icon: Icons.trending_up_rounded,
            color: Colors.green,
          ),
          _StatCard(
            title: 'mobile.ai.valuation.equity'.tr(),
            subtitle: 'mobile.ai.valuation.marketValue'.tr(),
            value: '\$4.2M',
            icon: Icons.auto_awesome_rounded,
            color: Colors.orange,
          ),
        ].animate(interval: 100.ms).fadeIn().slideX(begin: 0.1),
      ),
    );
  }

  Widget _buildValuationsList(PropertyValuationState state) {
    if (state.isLoading && state.valuations.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (state.error != null) {
      return _buildErrorState(state.error!);
    }

    if (state.valuations.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      backgroundColor: AppColors.darkSurface,
      color: AppColors.primary,
      onRefresh: () async => _refreshValuations(),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 100,
          top: 12,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: state.valuations.length + (state.isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.valuations.length) {
            return const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }

          final valuation = state.valuations[index];
          return _ValuationCard(
            valuation: valuation,
            onTap: () => _navigateToValuationDetail(valuation),
            onProcess: valuation.status == ValuationStatus.PENDING
                ? () => _processValuation(valuation.id)
                : null,
          ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.05);
        },
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.bolt_rounded,
            color: Colors.redAccent,
            size: 48,
          ).animate(onPlay: (c) => c.repeat()).shake(),
          const SizedBox(height: 16),
          Text(
            'mobile.ai.valuation.error'.tr(namedArgs: {'error': error}),
            style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: _refreshValuations,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'mobile.ai.valuation.retry'.tr(),
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.query_stats_rounded,
            color: Colors.white10,
            size: 80,
          ).animate().rotate(duration: 2.seconds),
          SizedBox(height: 24),
          Text(
            'mobile.ai.valuation.noValuations'.tr(),
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'mobile.ai.valuation.initiateDesc'.tr(),
            style: GoogleFonts.outfit(color: Colors.white24, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _navigateToCreateValuation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PropertyValuationCreatePage(),
      ),
    );
  }

  void _navigateToValuationDetail(PropertyValuation valuation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyValuationDetailPage(valuation: valuation),
      ),
    );
  }

  void _processValuation(String id) async {
    await ref
        .read(propertyValuationNotifierProvider.notifier)
        .processValuation(id);
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 14),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.outfit(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.outfit(
              color: Colors.white38,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ValuationCard extends StatelessWidget {
  final PropertyValuation valuation;
  final VoidCallback onTap;
  final VoidCallback? onProcess;

  const _ValuationCard({
    required this.valuation,
    required this.onTap,
    this.onProcess,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(valuation.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    _getStatusIcon(valuation.status),
                    color: statusColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        valuation.property?.name ?? 'mobile.ai.valuation.neuralProperty'.tr(),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              valuation.valuationType.name,
                              style: GoogleFonts.outfit(
                                color: Colors.white54,
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: statusColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            valuation.status.name.toUpperCase(),
                            style: GoogleFonts.outfit(
                              color: statusColor,
                              fontSize: 8,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (valuation.value != null)
                      Text(
                        '\$${(valuation.value! / 1000).toStringAsFixed(1)}K',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    else
                      const Icon(
                        Icons.query_stats_rounded,
                        color: Colors.white24,
                        size: 24,
                      ).animate(onPlay: (c) => c.repeat()).shimmer(),
                    const SizedBox(height: 4),
                    Text(
                      valuation.valuationDate.toString().split(' ')[0],
                      style: GoogleFonts.outfit(
                        color: Colors.white24,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ValuationStatus status) {
    switch (status) {
      case ValuationStatus.COMPLETED:
        return Colors.green;
      case ValuationStatus.PENDING:
        return Colors.orange;
      case ValuationStatus.PROCESSING:
        return Colors.blue;
      case ValuationStatus.FAILED:
        return Colors.redAccent;
      case ValuationStatus.EXPIRED:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(ValuationStatus status) {
    switch (status) {
      case ValuationStatus.COMPLETED:
        return Icons.verified_rounded;
      case ValuationStatus.PENDING:
        return Icons.unfold_more_double_rounded;
      case ValuationStatus.PROCESSING:
        return Icons.radar_rounded;
      case ValuationStatus.FAILED:
        return Icons.warning_amber_rounded;
      case ValuationStatus.EXPIRED:
        return Icons.history_rounded;
    }
  }
}

// Placeholder pages (Details & Form can be enhanced in next steps)
class PropertyValuationCreatePage extends StatelessWidget {
  const PropertyValuationCreatePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'mobile.ai.valuation.newValuation'.tr(),
          style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w900),
        ),
      ),
      body: Center(
        child: Text(
          'mobile.ai.valuation.auditComingSoon'.tr(),
          style: GoogleFonts.outfit(color: Colors.white24, letterSpacing: 2),
        ),
      ),
    );
  }
}

class PropertyValuationDetailPage extends StatelessWidget {
  final PropertyValuation valuation;
  const PropertyValuationDetailPage({super.key, required this.valuation});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'mobile.ai.valuation.detailsTitle'.tr(),
          style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w900),
        ),
      ),
      body: Center(
        child: Text(
          'mobile.ai.valuation.telemetryComingSoon'.tr(namedArgs: {'id': valuation.id}),
          style: GoogleFonts.outfit(color: Colors.white24, letterSpacing: 2),
        ),
      ),
    );
  }
}
