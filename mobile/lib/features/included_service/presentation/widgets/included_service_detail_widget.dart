import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── IncludedService Detail Widget  |  12 fields

class IncludedServiceDetailWidget extends StatelessWidget {
  final IncludedService item;
  const IncludedServiceDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
        _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
        _row('Value', item.value?.toString() ?? 'N/A', Icons.numbers),
        _row('Is Recurring', (item.isRecurring == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Frequency', item.frequency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Icon', item.icon?.toString() ?? 'N/A', Icons.text_fields),
        _row('Logo', item.logo?.toString() ?? 'N/A', Icons.text_fields),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
        _row('Facility Id', item.facilityId?.toString() ?? 'N/A', Icons.link),
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