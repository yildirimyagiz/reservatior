import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIPropertyDescription Detail Widget  |  16 fields

class AIPropertyDescriptionDetailWidget extends StatelessWidget {
  final AIPropertyDescription item;
  const AIPropertyDescriptionDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Generated Description', item.generatedDescription?.toString() ?? 'N/A', Icons.attach_money),
        _row('Original Description', item.originalDescription?.toString() ?? 'N/A', Icons.notes),
        _row('Tone', item.tone?.toString() ?? 'N/A', Icons.text_fields),
        _row('Target Audience', item.targetAudience?.toString() ?? 'N/A', Icons.text_fields),
        _row('Key Features', item.keyFeatures?.toString() ?? 'N/A', Icons.text_fields),
        _row('Seo Keywords', item.seoKeywords?.toString() ?? 'N/A', Icons.text_fields),
        _row('Quality Score', item.qualityScore?.toString() ?? 'N/A', Icons.numbers),
        _row('Generated At', _fmt(item.generatedAt), Icons.attach_money),
        _row('Is Approved', (item.isApproved == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Approved By', item.approvedBy?.toString() ?? 'N/A', Icons.text_fields),
        _row('Approved At', _fmt(item.approvedAt), Icons.calendar_today),
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