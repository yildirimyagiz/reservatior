import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Payout Detail Widget  |  40 fields

class PayoutDetailWidget extends StatelessWidget {
  final Payout item;
  const PayoutDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      if (item.payoutStatus != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Chip(
            avatar: const Icon(Icons.info_outline, size: 16),
            label: Text(item.payoutStatus!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: _stColor(item.payoutStatus).withOpacity(0.15),
          ),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Deal Id', item.dealId?.toString() ?? 'N/A', Icons.link),
        _row('Commission Id', item.commissionId?.toString() ?? 'N/A', Icons.link),
        _row('Recipient Id', item.recipientId?.toString() ?? 'N/A', Icons.link),
        _row('Processor Id', item.processorId?.toString() ?? 'N/A', Icons.link),
        _row('Payout Status', item.payoutStatus?.toString() ?? 'N/A', Icons.info_outline),
        _row('Payout Type', item.payoutType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Amount', item.amount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Gross Amount', item.grossAmount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Net Amount', item.netAmount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Tax Withheld', item.taxWithheld?.toString() ?? 'N/A', Icons.numbers),
        _row('Fees', item.fees?.toString() ?? 'N/A', Icons.attach_money),
        _row('Payment Method', item.paymentMethod?.toString() ?? 'N/A', Icons.text_fields),
        _row('Scheduled Date', _fmt(item.scheduledDate), Icons.calendar_today),
        _row('Processed Date', _fmt(item.processedDate), Icons.calendar_today),
        _row('Completed Date', _fmt(item.completedDate), Icons.calendar_today),
        _row('Reference Number', item.referenceNumber?.toString() ?? 'N/A', Icons.text_fields),
        _row('Tracking Number', item.trackingNumber?.toString() ?? 'N/A', Icons.text_fields),
        _row('Bank Account', item.bankAccount?.toString() ?? 'N/A', Icons.text_fields),
        _row('Check Number', item.checkNumber?.toString() ?? 'N/A', Icons.text_fields),
        _row('Wire Reference', item.wireReference?.toString() ?? 'N/A', Icons.text_fields),
        _row('Ach Routing', item.achRouting?.toString() ?? 'N/A', Icons.text_fields),
        _row('Escrow Release Date', _fmt(item.escrowReleaseDate), Icons.calendar_today),
        _row('Hold Reason', item.holdReason?.toString() ?? 'N/A', Icons.text_fields),
        _row('Failure Reason', item.failureReason?.toString() ?? 'N/A', Icons.text_fields),
        _row('Retry Count', item.retryCount?.toString() ?? 'N/A', Icons.numbers),
        _row('Max Retries', item.maxRetries?.toString() ?? 'N/A', Icons.numbers),
        _row('Next Retry Date', _fmt(item.nextRetryDate), Icons.calendar_today),
        _row('Priority', item.priority?.toString() ?? 'N/A', Icons.text_fields),
        _row('Approval Required', (item.approvalRequired == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Approved By', item.approvedBy?.toString() ?? 'N/A', Icons.text_fields),
        _row('Approved At', _fmt(item.approvedAt), Icons.calendar_today),
        _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
        _row('Tax Form Generated', (item.taxFormGenerated == true ? 'Yes' : 'No'), Icons.attach_money),
        _row('Tax Form Sent', (item.taxFormSent == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Year End Report', (item.yearEndReport == true ? 'Yes' : 'No'), Icons.toggle_on),
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
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}