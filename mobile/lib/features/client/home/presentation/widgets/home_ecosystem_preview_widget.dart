import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class HomeEcosystemPreviewWidget extends StatefulWidget {
  const HomeEcosystemPreviewWidget({super.key});

  @override
  State<HomeEcosystemPreviewWidget> createState() => _HomeEcosystemPreviewWidgetState();
}

class _HomeEcosystemPreviewWidgetState extends State<HomeEcosystemPreviewWidget> {
  int _activeTab = 0;

  final List<Map<String, dynamic>> _vibes = [
    {'icon': '🏖️', 'name': 'Beachfront', 'count': '1,204'},
    {'icon': '🏔️', 'name': 'Mountains', 'count': '853'},
    {'icon': '🏛️', 'name': 'Mansions', 'count': '432'},
    {'icon': '🏙️', 'name': 'Penthouses', 'count': '921'},
    {'icon': '🌲', 'name': 'Cabins', 'count': '3,105'},
    {'icon': '🏰', 'name': 'Castles', 'count': '89'},
    {'icon': '🏝️', 'name': 'Islands', 'count': '42'},
    {'icon': '📐', 'name': 'Modern', 'count': '5,602'},
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title & Vibes Category Selector
            Text(
              'ecosystem.popular_lifestyles'.tr(defaultValue: 'Popular Lifestyles (Vibes)'),
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 44,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _vibes.length,
                itemBuilder: (context, index) {
                  final vibe = _vibes[index];
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.darkCard.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.darkBorder),
                    ),
                    child: Row(
                      children: [
                        Text(vibe['icon'], style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Text(
                          vibe['name'],
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            vibe['count'],
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: (index * 40).ms);
                },
              ),
            ),

            const SizedBox(height: 24),

            // Ecosystem Showcase Box (Matched to HomeContent.tsx EcosystemPreview)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.darkCard.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Tab Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTabButton(0, 'ecosystem.agent_os'.tr(defaultValue: 'Agent OS'), Icons.monitor_outlined),
                      _buildTabButton(1, 'ecosystem.fintech_zero'.tr(defaultValue: 'FinTech (0%)'), Icons.shield_outlined),
                      _buildTabButton(2, 'ecosystem.ai_studio'.tr(defaultValue: 'AI Studio'), Icons.auto_awesome_outlined),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Dynamic Content Panel
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildTabContent(_activeTab),
                  ),

                  const SizedBox(height: 18),

                  // Global System Status Footer (Matched to web status bar)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                              ),
                            ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1.5.seconds, color: Colors.white),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ecosystem.os_system_status'.tr(defaultValue: 'Global System Status'),
                                  style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark),
                                ),
                                Text(
                                  'ecosystem.all_systems_operational'.tr(defaultValue: 'All Modules Active & Operational'),
                                  style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.success),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Icon(Icons.bolt, color: AppColors.success, size: 22),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String label, IconData icon) {
    final isSelected = _activeTab == index;
    return InkWell(
      onTap: () => setState(() => _activeTab = index),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryLight : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.white : AppColors.textSecondaryDark),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.textSecondaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return Column(
          key: const ValueKey(0),
          children: [
            _buildMetricTile('ecosystem.commission_split'.tr(defaultValue: 'Commission Share (You/Office)'), '%70 / %30', Icons.pie_chart_outline, AppColors.primaryLight),
            const SizedBox(height: 10),
            _buildMetricTile('ecosystem.network_passive'.tr(defaultValue: 'Network Referral Passive Income'), '\$12,450 / ay', Icons.insights_outlined, AppColors.success),
          ],
        );
      case 1:
        return Column(
          key: const ValueKey(1),
          children: [
            _buildMetricTile('ecosystem.zero_commission'.tr(defaultValue: 'Zero Commission (Open Banking)'), 'ecosystem.a2a_transfer'.tr(defaultValue: 'A2A Transfer'), Icons.account_balance_outlined, AppColors.info),
            const SizedBox(height: 10),
            _buildMetricTile('ecosystem.escrow_time'.tr(defaultValue: 'Escrow Payment Time'), 'ecosystem.days'.tr(defaultValue: '15-21 Days'), Icons.verified_user_outlined, AppColors.warning),
          ],
        );
      case 2:
      default:
        return Column(
          key: const ValueKey(2),
          children: [
            _buildMetricTile('ecosystem.ai_matching'.tr(defaultValue: 'AI Listing Match'), 'ecosystem.active'.tr(defaultValue: 'Active'), Icons.auto_awesome, AppColors.success),
            const SizedBox(height: 10),
            _buildMetricTile('ecosystem.rag_search'.tr(defaultValue: 'RAG Semantic Doc Search'), 'ecosystem.gemini_powered'.tr(defaultValue: 'Gemini Powered'), Icons.travel_explore_outlined, const Color(0xFF8B5CF6)),
          ],
        );
    }
  }

  Widget _buildMetricTile(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkSurface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.outfit(fontSize: 13, color: AppColors.textSecondaryDark),
              ),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.outfit(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
