import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/features/seo/data/seo_data_service.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';

final seoDataServiceProvider = Provider<SeoDataService>((ref) {
  return SeoDataService(ref.watch(dioClientProvider));
});

class RentalYieldScreen extends ConsumerStatefulWidget {
  final String? propertyId;
  const RentalYieldScreen({super.key, this.propertyId});

  @override
  ConsumerState<RentalYieldScreen> createState() => _RentalYieldScreenState();
}

class _RentalYieldScreenState extends ConsumerState<RentalYieldScreen> {
  final _valueCtrl = TextEditingController(text: '450000');
  final _rentCtrl = TextEditingController(text: '2500');
  final _expensesCtrl = TextEditingController(text: '3500');
  final _propertyIdCtrl = TextEditingController();

  double? _gross;
  double? _net;
  double? _cashOnCash;
  RentalYieldData? _apiYield;
  bool _loadingApi = false;
  String? _apiError;

  @override
  void initState() {
    super.initState();
    if (widget.propertyId != null) {
      _propertyIdCtrl.text = widget.propertyId!;
      WidgetsBinding.instance.addPostFrameCallback((_) => _fetchApi());
    }
  }

  @override
  void dispose() {
    _valueCtrl.dispose();
    _rentCtrl.dispose();
    _expensesCtrl.dispose();
    _propertyIdCtrl.dispose();
    super.dispose();
  }

  void _calculateLocal() {
    final value = double.tryParse(_valueCtrl.text) ?? 0;
    final rent = double.tryParse(_rentCtrl.text) ?? 0;
    final expenses = double.tryParse(_expensesCtrl.text) ?? 0;
    if (value <= 0) return;
    final annual = rent * 12;
    final gross = (annual / value) * 100;
    final net = ((annual - expenses) / value) * 100;
    final down = value * 0.25;
    final cashOnCash = down > 0 ? ((annual - expenses) / down) * 100 : 0.0;
    setState(() {
      _gross = gross;
      _net = net;
      _cashOnCash = cashOnCash;
    });
  }

  Future<void> _fetchApi() async {
    final id = _propertyIdCtrl.text.trim();
    if (id.isEmpty) return;
    setState(() {
      _loadingApi = true;
      _apiError = null;
    });
    final data = await ref.read(seoDataServiceProvider).getRentalYield(id);
    setState(() {
      _loadingApi = false;
      if (data == null) {
        _apiError = 'SEO yield unavailable for this property';
      } else {
        _apiYield = data;
        _valueCtrl.text = data.propertyValue.toStringAsFixed(0);
        _rentCtrl.text = data.monthlyRent.toStringAsFixed(0);
        _gross = data.grossYield;
        _net = data.netYield;
        _cashOnCash = data.cashOnCashReturn;
      }
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
              'Rental Yield',
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
                  'Gross / net yield and cash-on-cash — mirrors client-seo calculator.',
                  style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _propertyIdCtrl,
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: _dec('Property ID (optional — SEO API)'),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _loadingApi ? null : _fetchApi,
                    icon: _loadingApi
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.cloud_download_outlined, size: 18),
                    label: Text('Load from SEO API',
                        style: GoogleFonts.outfit(fontSize: 13)),
                  ),
                ),
                if (_apiError != null)
                  Text(_apiError!,
                      style: GoogleFonts.outfit(
                          color: AppColors.warning, fontSize: 12)),
                const SizedBox(height: 8),
                TextField(
                  controller: _valueCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: _dec('Property value'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _rentCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: _dec('Monthly rent'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _expensesCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: _dec('Annual expenses'),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _calculateLocal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text('Calculate yield',
                        style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
                  ),
                ),
                if (_gross != null) ...[
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                          child: _metric('Gross',
                              '${_gross!.toStringAsFixed(2)}%')),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _metric(
                              'Net', '${_net!.toStringAsFixed(2)}%')),
                    ],
                  ).animate().fadeIn(),
                  const SizedBox(height: 12),
                  _metric('Cash-on-cash',
                      '${_cashOnCash!.toStringAsFixed(2)}%'),
                  if (_apiYield != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Break-even: ${_apiYield!.breakEvenMonths.toStringAsFixed(0)} months',
                      style: GoogleFonts.outfit(
                          color: Colors.white54, fontSize: 13),
                    ),
                  ],
                ],
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.of(context).maybePop().then((_) {
                    // Prefer dedicated ROI route when available via go_router parent
                  }),
                  icon: const Icon(Icons.calculate_outlined),
                  label: Text('Use ROI calculator for full model',
                      style: GoogleFonts.outfit()),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _dec(String label) => InputDecoration(
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
      );

  Widget _metric(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value,
              style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20)),
        ],
      ),
    );
  }
}
