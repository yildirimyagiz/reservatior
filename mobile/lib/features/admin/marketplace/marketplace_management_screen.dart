import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:get_it/get_it.dart';

class MarketplaceManagementScreen extends StatefulWidget {
  const MarketplaceManagementScreen({super.key});

  @override
  State<MarketplaceManagementScreen> createState() => _MarketplaceManagementScreenState();
}

class _MarketplaceManagementScreenState extends State<MarketplaceManagementScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _dashboardData;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchDashboard();
  }

  Future<void> _fetchDashboard() async {
    try {
      final dio = GetIt.I<DioClient>().dio;
      final response = await dio.get('/marketplace/dashboard');
      if (response.data['success'] == true) {
        setState(() {
          _dashboardData = response.data['data'];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.darkBg.withValues(alpha: 0.8),
            flexibleSpace: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 20),
                  title: Text(
                    'mobile.admin.marketplace.title'.tr(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    if (_error != null) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            'Failed to load dashboard: $_error',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      );
    }

    final trustScores = _dashboardData?['trustScores'] as List<dynamic>? ?? [];
    final failovers = _dashboardData?['failovers'] as List<dynamic>? ?? [];

    return SliverList(
      delegate: SliverChildListDelegate([
        _buildStatCard(
          icon: Icons.shield_rounded,
          title: 'Trust Governance',
          value: '${trustScores.length} Properties Analyzed',
          color: Colors.blueAccent,
        ),
        const SizedBox(height: 16),
        _buildStatCard(
          icon: Icons.alt_route_rounded,
          title: 'Automated Failovers',
          value: '${failovers.length} Rerouted Recently',
          color: Colors.orangeAccent,
        ),
        const SizedBox(height: 32),
        Text(
          'Recent Trust Scores',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ...trustScores.map((score) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      score['property']?['name'] ?? score['propertyId'] ?? 'Unknown Property',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'KyC: ${score['kycVerified'] == true ? 'Verified' : 'Pending'}',
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: (score['overallScore'] ?? 0) >= 80 ? Colors.green.withOpacity(0.2) : Colors.yellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${score['overallScore']}',
                  style: TextStyle(
                    color: (score['overallScore'] ?? 0) >= 80 ? Colors.green : Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        )).toList(),
      ]),
    );
  }

  Widget _buildStatCard({required IconData icon, required String title, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
