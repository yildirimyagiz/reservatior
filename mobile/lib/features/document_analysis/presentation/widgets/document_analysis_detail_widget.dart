import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── DocumentAnalysis Detail Widget  |  11 fields

class DocumentAnalysisDetailWidget extends StatelessWidget {
  final DocumentAnalysis item;
  const DocumentAnalysisDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Document Id', item.documentId?.toString() ?? 'N/A', Icons.link),
        _row('Job Id', item.jobId?.toString() ?? 'N/A', Icons.link),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Extracted Text', item.extractedText?.toString() ?? 'N/A', Icons.text_fields),
        _row('Metadata', item.metadata?.toString() ?? 'N/A', Icons.text_fields),
        _row('Classification', item.classification?.toString() ?? 'N/A', Icons.text_fields),
        _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
        _row('Processing Time', item.processingTime?.toString() ?? 'N/A', Icons.numbers),
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