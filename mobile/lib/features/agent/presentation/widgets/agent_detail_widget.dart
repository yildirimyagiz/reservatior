import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Agent Detail Widget  |  26 fields

class AgentDetailWidget extends StatelessWidget {
  final Agent item;
  const AgentDetailWidget({super.key, required this.item});

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
            backgroundColor: _stColor(item.status).withValues(alpha: 0.15),
          ),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
        _row('Email', item.email?.toString() ?? 'N/A', Icons.email),
        _row('Phone Number', item.phoneNumber?.toString() ?? 'N/A', Icons.phone),
        _row('Bio', item.bio?.toString() ?? 'N/A', Icons.text_fields),
        _row('Location Id', item.locationId?.toString() ?? 'N/A', Icons.link),
        _row('Address', item.address?.toString() ?? 'N/A', Icons.location_on),
        _row('Website', item.website?.toString() ?? 'N/A', Icons.text_fields),
        _row('Logo Url', item.logoUrl?.toString() ?? 'N/A', Icons.text_fields),
        _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
        _row('Agency Id', item.agencyId?.toString() ?? 'N/A', Icons.link),
        _row('License Number', item.licenseNumber?.toString() ?? 'N/A', Icons.text_fields),
        _row('Commission Rate', item.commissionRate?.toString() ?? 'N/A', Icons.attach_money),
        _row('Years Of Experience', item.yearsOfExperience?.toString() ?? 'N/A', Icons.numbers),
        _row('Education', item.education?.toString() ?? 'N/A', Icons.text_fields),
        _row('Performance Metrics', item.performanceMetrics?.toString() ?? 'N/A', Icons.text_fields),
        _row('Tax Configuration', item.taxConfiguration?.toString() ?? 'N/A', Icons.text_fields),
        _row('Availability', item.availability?.toString() ?? 'N/A', Icons.text_fields),
        _row('Social Media', item.socialMedia?.toString() ?? 'N/A', Icons.text_fields),
        _row('Settings', item.settings?.toString() ?? 'N/A', Icons.text_fields),
        _row('External Id', item.externalId?.toString() ?? 'N/A', Icons.link),
        _row('Integration', item.integration?.toString() ?? 'N/A', Icons.text_fields),
        _row('Owner Id', item.ownerId?.toString() ?? 'N/A', Icons.link),
        _row('Last Active', _fmt(item.lastActive), Icons.calendar_today),
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