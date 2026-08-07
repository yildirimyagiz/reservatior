import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reservatior/core/services/ml_api_service.dart';
import 'package:reservatior/core/theme/app_theme.dart';
import 'package:reservatior/shared/providers/contract_provider.dart';
import 'package:reservatior/shared/services/contract_service.dart';

const _contractTypes = [
  'RESIDENTIAL_LEASE',
  'COMMERCIAL_LEASE',
  'SHORT_TERM_BOOKING',
  'SALES_AGREEMENT',
  'EARNEST_MONEY',
  'EVICTION_COMMITMENT',
  'AGENCY_REPRESENTATION',
  'PROPERTY_MANAGEMENT',
];

const _fallbackCountries = [
  'TR', 'USA', 'CA', 'MX', 'UK', 'DE', 'FR', 'ES', 'IT', 'NL', 'BR', 'AR',
  'AU', 'NZ', 'JP', 'KR', 'CN', 'IN', 'SG', 'MY', 'TH', 'AE', 'SA',
];

const _fallbackLanguages = [
  'en', 'tr', 'ar', 'de', 'fr', 'es', 'it', 'ru', 'pt', 'ja', 'nl', 'ko',
  'zh', 'hi', 'th', 'ms',
];

class ContractGeneratorPage extends ConsumerStatefulWidget {
  const ContractGeneratorPage({super.key});

  @override
  ConsumerState<ContractGeneratorPage> createState() => _ContractGeneratorPageState();
}

class _ContractGeneratorPageState extends ConsumerState<ContractGeneratorPage> {
  late final ContractService _service = ref.read(contractServiceProvider);
  String _country = 'TR';
  String _type = 'RESIDENTIAL_LEASE';
  String _language = 'tr';
  bool _useML = false;
  bool _loading = false;
  Map<String, dynamic>? _catalog;
  Map<String, dynamic>? _result;

  final _ownerName = TextEditingController();
  final _ownerId = TextEditingController();
  final _partyName = TextEditingController();
  final _partyId = TextEditingController();
  final _propertyAddress = TextEditingController();
  final _propertyCity = TextEditingController();
  final _price = TextEditingController();
  final _deposit = TextEditingController();

  List<String> get _countries {
    final list = (_catalog?['countries'] as List?) ?? const [];
    if (list.isEmpty) return _fallbackCountries;
    return list.map((c) => ((c as Map)['country'] ?? '').toString()).toList();
  }

  List<String> get _languages {
    final list = (_catalog?['languages'] as List?) ?? const [];
    if (list.isEmpty) return _fallbackLanguages;
    return list.map((l) => l.toString()).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadCatalog();
  }

  Future<void> _loadCatalog() async {
    try {
      final catalog = await _service.getContractTemplates();
      if (!mounted) return;
      setState(() => _catalog = catalog);
    } catch (_) {
      // Fall back to the static defaults above.
    }
  }

  Future<void> _generate() async {
    setState(() => _loading = true);
    try {
      final data = {
        'property': {
          'address': _propertyAddress.text,
          'city': _propertyCity.text,
        },
        'landlordOrSeller': {
          'fullName': _ownerName.text,
          'nationalIdOrTaxNo': _ownerId.text,
        },
        'tenantOrBuyer': {
          'fullName': _partyName.text,
          'nationalIdOrTaxNo': _partyId.text,
        },
        'financials': {
          'price': double.tryParse(_price.text) ?? 0,
          'depositAmount': double.tryParse(_deposit.text) ?? 0,
          'currency': '',
          'termMonths': 12,
          'isZeroDeposit': false,
        },
      };

      Map<String, dynamic> result;
      if (_useML) {
        result = await mlApiService.generateContract({
          'country': _country,
          'contract_type': _type,
          'language': _language,
          'data': data,
        });
        result = {'html': null, 'markdown': result['content_markdown'], 'metadata': result};
      } else {
        result = await _service.generateContract(
          type: _type,
          region: _country,
          language: _language,
          data: data,
        );
      }
      if (!mounted) return;
      setState(() => _result = result);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate contract: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _copyResult() {
    final html = _result?['html']?.toString() ?? '';
    final markdown = _result?['markdown']?.toString() ?? '';
    final content = html.isNotEmpty ? html : markdown;
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contract copied to clipboard')),
    );
  }

  Widget _dropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required void Function(T) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.darkBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              dropdownColor: AppColors.darkCard,
              isExpanded: true,
              style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.toString())))
                  .toList(),
              onChanged: (v) => v != null ? onChanged(v) : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _field(TextEditingController controller, String label, {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.outfit(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.outfit(color: Colors.white54, fontSize: 13),
        filled: true,
        fillColor: AppColors.darkCard,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final previewHtml = _result?['html']?.toString();
    final previewMarkdown = _result?['markdown']?.toString();

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        title: Text('Contract Generator',
            style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Generate localized contracts for 23 countries.',
              style: GoogleFonts.outfit(color: Colors.white54, fontSize: 13)),
          const SizedBox(height: 16),
          _dropdown<String>(
            label: 'Country',
            value: _country,
            items: _countries,
            onChanged: (v) => setState(() => _country = v),
          ),
          const SizedBox(height: 12),
          _dropdown<String>(
            label: 'Contract type',
            value: _type,
            items: _contractTypes,
            onChanged: (v) => setState(() => _type = v),
          ),
          const SizedBox(height: 12),
          _dropdown<String>(
            label: 'Language',
            value: _language,
            items: _languages,
            onChanged: (v) => setState(() => _language = v),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text('ML provider',
                  style: GoogleFonts.outfit(color: Colors.white70, fontSize: 13)),
              const SizedBox(width: 12),
              Switch(
                value: _useML,
                onChanged: (v) => setState(() => _useML = v),
                activeThumbColor: AppColors.primary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Owner / Seller',
              style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _field(_ownerName, 'Full name'),
          const SizedBox(height: 8),
          _field(_ownerId, 'National ID / Tax no'),
          const SizedBox(height: 16),
          Text('Tenant / Buyer',
              style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _field(_partyName, 'Full name'),
          const SizedBox(height: 8),
          _field(_partyId, 'National ID / Tax no'),
          const SizedBox(height: 16),
          Text('Property',
              style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _field(_propertyAddress, 'Address'),
          const SizedBox(height: 8),
          _field(_propertyCity, 'City'),
          const SizedBox(height: 16),
          Text('Financials',
              style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _field(_price, 'Price / Rent', keyboardType: TextInputType.number),
          const SizedBox(height: 8),
          _field(_deposit, 'Deposit', keyboardType: TextInputType.number),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loading ? null : _generate,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _loading
                ? const SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Text('Generate Contract',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 24),
          if (_result != null) ...[
            Row(
              children: [
                Text('Preview',
                    style: GoogleFonts.outfit(
                        color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
                const Spacer(),
                IconButton(
                  onPressed: _copyResult,
                  icon: const Icon(Icons.copy, color: Colors.white54),
                  tooltip: 'Copy',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxHeight: 480),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.darkBorder),
              ),
              child: previewHtml != null
                  ? Text(
                      previewHtml.replaceAll(RegExp(r'<[^>]*>'), ' ').replaceAll(RegExp(r'\s+'), ' '),
                      style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12),
                    )
                  : SelectableText(
                      previewMarkdown ?? '',
                      style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12),
                    ),
            ),
          ],
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
