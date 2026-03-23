import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIFraudDetection Detail Widget  |  13 fields

class AIFraudDetectionDetailWidget extends StatelessWidget {
  final AIFraudDetection item;
  const AIFraudDetectionDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Entity Type', item.entityType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Entity Id', item.entityId?.toString() ?? 'N/A', Icons.link),
        _row('Risk Score', item.riskScore?.toString() ?? 'N/A', Icons.numbers),
        _row('Risk Factors', item.riskFactors?.toString() ?? 'N/A', Icons.text_fields),
        _row('Risk Category', item.riskCategory?.toString() ?? 'N/A', Icons.text_fields),
        _row('Recommended Actions', item.recommendedActions?.toString() ?? 'N/A', Icons.text_fields),
        _row('Detected At', _fmt(item.detectedAt), Icons.calendar_today),
        _row('Reviewed At', _fmt(item.reviewedAt), Icons.calendar_today),
        _row('Reviewed By', item.reviewedBy?.toString() ?? 'N/A', Icons.text_fields),
        _row('Resolution', item.resolution?.toString() ?? 'N/A', Icons.text_fields),
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