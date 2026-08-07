import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GMSITaxReportScreen extends ConsumerStatefulWidget {
  const GMSITaxReportScreen({super.key});

  @override
  ConsumerState<GMSITaxReportScreen> createState() => _GMSITaxReportScreenState();
}

class _GMSITaxReportScreenState extends ConsumerState<GMSITaxReportScreen> {
  static const _summary = {
    'totalGrossRentCollected': 420000,
    'annualExemption': 33000,
    'deductibleExpenses': 14700,
    'netTaxableBase': 372300,
    'estimatedTaxDuty': 61845,
  };

  static const _monthly = <({String month, int gross, int fee, int netPay, String invoiceNo})>[
    (month: '2026-01', gross: 35000, fee: 1225, netPay: 33775, invoiceNo: 'RSV2026000001'),
    (month: '2026-02', gross: 35000, fee: 1225, netPay: 33775, invoiceNo: 'RSV2026000002'),
    (month: '2026-03', gross: 35000, fee: 1225, netPay: 33775, invoiceNo: 'RSV2026000003'),
    (month: '2026-04', gross: 35000, fee: 1225, netPay: 33775, invoiceNo: 'RSV2026000004'),
  ];

  String _format(num value) {
    return value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
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
                        'GMSİ Tax Report',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Gayrimenkul Sermaye İratı yıl sonu vergi beyannamesi',
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
                _buildHeader(),
                const SizedBox(height: 16),
                _buildSummaryGrid(),
                const SizedBox(height: 20),
                _sectionHeader('Aylık Kira & Komisyon Dökümü', Icons.receipt_long_outlined, AppColors.info),
                const SizedBox(height: 12),
                ..._buildMonthlyRows(),
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
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildHeader() {
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('GİB Entegre', style: GoogleFonts.outfit(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.info)),
              ),
              const SizedBox(width: 8),
              Text('Gelir İdaresi Başkanlığı Uyumlu', style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GMSİ Yıl Sonu Vergi Beyanname Modülü',
                      style: GoogleFonts.outfit(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Ev sahibi: Ahmet Yılmaz · TCKN: 12345678901\nVergi Dairesi: Zincirlikuyu',
                      style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark, height: 1.5),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('GİB Hazır Beyanname Formatlı XML İndirildi!', style: GoogleFonts.outfit(fontSize: 12))),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.info,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.download, size: 16),
                label: Text('XML', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryGrid() {
    final boxes = [
      ('Brüt Kira Tahsilatı', _format(_summary['totalGrossRentCollected']!), 'TL', AppColors.info),
      ('Mesken İstisnası (2026)', '-${_format(_summary['annualExemption']!)}', 'TL', AppColors.success),
      ('Düşülebilir Komisyon', '-${_format(_summary['deductibleExpenses']!)}', 'TL', AppColors.success),
      ('Tahmini Vergi Matrahı', _format(_summary['netTaxableBase']!), 'TL', AppColors.primaryLight),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.7,
      ),
      itemCount: boxes.length,
      itemBuilder: (context, index) {
        final (label, value, suffix, color) = boxes[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.outfit(fontSize: 10, color: AppColors.textSecondaryDark)),
              const Spacer(),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w800, color: color),
                ),
              ),
              Text('$suffix', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.textSecondaryDark)),
            ],
          ),
        ).animate().fadeIn(delay: (index * 60).ms).slideY(begin: 0.05, end: 0);
      },
    );
  }

  List<Widget> _buildMonthlyRows() {
    return _monthly.map((row) {
      final (:month, :gross, :fee, :netPay, :invoiceNo) = row;
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
            Container(
              width: 44,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(month.split('-').last, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.info)),
                  Text(month.split('-').first, style: GoogleFonts.outfit(fontSize: 9, color: AppColors.textSecondaryDark)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Brüt: ${_format(gross)} TL', style: GoogleFonts.outfit(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text('Komisyon (%3.5): -${_format(fee)} TL', style: GoogleFonts.outfit(fontSize: 11, color: AppColors.success)),
                  const SizedBox(height: 4),
                  Text('Net: ${_format(netPay)} TL · $invoiceNo', style: GoogleFonts.jetBrainsMono(fontSize: 10, color: AppColors.textSecondaryDark)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
