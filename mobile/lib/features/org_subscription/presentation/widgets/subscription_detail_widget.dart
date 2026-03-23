import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Subscription Detail Widget ──

class SubscriptionDetailWidget extends StatelessWidget {
  final Subscription item;
  const SubscriptionDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
        _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Price', item.price?.toString() ?? 'N/A', Icons.attach_money),
        _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Billing Cycle', item.billingCycle?.toString() ?? 'N/A', Icons.text_fields),
        _row('Max Properties', item.maxProperties?.toString() ?? 'N/A', Icons.numbers),
        _row('Max Listings', item.maxListings?.toString() ?? 'N/A', Icons.numbers),
        _row('Featured Listings', item.featuredListings?.toString() ?? 'N/A', Icons.numbers),
        _row('Priority Support', (item.prioritySupport == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Api Access', (item.apiAccess == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Commission Discount', item.commissionDiscount?.toString() ?? 'N/A', Icons.numbers),
        _row('Loyalty Multiplier', item.loyaltyMultiplier?.toString() ?? 'N/A', Icons.numbers),
        _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('User Subscriptions', item.userSubscriptions?.toString() ?? 'N/A', Icons.text_fields),
        _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
}
