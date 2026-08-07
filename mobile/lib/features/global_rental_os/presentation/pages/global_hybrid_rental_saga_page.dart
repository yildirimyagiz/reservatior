import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GlobalHybridRentalSagaPage extends StatefulWidget {
  const GlobalHybridRentalSagaPage({super.key});

  @override
  State<GlobalHybridRentalSagaPage> createState() => _GlobalHybridRentalSagaPageState();
}

class _GlobalHybridRentalSagaPageState extends State<GlobalHybridRentalSagaPage> {
  bool _running = false;
  Map<String, dynamic>? _sagaResult;
  String _selectedCountry = 'TR';

  final List<String> _countries = [
    'TR','US','CA','GB','DE','NL','FR','ES','PT','IT','GR','CH',
    'AE','SA','QA','AU','SG','JP','KR','IN','PK','MX','BR'
  ];

  Future<void> _startSaga() async {
    setState(() { _running = true; _sagaResult = null; });
    try {
      final res = await http.post(
        Uri.parse('http://localhost:3000/api/os/global-hybrid-rental/start-saga'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'countryCode': _selectedCountry,
          'accommodates': 4,
          'sizeSqm': 85,
          'hasBuildingConsent100Pct': true,
          'hasTourismResidenceLicense': true,
          'grossRevenueLocal': 12000,
        }),
      );
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        setState(() => _sagaResult = data['saga']);
      }
    } catch (e) {
      setState(() => _sagaResult = {'status': 'FAILED', 'error': e.toString()});
    } finally {
      setState(() => _running = false);
    }
  }

  Color _stepColor(String status) {
    switch (status) {
      case 'COMPLETED': return const Color(0xFF10B981);
      case 'FAILED': return const Color(0xFFEF4444);
      case 'COMPENSATED': return const Color(0xFFF59E0B);
      default: return Colors.white30;
    }
  }

  @override
  Widget build(BuildContext context) {
    final steps = (_sagaResult?['steps'] as List<dynamic>?) ?? [];
    final status = _sagaResult?['status'] ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B27),
        title: const Text('Global Saga Orchestrator', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country selector + Start button
            Row(children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2433),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCountry,
                      dropdownColor: const Color(0xFF1E2433),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (v) => setState(() => _selectedCountry = v!),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _running ? null : _startSaga,
                icon: _running
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.play_arrow, size: 18),
                label: Text(_running ? 'Running...' : 'Start Saga'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ]),
            const SizedBox(height: 16),

            // Status banner
            if (_sagaResult != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: status == 'COMPLETED'
                      ? const Color(0xFF10B981).withOpacity(0.1)
                      : const Color(0xFFEF4444).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: status == 'COMPLETED' ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                    width: 0.5,
                  ),
                ),
                child: Row(children: [
                  Icon(
                    status == 'COMPLETED' ? Icons.check_circle : Icons.error,
                    color: status == 'COMPLETED' ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('$status · ${_sagaResult!['countryCode']} · ${_sagaResult!['currency']}',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                    Text(_sagaResult!['sagaId'] ?? '', style: const TextStyle(color: Colors.white54, fontSize: 10)),
                  ])),
                ]),
              ),
            ],

            // Steps list
            Expanded(
              child: steps.isEmpty
                  ? const Center(child: Text('Select a country and start the saga', style: TextStyle(color: Colors.white54)))
                  : ListView.builder(
                      itemCount: steps.length,
                      itemBuilder: (ctx, i) {
                        final step = steps[i];
                        final color = _stepColor(step['status'] ?? '');
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E2433),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: color.withOpacity(0.3)),
                          ),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Container(
                              width: 28, height: 28,
                              decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
                              child: Center(child: Text(
                                step['status'] == 'COMPLETED' ? '✓' : step['status'] == 'FAILED' ? '✗' : '${i + 1}',
                                style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
                              )),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(step['stepLabel'] ?? step['stepName'] ?? '',
                                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                              Text(step['osModule'] ?? '',
                                  style: const TextStyle(color: Colors.white54, fontSize: 10)),
                              if (step['error'] != null)
                                Text(step['error'], style: const TextStyle(color: Color(0xFFEF4444), fontSize: 9)),
                            ])),
                          ]),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
