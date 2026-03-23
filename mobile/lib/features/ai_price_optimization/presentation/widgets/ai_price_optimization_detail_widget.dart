import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIPriceOptimization Detail Widget  |  14 fields

class AIPriceOptimizationDetailWidget extends StatelessWidget {
  final AIPriceOptimization item;
  const AIPriceOptimizationDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
        _row('Current Price', item.currentPrice?.toString() ?? 'N/A', Icons.attach_money),
        _row('Recommended Price', item.recommendedPrice?.toString() ?? 'N/A', Icons.attach_money),
        _row('Price Range', item.priceRange?.toString() ?? 'N/A', Icons.attach_money),
        _row('Factors', item.factors?.toString() ?? 'N/A', Icons.text_fields),
        _row('Comparable Data', item.comparableData?.toString() ?? 'N/A', Icons.text_fields),
        _row('Market Trends', item.marketTrends?.toString() ?? 'N/A', Icons.text_fields),
        _row('Confidence', item.confidence?.toString() ?? 'N/A', Icons.numbers),
        _row('Generated At', _fmt(item.generatedAt), Icons.attach_money),
        _row('Is Applied', (item.isApplied == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Applied At', _fmt(item.appliedAt), Icons.calendar_today),
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