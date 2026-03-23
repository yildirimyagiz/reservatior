import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Analytics Detail Widget  |  13 fields

class AnalyticsDetailWidget extends StatelessWidget {
  final Analytics item;
  const AnalyticsDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Entity Id', item.entityId?.toString() ?? 'N/A', Icons.link),
        _row('Entity Type', item.entityType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Data', item.data?.toString() ?? 'N/A', Icons.text_fields),
        _row('Timestamp', _fmt(item.timestamp), Icons.calendar_today),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
        _row('Agent Id', item.agentId?.toString() ?? 'N/A', Icons.link),
        _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
        _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
        _row('Task Id', item.taskId?.toString() ?? 'N/A', Icons.link),
        _row('Tax Record Id', item.taxRecordId?.toString() ?? 'N/A', Icons.link),
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