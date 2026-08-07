import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GlobalHybridRentalOSScreen extends ConsumerStatefulWidget {
  const GlobalHybridRentalOSScreen({super.key});

  @override
  ConsumerState<GlobalHybridRentalOSScreen> createState() => _GlobalHybridRentalOSScreenState();
}

class _GlobalHybridRentalOSScreenState extends ConsumerState<GlobalHybridRentalOSScreen> {
  int _activeTab = 0;

  static const _countries = <({
    String flag,
    String name,
    String status,
    int properties,
    int pipeline,
    String aar,
    Color color,
  })>[
    (flag: '🇹🇷', name: 'Türkiye', status: 'Operasyonel', properties: 248, pipeline: 420, aar: '18.4%', color: AppColors.success),
    (flag: '🇦🇪', name: 'UAE', status: 'Live (Beta)', properties: 62, pipeline: 110, aar: '24.1%', color: AppColors.primaryLight),
    (flag: '🇪🇸', name: 'Spain', status: 'Pilot', properties: 18, pipeline: 40, aar: '12.9%', color: AppColors.warning),
    (flag: '🇬🇷', name: 'Greece', status: 'Pilot', properties: 9, pipeline: 25, aar: '9.6%', color: AppColors.warning),
    (flag: '🇲🇽', name: 'Mexico', status: 'Değerlendirme', properties: 0, pipeline: 12, aar: '-', color: AppColors.textSecondaryDark),
  ];

  static const _evalScores = <({String field, int score})>[
    (field: 'Turizm Talep Endeksi', score: 86),
    (field: 'Kısa Dönem Kira Düzenlemesi', score: 72),
    (field: 'Ortalama Günlük Ücret (ADR)', score: 91),
    (field: 'Vergi & Lisans Karmaşıklığı', score: 64),
    (field: 'Operasyon Maliyeti', score: 77),
  ];

  static const _revenueRows = <({String label, String value, Color color})>[
    (label: 'Gross Revenue (12 ay)', value: '₺41.2M', color: AppColors.info),
    (label: 'Net Operating Income', value: '₺9.8M', color: AppColors.success),
    (label: 'Owner Payout', value: '₺27.5M', color: AppColors.primaryLight),
    (label: 'Platform Fee', value: '₺3.1M', color: AppColors.warning),
    (label: 'ARPU (mülk başına)', value: '₺12.4K', color: AppColors.success),
  ];

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
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Global Hybrid Rental OS',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Ülke genişletme, DAG değerlendirme & portföy simülasyonu',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildTabBar(),
                const SizedBox(height: 16),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _buildTabContent(),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    const tabs = [
      ('Countries', Icons.public_outlined),
      ('Eval', Icons.assessment_outlined),
      ('Revenue', Icons.pie_chart_outline),
      ('DAG', Icons.hub_outlined),
      ('Saga', Icons.play_circle_outline),
    ];
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(tabs.length, (i) {
          final isSelected = _activeTab == i;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _activeTab = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.darkCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? AppColors.primaryLight : AppColors.darkBorder),
                ),
                child: Row(
                  children: [
                    Icon(tabs[i].$2, size: 14, color: isSelected ? Colors.white : AppColors.textSecondaryDark),
                    const SizedBox(width: 6),
                    Text(tabs[i].$1, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w800, color: isSelected ? Colors.white : AppColors.textSecondaryDark)),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildTabContent() {
    switch (_activeTab) {
      case 0:
        return _buildCountries();
      case 1:
        return _buildEval();
      case 2:
        return _buildRevenue();
      case 3:
        return _buildDag();
      default:
        return _buildSaga();
    }
  }

  Widget _buildCountries() {
    return Column(
      key: const ValueKey('countries'),
      children: _countries.map((c) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.darkCard.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: Row(
            children: [
              Text(c.flag, style: const TextStyle(fontSize: 26)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c.name, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(
                      '${c.properties} aktif · ${c.pipeline} pipeline · AAR ${c.aar}',
                      style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: c.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(c.status, style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w800, color: c.color)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEval() {
    return Column(
      key: const ValueKey('eval'),
      children: [
        _card(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ülke Değerlendirme Skoru', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                  Text('86/100', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.success)),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: 0.86,
                  minHeight: 8,
                  backgroundColor: AppColors.darkBorder,
                  valueColor: const AlwaysStoppedAnimation(AppColors.success),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ..._evalScores.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(e.field, style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondaryDark)),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: e.score / 100,
                      minHeight: 6,
                      backgroundColor: AppColors.darkBorder,
                      valueColor: AlwaysStoppedAnimation(e.score >= 80 ? AppColors.success : AppColors.warning),
                    ),
                  ),
                ),
                SizedBox(width: 40, child: Text('${e.score}', textAlign: TextAlign.right, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white))),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildRevenue() {
    return Column(
      key: const ValueKey('revenue'),
      children: _revenueRows.map((r) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.darkCard.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: r.color, shape: BoxShape.circle)),
              const SizedBox(width: 12),
              Expanded(child: Text(r.label, style: GoogleFonts.outfit(fontSize: 13, color: Colors.white))),
              Text(r.value, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w800, color: r.color)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDag() {
    return Column(
      key: const ValueKey('dag'),
      children: [
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.hub_outlined, color: AppColors.primaryLight, size: 20),
                  const SizedBox(width: 8),
                  Text('Ülke Yayılım DAG Motoru', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 12),
              _dagNode('MarketScan', 'Piyasa talebi & regülasyon taraması', AppColors.info),
              _dagNode('FeasibilityAnalysis', 'Maliyet + ADR + doluluk fizibilitesi', AppColors.warning),
              _dagNode('LegalGateway', 'Lisansa bağlı kilit noktası', AppColors.success),
              _dagNode('OperationsOnboarding', 'Partner & mülk sahibi onboarding', AppColors.primaryLight),
              _dagNode('RevenueStreamActive', 'İlk gelir akışı aktivasyonu', AppColors.success),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dagNode(String title, String subtitle, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.2), shape: BoxShape.circle, border: Border.all(color: color)),
                child: const Icon(Icons.arrow_downward, size: 14, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                Text(subtitle, style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaga() {
    return Column(
      key: const ValueKey('saga'),
      children: [
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.play_circle_outline, color: AppColors.success, size: 20),
                  const SizedBox(width: 8),
                  Text('Cross-border Onboarding Saga', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 6),
              Text('TR → UAE genişlemesi için 8 adımlı saga simülasyonu', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'MarketScan', 'LocalPartner', 'LicenseCheck', 'VisaOps',
                  'ContractSign', 'EscrowSetup', 'FirstRevenue', 'Scale',
                ].map((s) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                    child: Text(s, style: GoogleFonts.jetBrainsMono(fontSize: 10, color: AppColors.primaryLight)),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: child,
    );
  }
}
