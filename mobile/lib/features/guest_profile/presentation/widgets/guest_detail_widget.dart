import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Guest Detail Widget ──

class GuestDetailWidget extends StatelessWidget {
  final Guest item;
  const GuestDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
        _row('Phone', item.phone?.toString() ?? 'N/A', Icons.phone),
        _row('Image', item.image?.toString() ?? 'N/A', Icons.text_fields),
        _row('Nationality', item.nationality?.toString() ?? 'N/A', Icons.text_fields),
        _row('Passport Number', item.passportNumber?.toString() ?? 'N/A', Icons.text_fields),
        _row('Gender', item.gender?.toString() ?? 'N/A', Icons.text_fields),
        _row('Birth Date', _fmt(item.birthDate), Icons.calendar_today),
        _row('Address', item.address?.toString() ?? 'N/A', Icons.location_on),
        _row('City', item.city?.toString() ?? 'N/A', Icons.location_on),
        _row('Country', item.country?.toString() ?? 'N/A', Icons.location_on),
        _row('Zip Code', item.zipCode?.toString() ?? 'N/A', Icons.location_on),
        _row('Email', item.email?.toString() ?? 'N/A', Icons.email),
        _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
}
