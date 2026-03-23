import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIInvestmentAnalysis Detail Widget  |  13 fields

class AIInvestmentAnalysisDetailWidget extends StatelessWidget {
  final AIInvestmentAnalysis item;
  const AIInvestmentAnalysisDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Analysis Type', item.analysisType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Time Horizon', item.timeHorizon?.toString() ?? 'N/A', Icons.text_fields),
        _row('Projected Returns', item.projectedReturns?.toString() ?? 'N/A', Icons.text_fields),
        _row('Cash Flow Projection', item.cashFlowProjection?.toString() ?? 'N/A', Icons.text_fields),
        _row('Risk Metrics', item.riskMetrics?.toString() ?? 'N/A', Icons.text_fields),
        _row('Key Assumptions', item.keyAssumptions?.toString() ?? 'N/A', Icons.text_fields),
        _row('Sensitivity Analysis', item.sensitivityAnalysis?.toString() ?? 'N/A', Icons.text_fields),
        _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
        _row('Generated At', _fmt(item.generatedAt), Icons.attach_money),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
      ],
    );
  }
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value, style: const TextStyle(fontSize: 14)),
    ])),
  ]),
);

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}