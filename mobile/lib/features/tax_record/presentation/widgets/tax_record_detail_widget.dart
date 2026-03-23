import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── TaxRecord Detail Widget  |  18 fields

class TaxRecordDetailWidget extends StatelessWidget {
  final TaxRecord item;
  const TaxRecordDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Profile Id', item.profileId?.toString() ?? 'N/A', Icons.link),
        _row('Transaction Id', item.transactionId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Contact Id', item.contactId?.toString() ?? 'N/A', Icons.link),
        _row('Record Type', item.recordType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Profile Data', item.profileData?.toString() ?? 'N/A', Icons.text_fields),
        _row('Category Data', item.categoryData?.toString() ?? 'N/A', Icons.text_fields),
        _row('Line Item Data', item.lineItemData?.toString() ?? 'N/A', Icons.text_fields),
        _row('Audit Data', item.auditData?.toString() ?? 'N/A', Icons.text_fields),
        _row('Rule Data', item.ruleData?.toString() ?? 'N/A', Icons.text_fields),
        _row('Depreciation Data', item.depreciationData?.toString() ?? 'N/A', Icons.text_fields),
        _row('Form1099 Data', item.form1099Data?.toString() ?? 'N/A', Icons.text_fields),
        _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
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