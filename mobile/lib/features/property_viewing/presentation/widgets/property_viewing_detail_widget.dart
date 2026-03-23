import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyViewing Detail Widget  |  19 fields

class PropertyViewingDetailWidget extends StatelessWidget {
  final PropertyViewing item;
  const PropertyViewingDetailWidget({super.key, required this.item});

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
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
        _row('Viewing Type', item.viewingType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Scheduled Date', _fmt(item.scheduledDate), Icons.calendar_today),
        _row('Duration', item.duration?.toString() ?? 'N/A', Icons.numbers),
        _row('Attendee Name', item.attendeeName?.toString() ?? 'N/A', Icons.person),
        _row('Attendee Email', item.attendeeEmail?.toString() ?? 'N/A', Icons.email),
        _row('Attendee Phone', item.attendeePhone?.toString() ?? 'N/A', Icons.phone),
        _row('Attendee Type', item.attendeeType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
        _row('Assigned Agent Id', item.assignedAgentId?.toString() ?? 'N/A', Icons.link),
        _row('Feedback', item.feedback?.toString() ?? 'N/A', Icons.attach_money),
        _row('Interested Level', item.interestedLevel?.toString() ?? 'N/A', Icons.text_fields),
        _row('Follow Up Required', (item.followUpRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Follow Up Notes', item.followUpNotes?.toString() ?? 'N/A', Icons.notes),
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