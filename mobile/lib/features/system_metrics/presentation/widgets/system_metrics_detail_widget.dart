import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SystemMetrics Detail Widget  |  10 fields

class SystemMetricsDetailWidget extends StatelessWidget {
  final SystemMetrics item;
  const SystemMetricsDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Metric Type', item.metricType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Metric Name', item.metricName?.toString() ?? 'N/A', Icons.person),
        _row('Value', item.value?.toString() ?? 'N/A', Icons.numbers),
        _row('Unit', item.unit?.toString() ?? 'N/A', Icons.text_fields),
        _row('Timestamp', _fmt(item.timestamp), Icons.calendar_today),
        _row('Dimensions', item.dimensions?.toString() ?? 'N/A', Icons.text_fields),
        _row('Tags', item.tags?.toString() ?? 'N/A', Icons.text_fields),
        _row('Collected At', _fmt(item.collectedAt), Icons.calendar_today),
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