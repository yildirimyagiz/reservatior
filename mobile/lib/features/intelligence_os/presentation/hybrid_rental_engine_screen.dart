import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HybridRentalEngineScreen extends ConsumerStatefulWidget {
  const HybridRentalEngineScreen({super.key});

  @override
  ConsumerState<HybridRentalEngineScreen> createState() => _HybridRentalEngineScreenState();
}

class _HybridRentalEngineScreenState extends ConsumerState<HybridRentalEngineScreen> {
  static const _escrowConfig = <String, double>{
    'blockageDays': 60,
    'agentPayoutRate': 0.10,
    'reservatiorFeeRate': 0.05,
    'upfrontPercent': 0.45,
  };

  final _priceController = TextEditingController(text: '9500');
  double _price = 9500;

  static const _commissionTiers = <({double min, double max, double payout, double fee, double escrow})>[
    (min: 0, max: 10000, payout: 0.10, fee: 0.05, escrow: 0.15),
    (min: 10000, max: 25000, payout: 0.12, fee: 0.06, escrow: 0.20),
    (min: 25000, max: 1000000, payout: 0.15, fee: 0.08, escrow: 0.25),
  ];

  double get _payoutRate => _commissionTiers.firstWhere((t) => _price >= t.min && _price < t.max).payout;
  double get _feeRate => _commissionTiers.firstWhere((t) => _price >= t.min && _price < t.max).fee;
  double get _escrowRate => _commissionTiers.firstWhere((t) => _price >= t.min && _price < t.max).escrow;

  String _fmt(num v) => v.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
  String _fmtPct(double v) => '${(v * 100).toStringAsFixed(1)}%';

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final payout = _price * _payoutRate;
    final fee = _price * _feeRate;
    final escrow = _price * _escrowRate;
    final upfront = escrow * _escrowConfig['upfrontPercent']!;

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
                        'Hybrid Rental Engine',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Komisyon motoru, escrow & revenue split hesaplayıcı',
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
                _buildPriceInput(),
                const SizedBox(height: 16),
                _buildSplitCard(payout, fee, escrow, upfront),
                const SizedBox(height: 20),
                _sectionHeader('Tier Yapılandırması', Icons.table_chart_outlined, AppColors.primaryLight),
                const SizedBox(height: 12),
                ..._buildTiers(),
                const SizedBox(height: 20),
                _sectionHeader('Escrow Yapılandırması (Prisma)', Icons.verified_user_outlined, AppColors.info),
                const SizedBox(height: 12),
                _buildEscrowCard(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(title, style: GoogleFonts.outfit(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white)),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildPriceInput() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Aylık Kira (Brüt)', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Kira tutarı',
                    hintStyle: GoogleFonts.outfit(fontSize: 16, color: AppColors.textSecondaryDark),
                    prefixText: '₺ ',
                    prefixStyle: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primaryLight),
                    enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.darkBorder)),
                    focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
                  ),
                  onChanged: (v) => setState(() => _price = double.tryParse(v) ?? 0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Slider(
            value: _price.clamp(1000, 50000).toDouble(),
            min: 1000,
            max: 50000,
            divisions: 49,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.darkBorder,
            label: _fmt(_price),
            onChanged: (v) {
              setState(() {
                _price = v.roundToDouble();
                _priceController.text = _price.toInt().toString();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSplitCard(double payout, double fee, double escrow, double upfront) {
    final rows = [
      ('Partner Ödemesi', payout, '${_fmtPct(_payoutRate)}', AppColors.primaryLight),
      ('Reservatior Komisyonu', fee, '${_fmtPct(_feeRate)}', AppColors.warning),
      ('Escrow Blockage', escrow, '${_fmtPct(_escrowRate)}', AppColors.info),
      ('Ev Sahibi Upfront Avans', upfront, '45.0%', AppColors.success),
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: rows.map((r) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Container(width: 8, height: 8, decoration: BoxDecoration(color: r.$4, shape: BoxShape.circle)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(r.$1, style: GoogleFonts.outfit(fontSize: 13, color: Colors.white)),
                ),
                Text('${r.$3} · ₺${_fmt(r.$2)}', style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.w800, color: r.$4)),
              ],
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  List<Widget> _buildTiers() {
    return _commissionTiers.map((tier) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.darkCard.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _price >= tier.min && _price < tier.max ? AppColors.primary : AppColors.darkBorder,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '₺${_fmt(tier.min)}-${_fmt(tier.max)}',
                style: GoogleFonts.outfit(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.primaryLight),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Partner %${(tier.payout * 100).toStringAsFixed(0)} · Fee %${(tier.fee * 100).toStringAsFixed(0)} · Escrow %${(tier.escrow * 100).toStringAsFixed(0)}',
                style: GoogleFonts.outfit(fontSize: 12, color: AppColors.textSecondaryDark),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildEscrowCard() {
    final items = [
      ('blockageDays', '${_escrowConfig['blockageDays']!.toInt()} gün', 'Kira blokaj süresi'),
      ('agentPayoutRate', _fmtPct(_escrowConfig['agentPayoutRate']!), 'Acente komisyon oranı'),
      ('reservatiorFeeRate', _fmtPct(_escrowConfig['reservatiorFeeRate']!), 'Platform hizmet bedeli'),
      ('upfrontPercent', _fmtPct(_escrowConfig['upfrontPercent']!), 'Blokaj ön ödemesi'),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: Text(item.$1, style: GoogleFonts.jetBrainsMono(fontSize: 12, color: AppColors.textSecondaryDark)),
                ),
                Text(item.$2, style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.info)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
