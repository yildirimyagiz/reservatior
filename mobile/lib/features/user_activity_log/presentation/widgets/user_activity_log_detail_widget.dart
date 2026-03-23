import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── UserActivityLog Detail Widget  |  10 fields

class UserActivityLogDetailWidget extends StatelessWidget {
  final UserActivityLog item;
  const UserActivityLogDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Action', item.action?.toString() ?? 'N/A', Icons.text_fields),
        _row('Entity Type', item.entityType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Entity Id', item.entityId?.toString() ?? 'N/A', Icons.link),
        _row('Metadata', item.metadata?.toString() ?? 'N/A', Icons.text_fields),
        _row('Ip Address', item.ipAddress?.toString() ?? 'N/A', Icons.location_on),
        _row('User Agent', item.userAgent?.toString() ?? 'N/A', Icons.text_fields),
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