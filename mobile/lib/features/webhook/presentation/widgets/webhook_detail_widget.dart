import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Webhook Detail Widget  |  12 fields

class WebhookDetailWidget extends StatelessWidget {
  final Webhook item;
  const WebhookDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
        _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
        _row('Url', item.url?.toString() ?? 'N/A', Icons.text_fields),
        _row('Secret', item.secret?.toString() ?? 'N/A', Icons.text_fields),
        _row('Headers', item.headers?.toString() ?? 'N/A', Icons.text_fields),
        _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Last Triggered At', _fmt(item.lastTriggeredAt), Icons.calendar_today),
        _row('Failure Count', item.failureCount?.toString() ?? 'N/A', Icons.numbers),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
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