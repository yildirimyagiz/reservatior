import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SocialImpactRecord Detail Widget  |  13 fields

class SocialImpactRecordDetailWidget extends StatelessWidget {
  final SocialImpactRecord item;
  const SocialImpactRecordDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Counter Id', item.counterId?.toString() ?? 'N/A', Icons.link),
        _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
        _row('Impact Type', item.impactType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Quantity', item.quantity?.toString() ?? 'N/A', Icons.numbers),
        _row('Amount', item.amount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
        _row('Verified At', _fmt(item.verifiedAt), Icons.calendar_today),
        _row('Verified By', item.verifiedBy?.toString() ?? 'N/A', Icons.text_fields),
        _row('Proof Url', item.proofUrl?.toString() ?? 'N/A', Icons.text_fields),
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