import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AISentimentAnalysis Detail Widget  |  12 fields

class AISentimentAnalysisDetailWidget extends StatelessWidget {
  final AISentimentAnalysis item;
  const AISentimentAnalysisDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Content Type', item.contentType?.toString() ?? 'N/A', Icons.notes),
        _row('Content Id', item.contentId?.toString() ?? 'N/A', Icons.link),
        _row('Content Text', item.contentText?.toString() ?? 'N/A', Icons.notes),
        _row('Sentiment', item.sentiment?.toString() ?? 'N/A', Icons.text_fields),
        _row('Sentiment Score', item.sentimentScore?.toString() ?? 'N/A', Icons.numbers),
        _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
        _row('Key Phrases', item.keyPhrases?.toString() ?? 'N/A', Icons.text_fields),
        _row('Emotions', item.emotions?.toString() ?? 'N/A', Icons.text_fields),
        _row('Analyzed At', _fmt(item.analyzedAt), Icons.calendar_today),
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