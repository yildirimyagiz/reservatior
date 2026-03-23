import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── DepositProtection Detail Widget

class DepositProtectionDetailWidget extends StatelessWidget {
  final DepositProtection item;
  const DepositProtectionDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
    _row('Amount', item.amount?.toString() ?? 'N/A', Icons.attach_money),
    _row('Claimed At', _fmt(item.claimedAt), Icons.calendar_today),
    _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
    _row('Lease Id', item.leaseId?.toString() ?? 'N/A', Icons.link),
    _row('Protected At', _fmt(item.protectedAt), Icons.calendar_today),
    _row('Provider', item.provider?.toString() ?? 'N/A', Icons.link),
    _row('Reference', item.reference?.toString() ?? 'N/A', Icons.text_fields),
    _row('Returned At', _fmt(item.returnedAt), Icons.calendar_today),
    _row('Scheme', item.scheme?.toString() ?? 'N/A', Icons.text_fields),
    _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
    _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
    _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
      ]),
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
