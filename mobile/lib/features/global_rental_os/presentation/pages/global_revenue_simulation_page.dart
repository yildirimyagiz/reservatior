import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Revenue DAG Simulation Page — simulates the 8-node revenue pipeline
/// for any country with customizable gross revenue, owner %, and partner %.
class GlobalRevenueSimulationPage extends StatefulWidget {
  const GlobalRevenueSimulationPage({super.key});

  @override
  State<GlobalRevenueSimulationPage> createState() => _GlobalRevenueSimulationPageState();
}

class _GlobalRevenueSimulationPageState extends State<GlobalRevenueSimulationPage> {
  String _selectedCountry = 'TR';
  double _grossRevenue = 10000;
  double _ownerPct = 55;
  double _partnerPct = 10;
  bool _simulating = false;
  Map<String, dynamic>? _result;

  final List<String> _countries = [
    'TR','US','CA','GB','DE','NL','FR','ES','PT','IT','GR','CH',
    'AE','SA','QA','AU','SG','JP','KR','IN','PK','MX','BR'
  ];

  Future<void> _simulate() async {
    setState(() { _simulating = true; _result = null; });
    try {
      final res = await http.post(
        Uri.parse('http://localhost:3000/api/os/global-hybrid-rental/revenue-simulation'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'countryCode': _selectedCountry,
          'grossRevenueLocal': _grossRevenue,
          'ownerSharePct': _ownerPct,
          'partnerCommissionPct': _partnerPct,
        }),
      );
      if (res.statusCode == 200) {
        setState(() => _result = json.decode(res.body));
      }
    } catch (e) {
      setState(() => _result = {'error': e.toString()});
    } finally {
      setState(() => _simulating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final nodes = (_result?['dag']?['nodes'] as List<dynamic>?) ?? [];
    final summary = _result?['dag']?['summary'];

    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B27),
        title: Text(
          'Revenue DAG Simulation',
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Config card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2433),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Configuration', style: GoogleFonts.outfit(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),

                // Country selector
                Row(children: [
                  Text('Country', style: GoogleFonts.outfit(color: Colors.white54, fontSize: 12)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F1117),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCountry,
                        dropdownColor: const Color(0xFF1E2433),
                        style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
                        items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                        onChanged: (v) => setState(() => _selectedCountry = v!),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 12),

                // Gross revenue slider
                _slider('Gross Revenue', _grossRevenue, 1000, 100000, (v) => setState(() => _grossRevenue = v),
                    '${_grossRevenue.toStringAsFixed(0)}', const Color(0xFF10B981)),
                _slider('Owner Share %', _ownerPct, 30, 80, (v) => setState(() => _ownerPct = v),
                    '${_ownerPct.toStringAsFixed(0)}%', const Color(0xFF3B82F6)),
                _slider('Partner %', _partnerPct, 0, 20, (v) => setState(() => _partnerPct = v),
                    '${_partnerPct.toStringAsFixed(0)}%', const Color(0xFF8B5CF6)),

                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _simulating ? null : _simulate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF59E0B),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: _simulating
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                        : Text('Simulate Revenue DAG', style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),

          // Summary
          if (summary != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _summaryItem('Gross', '${summary['grossRevenue']}', const Color(0xFF10B981)),
                  _summaryItem('Tax', '${summary['totalTax']}', const Color(0xFFEF4444)),
                  _summaryItem('Net', '${summary['netRevenue']}', const Color(0xFF3B82F6)),
                ],
              ),
            ),
          ],

          // DAG Nodes
          if (nodes.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('DAG PIPELINE NODES', style: GoogleFonts.outfit(color: Colors.white30, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2)),
            const SizedBox(height: 8),
            ...nodes.asMap().entries.map((entry) {
              final i = entry.key;
              final node = entry.value;
              final nodeType = node['nodeType'] ?? '';
              final color = _nodeColor(nodeType);
              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2433),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text('${i + 1}', style: GoogleFonts.outfit(color: color, fontSize: 11, fontWeight: FontWeight.w800)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (nodeType as String).replaceAll('_', ' '),
                            style: GoogleFonts.outfit(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                          if (node['description'] != null)
                            Text(node['description'], style: GoogleFonts.outfit(color: Colors.white38, fontSize: 9)),
                        ],
                      ),
                    ),
                    Text(
                      '${node['amountLocal']?.toStringAsFixed(0) ?? '—'}',
                      style: GoogleFonts.outfit(color: color, fontSize: 13, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              );
            }),
          ],

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _slider(String label, double value, double min, double max, ValueChanged<double> onChanged, String display, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Text(label, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 11)),
            const Spacer(),
            Text(display, style: GoogleFonts.outfit(color: color, fontSize: 12, fontWeight: FontWeight.w700)),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            inactiveTrackColor: color.withOpacity(0.15),
            thumbColor: color,
            overlayColor: color.withOpacity(0.1),
            trackHeight: 3,
          ),
          child: Slider(value: value, min: min, max: max, onChanged: onChanged),
        ),
      ],
    );
  }

  Widget _summaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.outfit(color: color, fontSize: 16, fontWeight: FontWeight.w900)),
        Text(label, style: GoogleFonts.outfit(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Color _nodeColor(String type) {
    if (type.contains('TAX') || type.contains('WITHHOLDING')) return const Color(0xFFEF4444);
    if (type.contains('OWNER')) return const Color(0xFF3B82F6);
    if (type.contains('PARTNER')) return const Color(0xFF8B5CF6);
    if (type.contains('MARGIN') || type.contains('RESERVATIOR')) return const Color(0xFFF59E0B);
    if (type.contains('LEDGER')) return const Color(0xFF10B981);
    return const Color(0xFF10B981);
  }
}
