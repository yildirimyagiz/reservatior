import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── InvestorProperty Detail Widget  |  10 fields

class InvestorPropertyDetailWidget extends StatelessWidget {
  final InvestorProperty item;
  const InvestorPropertyDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Portfolio Id', item.portfolioId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Acquired At', _fmt(item.acquiredAt), Icons.calendar_today),
        _row('Acquired Cost', item.acquiredCost?.toString() ?? 'N/A', Icons.attach_money),
        _row('Mortgage Balance', item.mortgageBalance?.toString() ?? 'N/A', Icons.attach_money),
        _row('Mortgage Rate', item.mortgageRate?.toString() ?? 'N/A', Icons.attach_money),
        _row('Mortgage Term', item.mortgageTerm?.toString() ?? 'N/A', Icons.numbers),
        _row('Insurance Provider', item.insuranceProvider?.toString() ?? 'N/A', Icons.text_fields),
        _row('Insurance Amount', item.insuranceAmount?.toString() ?? 'N/A', Icons.attach_money),
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