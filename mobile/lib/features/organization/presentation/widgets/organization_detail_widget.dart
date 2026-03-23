import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Organization Detail Widget  |  18 fields

class OrganizationDetailWidget extends StatelessWidget {
  final Organization item;
  const OrganizationDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Region', item.region?.toString() ?? 'N/A', Icons.text_fields),
        _row('Default Currency', item.defaultCurrency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Default Locale', item.defaultLocale?.toString() ?? 'N/A', Icons.text_fields),
        _row('Legal Name', item.legalName?.toString() ?? 'N/A', Icons.person),
        _row('Tax Id', item.taxId?.toString() ?? 'N/A', Icons.link),
        _row('Address', item.address?.toString() ?? 'N/A', Icons.location_on),
        _row('Contact Email', item.contactEmail?.toString() ?? 'N/A', Icons.email),
        _row('Management Fee Type', item.managementFeeType?.toString() ?? 'N/A', Icons.attach_money),
        _row('Management Fee Rate', item.managementFeeRate?.toString() ?? 'N/A', Icons.attach_money),
        _row('Management Fee Amount', item.managementFeeAmount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Management Fee Scope', item.managementFeeScope?.toString() ?? 'N/A', Icons.attach_money),
        _row('Tax Reporting Enabled', (item.taxReportingEnabled == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Compliance Tracking', (item.complianceTracking == true ? 'Yes' : 'No'), Icons.toggle_on),
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