import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/investment/domain/investment_engine.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  int _tab = 0;

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
              'Investment Compare',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Properties'),
                    icon: Icon(Icons.compare_arrows),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Cities'),
                    icon: Icon(Icons.public),
                  ),
                ],
                selected: {_tab},
                onSelectionChanged: (s) => setState(() => _tab = s.first),
                style: SegmentedButton.styleFrom(
                  backgroundColor: AppColors.darkCard,
                  foregroundColor: Colors.white70,
                  selectedBackgroundColor: AppColors.primary,
                  selectedForegroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.darkBorder),
                ),
              ),
            ),
          ),
          if (_tab == 0)
            const SliverToBoxAdapter(child: _PropertyComparisonPanel())
          else
            const SliverToBoxAdapter(child: _CityComparisonPanel()),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class CompareProperty {
  final String id;
  final String name;
  final String city;
  final String? district;
  final double purchasePrice;
  final double monthlyRent;
  final double locationScore;
  final double liquidityScore;
  final double appreciationPotential;

  const CompareProperty({
    required this.id,
    required this.name,
    required this.city,
    this.district,
    required this.purchasePrice,
    required this.monthlyRent,
    this.locationScore = 70,
    this.liquidityScore = 70,
    this.appreciationPotential = 60,
  });

  double get grossYield => purchasePrice > 0
      ? ((monthlyRent * 12) / purchasePrice) * 100
      : 0;

  double get netYield => grossYield * 0.8;

  double get roi => InvestmentEngine.calculateROI(
        RoiInput(
          purchasePrice: purchasePrice,
          monthlyRent: monthlyRent,
          appreciationRate: appreciationPotential,
        ),
      ).totalROI;

  double get overallScore {
    final score = (locationScore + liquidityScore + appreciationPotential) / 3 +
        grossYield;
    return score.clamp(0, 100);
  }
}

class _PropertyComparisonPanel extends StatefulWidget {
  const _PropertyComparisonPanel();

  @override
  State<_PropertyComparisonPanel> createState() =>
      _PropertyComparisonPanelState();
}

class _PropertyComparisonPanelState extends State<_PropertyComparisonPanel> {
  final List<CompareProperty> _items = [
    const CompareProperty(
      id: '1',
      name: 'Marina Residence Tower 1',
      city: 'Dubai',
      district: 'Dubai Marina',
      purchasePrice: 1800000,
      monthlyRent: 11500,
      locationScore: 88,
      liquidityScore: 86,
      appreciationPotential: 82,
    ),
    const CompareProperty(
      id: '2',
      name: 'Kadikoy Moda Flat',
      city: 'Istanbul',
      district: 'Kadikoy',
      purchasePrice: 9000000,
      monthlyRent: 52000,
      locationScore: 82,
      liquidityScore: 70,
      appreciationPotential: 75,
    ),
  ];

  final _nameCtrl = TextEditingController();
  final _cityCtrl = TextEditingController(text: 'Dubai');
  final _districtCtrl = TextEditingController();
  final _priceCtrl = TextEditingController(text: '1500000');
  final _rentCtrl = TextEditingController(text: '9500');
  final _locCtrl = TextEditingController(text: '70');
  final _liqCtrl = TextEditingController(text: '70');
  final _apprCtrl = TextEditingController(text: '60');

  String _sortBy = 'overallScore';
  bool _sortDesc = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cityCtrl.dispose();
    _districtCtrl.dispose();
    _priceCtrl.dispose();
    _rentCtrl.dispose();
    _locCtrl.dispose();
    _liqCtrl.dispose();
    _apprCtrl.dispose();
    super.dispose();
  }

  void _add() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;
    final price = double.tryParse(_priceCtrl.text) ?? 0;
    final rent = double.tryParse(_rentCtrl.text) ?? 0;
    setState(() {
      _items.add(CompareProperty(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        city: _cityCtrl.text.trim().isEmpty ? 'Dubai' : _cityCtrl.text.trim(),
        district: _districtCtrl.text.trim().isEmpty
            ? null
            : _districtCtrl.text.trim(),
        purchasePrice: price,
        monthlyRent: rent,
        locationScore: (double.tryParse(_locCtrl.text) ?? 70).clamp(0, 100),
        liquidityScore: (double.tryParse(_liqCtrl.text) ?? 70).clamp(0, 100),
        appreciationPotential:
            (double.tryParse(_apprCtrl.text) ?? 60).clamp(0, 100),
      ));
    });
    Navigator.of(context).pop();
    _nameCtrl.clear();
  }

  double _valueOf(CompareProperty p, String field) => switch (field) {
        'purchasePrice' => p.purchasePrice,
        'grossYield' => p.grossYield,
        'netYield' => p.netYield,
        'roi' => p.roi,
        'locationScore' => p.locationScore,
        'liquidityScore' => p.liquidityScore,
        'appreciationPotential' => p.appreciationPotential,
        _ => p.overallScore,
      };

  void _sort(String field) {
    setState(() {
      if (_sortBy == field) {
        _sortDesc = !_sortDesc;
      } else {
        _sortBy = field;
        _sortDesc = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sorted = [..._items]..sort((a, b) {
        final av = _valueOf(a, _sortBy);
        final bv = _valueOf(b, _sortBy);
        return _sortDesc ? bv.compareTo(av) : av.compareTo(bv);
      });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Side-by-side yield, ROI, location and liquidity',
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
              ),
              TextButton.icon(
                onPressed: _showAddDialog,
                icon: const Icon(Icons.add, size: 18),
                label: Text('Add',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
              ),
              if (_items.isNotEmpty)
                TextButton.icon(
                  onPressed: () => setState(() => _items.clear()),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: Text('Clear',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          if (sorted.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 48),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.darkBorder),
              ),
              child: Column(
                children: [
                  Icon(Icons.compare_arrows,
                      color: Colors.white24, size: 48),
                  const SizedBox(height: 12),
                  Text('No properties to compare yet',
                      style: GoogleFonts.outfit(
                          color: Colors.white54,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('Add properties to see side-by-side comparison',
                      style: GoogleFonts.outfit(
                          color: Colors.white38, fontSize: 12)),
                ],
              ),
            )
          else
            Container(
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.darkBorder),
              ),
              clipBehavior: Clip.antiAlias,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildTable(sorted),
              ),
            ).animate().fadeIn(),
          const SizedBox(height: 16),
          Text(
            'Tap a column header to sort. Overall score blends location, liquidity, appreciation and yield.',
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(List<CompareProperty> items) {
    const fields = [
      ('purchasePrice', 'Price'),
      ('grossYield', 'Gross Y'),
      ('netYield', 'Net Y'),
      ('roi', 'ROI'),
      ('locationScore', 'Location'),
      ('liquidityScore', 'Liquidity'),
      ('appreciationPotential', 'Apprec.'),
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _headerCell('Property', () => _sort('name'), flex: 2),
                for (final (field, label) in fields)
                  _headerCell(
                    label,
                    () => _sort(field),
                    suffix: _sortBy == field
                        ? (_sortDesc ? ' ↓' : ' ↑')
                        : '',
                  ),
                const SizedBox(width: 24),
              ],
            ),
            const SizedBox(height: 4),
            for (var i = 0; i < items.length; i++) ...[
              Row(
                children: [
                  _nameCell(items[i], flex: 2),
                  _valueCell(
                    NumberFormat.compactCurrency(symbol: '')
                        .format(items[i].purchasePrice),
                    bold: true,
                  ),
                  _valueCell('${items[i].grossYield.toStringAsFixed(1)}%',
                      accent: AppColors.success),
                  _valueCell('${items[i].netYield.toStringAsFixed(1)}%'),
                  _valueCell('${items[i].roi.toStringAsFixed(0)}%'),
                  _valueCell(items[i].locationScore.toStringAsFixed(0)),
                  _valueCell(items[i].liquidityScore.toStringAsFixed(0)),
                  _valueCell(
                      '${items[i].appreciationPotential.toStringAsFixed(0)}%'),
                  IconButton(
                    onPressed: () =>
                        setState(() => _items.removeWhere((x) => x.id == items[i].id)),
                    icon: Icon(Icons.close,
                        size: 16, color: AppColors.error.withValues(alpha: 0.8)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 24),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              if (i < items.length - 1)
                const Divider(color: Colors.white10, height: 1),
            ],
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String label, VoidCallback onTap, {String suffix = '', int flex = 1}) {
    return SizedBox(
      width: 96,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            '$label$suffix',
            style: GoogleFonts.outfit(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameCell(CompareProperty p, {int flex = 1}) {
    return SizedBox(
      width: 190,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13)),
            const SizedBox(height: 2),
            Text(
              [p.district, p.city].whereType<String>().join(', '),
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _valueCell(String value, {bool bold = false, Color? accent}) {
    return SizedBox(
      width: 96,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        child: Text(
          value,
          style: GoogleFonts.outfit(
            color: accent ?? Colors.white70,
            fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  void _showAddDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkCard,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Property to Compare',
                  style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18)),
              const SizedBox(height: 16),
              _field(_nameCtrl, 'Property name'),
              Row(
                children: [
                  Expanded(child: _field(_cityCtrl, 'City')),
                  const SizedBox(width: 12),
                  Expanded(child: _field(_districtCtrl, 'District')),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: _field(_priceCtrl, 'Purchase price',
                          numeric: true)),
                  const SizedBox(width: 12),
                  Expanded(
                      child:
                          _field(_rentCtrl, 'Monthly rent', numeric: true)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: _field(_locCtrl, 'Location 0-100',
                          numeric: true)),
                  const SizedBox(width: 12),
                  Expanded(
                      child:
                          _field(_liqCtrl, 'Liquidity 0-100', numeric: true)),
                ],
              ),
              _field(_apprCtrl, 'Appreciation % / yr', numeric: true),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _add,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text('Add to comparison',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label, {bool numeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: numeric
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        style: GoogleFonts.outfit(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
          filled: true,
          fillColor: AppColors.darkBg,
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

class CityData {
  final String city;
  final String country;
  final String currency;
  final double grossYield;
  final double netYield;
  final double appreciation;
  final double totalReturn;
  final String riskLevel;
  final double liquidityScore;
  final bool investorFriendly;
  final double taxRate;
  final bool residencyByInvestment;

  const CityData({
    required this.city,
    required this.country,
    required this.currency,
    required this.grossYield,
    required this.netYield,
    required this.appreciation,
    required this.totalReturn,
    required this.riskLevel,
    required this.liquidityScore,
    required this.investorFriendly,
    required this.taxRate,
    required this.residencyByInvestment,
  });
}

const List<CityData> kCityComparisons = [
  CityData(city: 'Dubai', country: 'UAE', currency: 'AED', grossYield: 7.2, netYield: 5.8, appreciation: 8.5, totalReturn: 15.7, riskLevel: 'MEDIUM', liquidityScore: 82, investorFriendly: true, taxRate: 0, residencyByInvestment: true),
  CityData(city: 'Istanbul', country: 'Turkey', currency: 'TRY', grossYield: 6.5, netYield: 5.2, appreciation: 35.0, totalReturn: 40.2, riskLevel: 'HIGH', liquidityScore: 65, investorFriendly: true, taxRate: 15, residencyByInvestment: true),
  CityData(city: 'London', country: 'UK', currency: 'GBP', grossYield: 4.8, netYield: 3.5, appreciation: 5.2, totalReturn: 8.7, riskLevel: 'LOW', liquidityScore: 90, investorFriendly: true, taxRate: 20, residencyByInvestment: false),
  CityData(city: 'Miami', country: 'USA', currency: 'USD', grossYield: 5.8, netYield: 4.2, appreciation: 8.0, totalReturn: 12.2, riskLevel: 'MEDIUM', liquidityScore: 78, investorFriendly: true, taxRate: 25, residencyByInvestment: false),
  CityData(city: 'Paris', country: 'France', currency: 'EUR', grossYield: 3.8, netYield: 2.8, appreciation: 4.5, totalReturn: 7.3, riskLevel: 'LOW', liquidityScore: 85, investorFriendly: true, taxRate: 20, residencyByInvestment: false),
  CityData(city: 'Lisbon', country: 'Portugal', currency: 'EUR', grossYield: 5.0, netYield: 3.8, appreciation: 7.0, totalReturn: 10.8, riskLevel: 'LOW', liquidityScore: 72, investorFriendly: true, taxRate: 28, residencyByInvestment: true),
  CityData(city: 'Bangkok', country: 'Thailand', currency: 'THB', grossYield: 6.0, netYield: 4.5, appreciation: 5.5, totalReturn: 10.0, riskLevel: 'MEDIUM', liquidityScore: 60, investorFriendly: true, taxRate: 15, residencyByInvestment: false),
  CityData(city: 'Barcelona', country: 'Spain', currency: 'EUR', grossYield: 4.5, netYield: 3.2, appreciation: 6.0, totalReturn: 9.2, riskLevel: 'LOW', liquidityScore: 75, investorFriendly: true, taxRate: 24, residencyByInvestment: true),
];

class _CityComparisonPanel extends StatelessWidget {
  const _CityComparisonPanel();

  Color _riskColor(String risk) => switch (risk) {
        'LOW' => AppColors.success,
        'HIGH' => AppColors.error,
        _ => AppColors.warning,
      };

  @override
  Widget build(BuildContext context) {
    final sorted = [...kCityComparisons]
      ..sort((a, b) => b.totalReturn.compareTo(a.totalReturn));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compare investment metrics across major global cities.',
            style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < sorted.length; i++) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.darkBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${sorted[i].city}, ${sorted[i].country}',
                          style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 16),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _riskColor(sorted[i].riskLevel)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: _riskColor(sorted[i].riskLevel)
                                  .withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          '${sorted[i].riskLevel} RISK',
                          style: GoogleFonts.outfit(
                              color: _riskColor(sorted[i].riskLevel),
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${sorted[i].currency} · Tax ${sorted[i].taxRate}%',
                    style: GoogleFonts.outfit(
                        color: Colors.white38, fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _metric('Gross', '${sorted[i].grossYield}%',
                          color: AppColors.success),
                      const SizedBox(width: 10),
                      _metric('Net', '${sorted[i].netYield}%'),
                      const SizedBox(width: 10),
                      _metric('Apprec.', '${sorted[i].appreciation}%'),
                      const SizedBox(width: 10),
                      _metric('Total', '${sorted[i].totalReturn}%',
                          color: AppColors.primary),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _liquidityBar(sorted[i]),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _flag(sorted[i].investorFriendly, 'Investor friendly'),
                      const SizedBox(width: 16),
                      _flag(sorted[i].residencyByInvestment, 'Residency'),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: (50 * i).ms),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _metric(String label, String value, {Color? color}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.darkBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(label,
                style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10)),
            const SizedBox(height: 4),
            Text(value,
                style: GoogleFonts.outfit(
                    color: color ?? Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _liquidityBar(CityData city) {
    return Row(
      children: [
        Text('Liquidity',
            style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
        const SizedBox(width: 12),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: city.liquidityScore / 100,
              minHeight: 6,
              backgroundColor: Colors.white12,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text('${city.liquidityScore.toStringAsFixed(0)}/100',
            style: GoogleFonts.outfit(color: Colors.white54, fontSize: 11)),
      ],
    );
  }

  Widget _flag(bool ok, String label) {
    return Row(
      children: [
        Icon(
          ok ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: ok ? AppColors.success : AppColors.error,
        ),
        const SizedBox(width: 4),
        Text(label,
            style: GoogleFonts.outfit(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}
