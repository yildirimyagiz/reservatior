import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ImmigrationStatusCheck Detail Widget  |  18 fields

class ImmigrationStatusCheckDetailWidget extends StatelessWidget {
  final ImmigrationStatusCheck item;
  const ImmigrationStatusCheckDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      if (item.checkStatus != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Chip(
            avatar: const Icon(Icons.info_outline, size: 16),
            label: Text(item.checkStatus!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: _stColor(item.checkStatus).withOpacity(0.15),
          ),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Lease Id', item.leaseId?.toString() ?? 'N/A', Icons.link),
        _row('Tenant Id', item.tenantId?.toString() ?? 'N/A', Icons.link),
        _row('Check Status', item.checkStatus?.toString() ?? 'N/A', Icons.info_outline),
        _row('Check Date', _fmt(item.checkDate), Icons.calendar_today),
        _row('Valid Until', _fmt(item.validUntil), Icons.calendar_today),
        _row('Immigration Status', item.immigrationStatus?.toString() ?? 'N/A', Icons.info_outline),
        _row('Visa Type', item.visaType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Visa Expiry', _fmt(item.visaExpiry), Icons.calendar_today),
        _row('Document Type', item.documentType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Document Number', item.documentNumber?.toString() ?? 'N/A', Icons.text_fields),
        _row('Document Verified', (item.documentVerified == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Share Code', item.shareCode?.toString() ?? 'N/A', Icons.text_fields),
        _row('Check Reference', item.checkReference?.toString() ?? 'N/A', Icons.text_fields),
        _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
      ],
    );
  }
}
Color _stColor(dynamic status) {
  final s = status?.toString().toLowerCase() ?? '';
  if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
  if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
  if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
  return Colors.blueGrey;
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