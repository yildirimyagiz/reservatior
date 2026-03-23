import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIImageAnalysis Detail Widget  |  14 fields

class AIImageAnalysisDetailWidget extends StatelessWidget {
  final AIImageAnalysis item;
  const AIImageAnalysisDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Photo Id', item.photoId?.toString() ?? 'N/A', Icons.link),
        _row('Analysis Type', item.analysisType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Detected Rooms', item.detectedRooms?.toString() ?? 'N/A', Icons.text_fields),
        _row('Quality Score', item.qualityScore?.toString() ?? 'N/A', Icons.numbers),
        _row('Style Tags', item.styleTags?.toString() ?? 'N/A', Icons.text_fields),
        _row('Color Palette', item.colorPalette?.toString() ?? 'N/A', Icons.text_fields),
        _row('Lighting Quality', item.lightingQuality?.toString() ?? 'N/A', Icons.numbers),
        _row('Recommendations', item.recommendations?.toString() ?? 'N/A', Icons.text_fields),
        _row('Analyzed At', _fmt(item.analyzedAt), Icons.calendar_today),
        _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
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