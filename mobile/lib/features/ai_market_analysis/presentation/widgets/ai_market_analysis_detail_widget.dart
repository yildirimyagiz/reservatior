import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIMarketAnalysis Detail Widget  |  13 fields

class AIMarketAnalysisDetailWidget extends StatelessWidget {
  final AIMarketAnalysis item;
  const AIMarketAnalysisDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      if (item.status != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Chip(
            avatar: const Icon(Icons.info_outline, size: 16),
            label: Text(item.status!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: _stColor(item.status).withValues(alpha: 0.15),
          ),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Analysis Type', item.analysisType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Location', item.location?.toString() ?? 'N/A', Icons.location_on),
        _row('Analysis Period', item.analysisPeriod?.toString() ?? 'N/A', Icons.text_fields),
        _row('Data Points', item.dataPoints?.toString() ?? 'N/A', Icons.text_fields),
        _row('Predictions', item.predictions?.toString() ?? 'N/A', Icons.text_fields),
        _row('Insights', item.insights?.toString() ?? 'N/A', Icons.text_fields),
        _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
        _row('Generated At', _fmt(item.generatedAt), Icons.attach_money),
        _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
      ],
    );
  }
}
Color _stColor(dynamic status) {
  final s = status?.toString().toLowerCase() ?? '';
  if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
  if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
  if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
  return Colors.blueGrey;
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