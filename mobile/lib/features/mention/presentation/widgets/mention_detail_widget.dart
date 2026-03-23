import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Mention Detail Widget  |  12 fields

class MentionDetailWidget extends StatelessWidget {
  final Mention item;
  const MentionDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Mentioned By Id', item.mentionedById?.toString() ?? 'N/A', Icons.link),
        _row('Mentioned To Id', item.mentionedToId?.toString() ?? 'N/A', Icons.link),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Task Id', item.taskId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Content', item.content?.toString() ?? 'N/A', Icons.notes),
        _row('Is Read', (item.isRead == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
        _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
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