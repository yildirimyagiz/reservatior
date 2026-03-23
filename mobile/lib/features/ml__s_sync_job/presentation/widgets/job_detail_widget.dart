import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Job Detail Widget ──

class JobDetailWidget extends StatelessWidget {
  final Job item;
  const JobDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      // Status badge
      if (item.status != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(children: [
            const Icon(Icons.info_outline, size: 18, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Chip(
              label: Text(item.status!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
              backgroundColor: _stColor(item.status).withOpacity(0.15),
            ),
          ]),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Payload', item.payload?.toString() ?? 'N/A', Icons.text_fields),
        _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
        _row('Run At', _fmt(item.runAt), Icons.calendar_today),
        _row('Attempts', item.attempts?.toString() ?? 'N/A', Icons.numbers),
        _row('Last Error', item.lastError?.toString() ?? 'N/A', Icons.text_fields),
        _row('Locked At', _fmt(item.lockedAt), Icons.calendar_today),
        _row('Locked By', item.lockedBy?.toString() ?? 'N/A', Icons.text_fields),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
}
