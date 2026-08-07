import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/investment/domain/investment_engine.dart';

class RoiCalculatorScreen extends StatefulWidget {
  const RoiCalculatorScreen({super.key});

  @override
  State<RoiCalculatorScreen> createState() => _RoiCalculatorScreenState();
}

class _RoiCalculatorScreenState extends State<RoiCalculatorScreen> {
  final _priceCtrl = TextEditingController(text: '500000');
  final _rentCtrl = TextEditingController(text: '2800');
  final _downCtrl = TextEditingController(text: '25');
  final _rateCtrl = TextEditingController(text: '5.5');
  final _yearsCtrl = TextEditingController(text: '5');
  final _vacancyCtrl = TextEditingController(text: '8');
  final _appreciationCtrl = TextEditingController(text: '5');

  RoiOutput? _result;
  bool _calculating = false;

  @override
  void dispose() {
    _priceCtrl.dispose();
    _rentCtrl.dispose();
    _downCtrl.dispose();
    _rateCtrl.dispose();
    _yearsCtrl.dispose();
    _vacancyCtrl.dispose();
    _appreciationCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    setState(() => _calculating = true);
    final input = RoiInput(
      purchasePrice: double.tryParse(_priceCtrl.text) ?? 0,
      monthlyRent: double.tryParse(_rentCtrl.text) ?? 0,
      downPaymentPercent: double.tryParse(_downCtrl.text) ?? 25,
      interestRate: double.tryParse(_rateCtrl.text) ?? 5.5,
      holdingPeriodYears: int.tryParse(_yearsCtrl.text) ?? 5,
      vacancyRate: double.tryParse(_vacancyCtrl.text) ?? 8,
      appreciationRate: double.tryParse(_appreciationCtrl.text) ?? 5,
    );
    final out = InvestmentEngine.calculateROI(input);
    setState(() {
      _result = out;
      _calculating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            title: Text(
              'ROI Calculator',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  'Estimate total return, yield and cash flow — client-seo parity.',
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 20),
                _numField(_priceCtrl, 'Purchase price'),
                _numField(_rentCtrl, 'Monthly rent'),
                Row(
                  children: [
                    Expanded(child: _numField(_downCtrl, 'Down payment %')),
                    const SizedBox(width: 12),
                    Expanded(child: _numField(_rateCtrl, 'Interest %')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _numField(_yearsCtrl, 'Hold years')),
                    const SizedBox(width: 12),
                    Expanded(child: _numField(_vacancyCtrl, 'Vacancy %')),
                  ],
                ),
                _numField(_appreciationCtrl, 'Appreciation % / yr'),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _calculating ? null : _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Calculate ROI',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                if (_result != null) ...[
                  const SizedBox(height: 24),
                  _MetricsGrid(result: _result!).animate().fadeIn(),
                ],
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _numField(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: GoogleFonts.outfit(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.outfit(color: Colors.white54),
          filled: true,
          fillColor: AppColors.darkCard,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.darkBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.darkBorder),
          ),
        ),
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  final RoiOutput result;
  const _MetricsGrid({required this.result});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Total ROI', '${result.totalROI.toStringAsFixed(1)}%'),
      ('Annual ROI', '${result.annualROI.toStringAsFixed(1)}%'),
      ('Gross yield', '${result.grossRentalYield.toStringAsFixed(2)}%'),
      ('Net yield', '${result.netRentalYield.toStringAsFixed(2)}%'),
      ('Cap rate', '${result.capRate.toStringAsFixed(2)}%'),
      ('Monthly CF', NumberFormat.compact().format(result.monthlyCashFlow)),
      ('Final value', NumberFormat.compact().format(result.finalPropertyValue)),
      ('Risk', result.riskScore.toStringAsFixed(0)),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.6,
      children: items
          .map(
            (e) => Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.darkBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    e.$1,
                    style: GoogleFonts.outfit(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    e.$2,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
