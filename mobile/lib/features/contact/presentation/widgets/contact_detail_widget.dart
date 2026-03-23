import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Contact Detail Widget  |  14 fields

class ContactDetailWidget extends StatelessWidget {
  final Contact item;
  const ContactDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Full Name', item.fullName?.toString() ?? 'N/A', Icons.person),
        _row('Email', item.email?.toString() ?? 'N/A', Icons.email),
        _row('Phone', item.phone?.toString() ?? 'N/A', Icons.phone),
        _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
        _row('Locale', item.locale?.toString() ?? 'N/A', Icons.text_fields),
        _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
        _row('Consent Given At', _fmt(item.consentGivenAt), Icons.calendar_today),
        _row('Consent Withdrawn At', _fmt(item.consentWithdrawnAt), Icons.calendar_today),
        _row('Data Subject Id', item.dataSubjectId?.toString() ?? 'N/A', Icons.link),
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