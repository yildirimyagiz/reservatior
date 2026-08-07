import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HybridRentalOSModuleScreen extends ConsumerStatefulWidget {
  const HybridRentalOSModuleScreen({super.key});

  @override
  ConsumerState<HybridRentalOSModuleScreen> createState() => _HybridRentalOSModuleScreenState();
}

class _HybridRentalOSModuleScreenState extends ConsumerState<HybridRentalOSModuleScreen> {
  int _activeTab = 1;
  bool _sagaRunning = false;
  int _currentStep = 0;
  List<String> _sagaLog = [];

  static const _sagaSteps = [
    ('PropertySubmitted', 'Mülk Başvurusu Alındı', 'ListingOS'),
    ('PropertyIntelligenceAnalysis', 'AI Fiziksel & Bölge Analizi', 'AI-OS'),
    ('AIScoreGenerated', '0-100 Skor Matrisi Üretildi', 'AI-OS'),
    ('LegalComplianceCheck', '7464 Mevzuat & Kat Malikleri Kontrolü', 'GovernanceOS'),
    ('RentalModelDecision', 'Revenue Share / Master Lease Kararı', 'HybridRentalOS'),
    ('PartnerAttribution', 'Partner Ataması & Tier Matrisi', 'PartnerOS'),
    ('RevenueSimulation', 'Çift Taraflı P&L Projeksiyonu', 'FinanceOS'),
    ('OwnerProposalGenerated', 'AI Ev Sahibi Teklif Paketi', 'AI-OS'),
    ('OwnerAcceptedOffer', 'Ev Sahibi Teklif Onayı', 'UserOS'),
    ('HybridContractCreated', 'E-Devlet Sözleşme & Teminat', 'ListingOS'),
    ('PropertyOperationActivated', 'Operasyon & Kanal Aktivasyonu', 'OperationsOS'),
    ('PartnerRevenueAccrued', 'Komisyon Dağıtımı & Hakediş', 'FinanceOS'),
  ];

  Future<void> _runSaga() async {
    setState(() {
      _sagaRunning = true;
      _currentStep = 0;
      _sagaLog = ['[SagaOrchestrator] Starting HybridRentalOnboardingSaga...'];
    });
    for (var i = 0; i < _sagaSteps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 350));
      if (!mounted) return;
      setState(() {
        _currentStep = i + 1;
        _sagaLog = [
          ..._sagaLog,
          '[${_sagaSteps[i].$3}] Event emitted: ${_sagaSteps[i].$1} -> ${_sagaSteps[i].$2}',
        ];
      });
    }
    setState(() => _sagaRunning = false);
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
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hybrid Rental & Revenue OS',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Acquisition engine, multi-agent swarm & DAG revenue pipeline',
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
      ('Acquisition', Icons.track_changes_outlined),
      ('Intelligence', Icons.psychology_outlined),
      ('Revenue DAG', Icons.account_tree_outlined),
    ];
    return Row(
      children: List.generate(tabs.length, (i) {
        final isSelected = _activeTab == i;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _activeTab = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.darkCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? AppColors.primaryLight : AppColors.darkBorder,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(tabs[i].$2, size: 16, color: isSelected ? Colors.white : AppColors.textSecondaryDark),
                  const SizedBox(width: 6),
                  Text(
                    tabs[i].$1,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textSecondaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildTabContent() {
    switch (_activeTab) {
      case 0:
        return _buildAcquisition();
      case 1:
        return _buildIntelligence();
      default:
        return _buildRevenueDag();
    }
  }

  Widget _buildAcquisition() {
    return Column(
      key: const ValueKey('acquisition'),
      children: [
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.track_changes_outlined, color: AppColors.primaryLight, size: 20),
                  const SizedBox(width: 8),
                  Text('AI Mülk Keşfi & Ev Sahibi Erişim Hedefleri', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 6),
              Text('Piyasadan otomatik taranan yüksek potansiyelli mülkler ve AI iletişim kanalları', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _acquisitionTarget('Cihangir 2+1', 'Beyoğlu', '\$1.2K', '\$2.4K', '+18%'),
        _acquisitionTarget('Kadıköy Moda 1+1', 'Kadıköy', '\$980', '\$1.9K', '+22%'),
        _acquisitionTarget('Beşiktaş 3+1', 'Beşiktaş', '\$1.8K', '\$3.1K', '+15%'),
      ],
    );
  }

  Widget _acquisitionTarget(String name, String area, String classic, String hybrid, String lift) {
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                Text(area, style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
                const SizedBox(height: 6),
                Text('Klasik Kira: $classic', style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
                Text('Hybrid Ciro: $hybrid', style: GoogleFonts.outfit(fontSize: 10, color: AppColors.success)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(lift, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.success)),
          ),
        ],
      ),
    );
  }

  Widget _buildIntelligence() {
    return Column(
      key: const ValueKey('intelligence'),
      children: [
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.account_tree_outlined, color: AppColors.primaryLight, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'HybridRentalOnboardingSaga Orkestrasyonu',
                      style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _sagaRunning ? null : _runSaga,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(_sagaRunning ? '...' : 'Run Saga', style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text('12 adımlı yaşam döngüsü ve geri alma (compensation)', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Column(
          children: List.generate(_sagaSteps.length, (i) {
            final step = _sagaSteps[i];
            final isDone = _currentStep > i;
            final isActive = _currentStep == i + 1;
            final color = isDone ? AppColors.success : isActive ? AppColors.primaryLight : AppColors.textSecondaryDark;
            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: isActive ? 0.12 : 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withValues(alpha: isActive ? 0.5 : 0.15)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDone ? AppColors.success.withValues(alpha: 0.2) : color.withValues(alpha: 0.15),
                    ),
                    child: Center(
                      child: isDone
                          ? const Icon(Icons.check, size: 14, color: AppColors.success)
                          : Text('${i + 1}', style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w800, color: color)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(step.$1, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                        Text(step.$2, style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
                      ],
                    ),
                  ),
                  Text(step.$3, style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.primaryLight)),
                ],
              ),
            );
          }),
        ),
        if (_sagaLog.isNotEmpty) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.darkBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _sagaLog.reversed.take(6).map((line) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    line,
                    style: GoogleFonts.jetBrainsMono(fontSize: 9, color: line.startsWith('[SagaOrchestrator]') ? AppColors.primaryLight : AppColors.success, height: 1.5),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRevenueDag() {
    return Column(
      key: const ValueKey('revenue_dag'),
      children: [
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.account_tree_outlined, color: AppColors.warning, size: 22),
              const SizedBox(height: 10),
              Text('Gelir DAG Motoru', style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
              const SizedBox(height: 6),
              Text('Gross revenue 118.000 TL üzerinde dağıtım simülasyonu', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
              const SizedBox(height: 14),
              _dagRow('Gross Revenue', '118.000 TL', AppColors.info),
              _dagRow('Owner Payout', '64.900 TL (%55)', AppColors.success),
              _dagRow('Partner Commission', '11.800 TL (%10)', AppColors.primaryLight),
              _dagRow('Reservatior Fee', '5.900 TL (%5)', AppColors.warning),
              _dagRow('Escrow Blockage', '18.900 TL (%16)', AppColors.info),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dagRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondaryDark))),
          Text(value, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
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
