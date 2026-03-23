import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── BrandAmbassador Detail Widget  |  27 fields

class BrandAmbassadorDetailWidget extends StatelessWidget {
  final BrandAmbassador item;
  const BrandAmbassadorDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      if (item.status != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Chip(
            avatar: const Icon(Icons.info_outline, size: 16),
            label: Text(item.status!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: _stColor(item.status).withOpacity(0.15),
          ),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Full Name', item.fullName?.toString() ?? 'N/A', Icons.person),
        _row('Email Ciphertext', item.emailCiphertext?.toString() ?? 'N/A', Icons.email),
        _row('Phone Ciphertext', item.phoneCiphertext?.toString() ?? 'N/A', Icons.phone),
        _row('Category', item.category?.toString() ?? 'N/A', Icons.text_fields),
        _row('Follower Count', item.followerCount?.toString() ?? 'N/A', Icons.numbers),
        _row('Engagement Rate', item.engagementRate?.toString() ?? 'N/A', Icons.attach_money),
        _row('Contract Start', _fmt(item.contractStart), Icons.calendar_today),
        _row('Contract End', _fmt(item.contractEnd), Icons.calendar_today),
        _row('Equity Percent', item.equityPercent?.toString() ?? 'N/A', Icons.numbers),
        _row('Upfront Fee', item.upfrontFee?.toString() ?? 'N/A', Icons.attach_money),
        _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Tier', item.tier?.toString() ?? 'N/A', Icons.text_fields),
        _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
        _row('Agency Name', item.agencyName?.toString() ?? 'N/A', Icons.person),
        _row('Agency Contact', item.agencyContact?.toString() ?? 'N/A', Icons.text_fields),
        _row('Nda Signed', (item.ndaSigned == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Nda Signed At', _fmt(item.ndaSignedAt), Icons.calendar_today),
        _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
        _row('Pitch Sent At', _fmt(item.pitchSentAt), Icons.calendar_today),
        _row('Responded At', _fmt(item.respondedAt), Icons.calendar_today),
        _row('Signed At', _fmt(item.signedAt), Icons.calendar_today),
        _row('Actual Reach', item.actualReach?.toString() ?? 'N/A', Icons.numbers),
        _row('Total Roi', item.totalRoi?.toString() ?? 'N/A', Icons.attach_money),
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