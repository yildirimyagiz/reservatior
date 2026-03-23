import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Document Detail Widget ──

class DocumentDetailWidget extends StatelessWidget {
  final Document item;
  const DocumentDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      // Status badge
      if (item.analysisStatus != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(children: [
            const Icon(Icons.info_outline, size: 18, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Chip(
              label: Text(item.analysisStatus!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
              backgroundColor: _stColor(item.analysisStatus).withOpacity(0.15),
            ),
          ]),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Deal Id', item.dealId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Contract Id', item.contractId?.toString() ?? 'N/A', Icons.link),
        _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
        _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
        _row('Document Type', item.documentType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Title', item.title?.toString() ?? 'N/A', Icons.text_fields),
        _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
        _row('File Url', item.fileUrl?.toString() ?? 'N/A', Icons.link),
        _row('File Name', item.fileName?.toString() ?? 'N/A', Icons.person),
        _row('File Size', item.fileSize?.toString() ?? 'N/A', Icons.numbers),
        _row('Mime Type', item.mimeType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Checksum', item.checksum?.toString() ?? 'N/A', Icons.text_fields),
        _row('Version', item.version?.toString() ?? 'N/A', Icons.numbers),
        _row('Is Required', (item.isRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Is Signed', (item.isSigned == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Signature Required', (item.signatureRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Notarization Required', (item.notarizationRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Recording Required', (item.recordingRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Expiry Date', _fmt(item.expiryDate), Icons.calendar_today),
        _row('Compliance Type', item.complianceType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Jurisdiction', item.jurisdiction?.toString() ?? 'N/A', Icons.link),
        _row('Template Id', item.templateId?.toString() ?? 'N/A', Icons.link),
        _row('Analysis Status', item.analysisStatus?.toString() ?? 'N/A', Icons.info_outline),
        _row('Last Analyzed At', _fmt(item.lastAnalyzedAt), Icons.calendar_today),
        _row('Analysis Job Id', item.analysisJobId?.toString() ?? 'N/A', Icons.link),
        _row('Duplicates', item.duplicates?.toString() ?? 'N/A', Icons.text_fields),
        _row('Search Vector', item.searchVector?.toString() ?? 'N/A', Icons.text_fields),
        _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
}
