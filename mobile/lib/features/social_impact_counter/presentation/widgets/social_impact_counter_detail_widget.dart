import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SocialImpactCounter Detail Widget  |  12 fields

class SocialImpactCounterDetailWidget extends StatelessWidget {
  final SocialImpactCounter item;
  const SocialImpactCounterDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Impact Type', item.impactType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Partner Name', item.partnerName?.toString() ?? 'N/A', Icons.person),
        _row('Partner Url', item.partnerUrl?.toString() ?? 'N/A', Icons.text_fields),
        _row('Partner Org Id', item.partnerOrgId?.toString() ?? 'N/A', Icons.link),
        _row('Campaign Tag', item.campaignTag?.toString() ?? 'N/A', Icons.text_fields),
        _row('Is Public', (item.isPublic == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Display Goal', item.displayGoal?.toString() ?? 'N/A', Icons.numbers),
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