import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Payment Detail Widget ──

class PaymentDetailWidget extends StatelessWidget {
  final Payment item;
  const PaymentDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      // Status badge
      if (item.status != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(children: [
            const Icon(Icons.info_outline, size: 18, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Chip(
              label: Text(item.status!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
              backgroundColor: _stColor(item.status).withOpacity(0.15),
            ),
          ]),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Tenant Id', item.tenantId?.toString() ?? 'N/A', Icons.link),
        _row('Lease Id', item.leaseId?.toString() ?? 'N/A', Icons.link),
        _row('Amount', item.amount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Currency Id', item.currencyId?.toString() ?? 'N/A', Icons.link),
        _row('Payment Date', _fmt(item.paymentDate), Icons.calendar_today),
        _row('Due Date', _fmt(item.dueDate), Icons.calendar_today),
        _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
        _row('Payment Method', item.paymentMethod?.toString() ?? 'N/A', Icons.text_fields),
        _row('Reference', item.reference?.toString() ?? 'N/A', Icons.text_fields),
        _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
        _row('Stripe Payment Intent Id', item.stripePaymentIntentId?.toString() ?? 'N/A', Icons.link),
        _row('Stripe Payment Method Id', item.stripePaymentMethodId?.toString() ?? 'N/A', Icons.link),
        _row('Stripe Client Secret', item.stripeClientSecret?.toString() ?? 'N/A', Icons.text_fields),
        _row('Stripe Status', item.stripeStatus?.toString() ?? 'N/A', Icons.info_outline),
        _row('Stripe Error', item.stripeError?.toString() ?? 'N/A', Icons.text_fields),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Expense Id', item.expenseId?.toString() ?? 'N/A', Icons.link),
        _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
        _row('Subscription Id', item.subscriptionId?.toString() ?? 'N/A', Icons.link),
        _row('Commission Rule Id', item.commissionRuleId?.toString() ?? 'N/A', Icons.link),
        _row('Included Service Id', item.includedServiceId?.toString() ?? 'N/A', Icons.link),
        _row('Extra Charge Id', item.extraChargeId?.toString() ?? 'N/A', Icons.link),
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
