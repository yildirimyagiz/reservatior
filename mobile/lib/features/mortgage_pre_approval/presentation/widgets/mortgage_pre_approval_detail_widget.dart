import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MortgagePreApproval Detail Widget  |  23 fields

class MortgagePreApprovalDetailWidget extends StatelessWidget {
  final MortgagePreApproval item;
  const MortgagePreApprovalDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      if (item.offerStatus != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Chip(
            avatar: const Icon(Icons.info_outline, size: 16),
            label: Text(item.offerStatus!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: _stColor(item.offerStatus).withOpacity(0.15),
          ),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Deal Id', item.dealId?.toString() ?? 'N/A', Icons.link),
        _row('Contact Id', item.contactId?.toString() ?? 'N/A', Icons.link),
        _row('Lender Name', item.lenderName?.toString() ?? 'N/A', Icons.person),
        _row('Mortgage Type', item.mortgageType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Mortgage Term', item.mortgageTerm?.toString() ?? 'N/A', Icons.numbers),
        _row('Interest Rate', item.interestRate?.toString() ?? 'N/A', Icons.attach_money),
        _row('Arrangement Fee', item.arrangementFee?.toString() ?? 'N/A', Icons.attach_money),
        _row('Valuation Fee', item.valuationFee?.toString() ?? 'N/A', Icons.attach_money),
        _row('Loan Amount', item.loanAmount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Deposit Amount', item.depositAmount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Loan To Value', item.loanToValue?.toString() ?? 'N/A', Icons.numbers),
        _row('Monthly Payment', item.monthlyPayment?.toString() ?? 'N/A', Icons.numbers),
        _row('Total Payable', item.totalPayable?.toString() ?? 'N/A', Icons.attach_money),
        _row('Offer Status', item.offerStatus?.toString() ?? 'N/A', Icons.info_outline),
        _row('Offer Date', _fmt(item.offerDate), Icons.calendar_today),
        _row('Expiry Date', _fmt(item.expiryDate), Icons.calendar_today),
        _row('Accepted Date', _fmt(item.acceptedDate), Icons.calendar_today),
        _row('Solicitor Name', item.solicitorName?.toString() ?? 'N/A', Icons.person),
        _row('Solicitor Email', item.solicitorEmail?.toString() ?? 'N/A', Icons.email),
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
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}