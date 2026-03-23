import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── LedgerEntry Detail Widget  |  18 fields

class LedgerEntryDetailWidget extends StatelessWidget {
  final LedgerEntry item;
  const LedgerEntryDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
        _row('Lease Id', item.leaseId?.toString() ?? 'N/A', Icons.link),
        _row('Booking Id', item.bookingId?.toString() ?? 'N/A', Icons.link),
        _row('Contract Id', item.contractId?.toString() ?? 'N/A', Icons.link),
        _row('Bill Id', item.billId?.toString() ?? 'N/A', Icons.link),
        _row('Transaction Id', item.transactionId?.toString() ?? 'N/A', Icons.link),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Amount', item.amount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Occurred At', _fmt(item.occurredAt), Icons.calendar_today),
        _row('Note', item.note?.toString() ?? 'N/A', Icons.notes),
        _row('Meta', item.meta?.toString() ?? 'N/A', Icons.text_fields),
        _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
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