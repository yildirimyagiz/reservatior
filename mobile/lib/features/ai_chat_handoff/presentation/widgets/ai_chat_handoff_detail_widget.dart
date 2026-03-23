import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIChatHandoff Detail Widget  |  9 fields

class AIChatHandoffDetailWidget extends StatelessWidget {
  final AIChatHandoff item;
  const AIChatHandoffDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Session Id', item.sessionId?.toString() ?? 'N/A', Icons.link),
        _row('Handoff Reason', item.handoffReason?.toString() ?? 'N/A', Icons.text_fields),
        _row('Handoff To', item.handoffTo?.toString() ?? 'N/A', Icons.text_fields),
        _row('Handoff At', _fmt(item.handoffAt), Icons.calendar_today),
        _row('Resolved At', _fmt(item.resolvedAt), Icons.calendar_today),
        _row('Resolved By', item.resolvedBy?.toString() ?? 'N/A', Icons.text_fields),
        _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
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