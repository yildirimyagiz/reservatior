import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── InvestorPortfolio Detail Widget  |  10 fields

class InvestorPortfolioDetailWidget extends StatelessWidget {
  final InvestorPortfolio item;
  const InvestorPortfolioDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
        _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
        _row('Target Irr', item.targetIrr?.toString() ?? 'N/A', Icons.numbers),
        _row('Risk Tolerance', item.riskTolerance?.toString() ?? 'N/A', Icons.text_fields),
        _row('Investment Horizon', item.investmentHorizon?.toString() ?? 'N/A', Icons.text_fields),
        _row('Total Invested', item.totalInvested?.toString() ?? 'N/A', Icons.attach_money),
        _row('Current Value', item.currentValue?.toString() ?? 'N/A', Icons.numbers),
        _row('Total Returns', item.totalReturns?.toString() ?? 'N/A', Icons.attach_money),
        _row('Organization Id', item.organizationId?.toString() ?? 'N/A', Icons.link),
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