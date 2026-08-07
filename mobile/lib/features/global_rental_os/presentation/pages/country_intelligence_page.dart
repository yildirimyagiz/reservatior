import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryIntelligencePage extends StatefulWidget {
  const CountryIntelligencePage({super.key});

  @override
  State<CountryIntelligencePage> createState() => _CountryIntelligencePageState();
}

class _CountryIntelligencePageState extends State<CountryIntelligencePage> {
  List<dynamic> _countries = [];
  bool _loading = true;
  String _selectedRegion = 'All';

  final Map<String, List<String>> _regions = {
    'Americas': ['US', 'CA', 'MX', 'BR'],
    'Europe': ['GB', 'DE', 'NL', 'FR', 'ES', 'PT', 'IT', 'GR', 'CH'],
    'Turkey': ['TR'],
    'Middle East': ['AE', 'SA', 'QA'],
    'Asia-Pacific': ['AU', 'SG', 'JP', 'KR', 'IN', 'PK'],
  };

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    try {
      final res = await http.get(
        Uri.parse('http://localhost:3000/api/os/global-hybrid-rental/countries'),
      );
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        setState(() {
          _countries = data['countries'] ?? [];
          _loading = false;
        });
      }
    } catch (_) {
      setState(() => _loading = false);
    }
  }

  List<dynamic> get _filteredCountries {
    if (_selectedRegion == 'All') return _countries;
    final codes = _regions[_selectedRegion] ?? [];
    return _countries.where((c) => codes.contains(c['countryCode'])).toList();
  }

  Color _demandColor(String demand) {
    switch (demand) {
      case 'VERY_HIGH': return const Color(0xFF10B981);
      case 'HIGH': return const Color(0xFF3B82F6);
      case 'MEDIUM': return const Color(0xFFF59E0B);
      default: return const Color(0xFFEF4444);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B27),
        title: const Text('Country Intelligence', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white70),
            onPressed: () { setState(() => _loading = true); _loadCountries(); },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF6366F1)))
          : Column(
              children: [
                // Region filter
                SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: ['All', ..._regions.keys].map((r) {
                      final selected = _selectedRegion == r;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedRegion = r),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: selected ? const Color(0xFF6366F1).withOpacity(0.2) : const Color(0xFF1E2433),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: selected ? const Color(0xFF6366F1) : Colors.white.withOpacity(0.1)),
                          ),
                          child: Text(r, style: TextStyle(fontSize: 12, color: selected ? const Color(0xFF818CF8) : Colors.white54)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // Country grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.1,
                    ),
                    itemCount: _filteredCountries.length,
                    itemBuilder: (ctx, i) {
                      final c = _filteredCountries[i];
                      final demand = c['corporateHousingDemand'] ?? 'MEDIUM';
                      final color = _demandColor(demand);
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2433),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: color.withOpacity(0.3)),
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                              child: Text(c['countryCode'] ?? '', style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                            const Spacer(),
                            Text('${c['complianceScore']?.toStringAsFixed(0) ?? '—'}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          ]),
                          const SizedBox(height: 6),
                          Text(c['countryName'] ?? '', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                          Text('${c['currency']} · ${(c['taxSystem'] ?? '').replaceAll('_', ' ')}',
                              style: const TextStyle(color: Colors.white54, fontSize: 9)),
                          const Spacer(),
                          Row(children: [
                            _pill('${c['vatRate']}% VAT', Colors.purple),
                            const SizedBox(width: 4),
                            _pill('${c['tourismTaxRate']}% Tour', Colors.amber),
                          ]),
                        ]),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _pill(String text, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.w600)),
  );
}
