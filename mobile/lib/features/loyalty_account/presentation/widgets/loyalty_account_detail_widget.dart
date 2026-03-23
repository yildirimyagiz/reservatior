import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── LoyaltyAccount Detail Widget  |  22 fields

class LoyaltyAccountDetailWidget extends StatelessWidget {
  final LoyaltyAccount item;
  const LoyaltyAccountDetailWidget({super.key, required this.item});

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
        _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
        _row('Points Per Dollar', item.pointsPerDollar?.toString() ?? 'N/A', Icons.numbers),
        _row('Points Expiry Days', item.pointsExpiryDays?.toString() ?? 'N/A', Icons.numbers),
        _row('Tiers Enabled', (item.tiersEnabled == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Bronze Threshold', item.bronzeThreshold?.toString() ?? 'N/A', Icons.numbers),
        _row('Silver Threshold', item.silverThreshold?.toString() ?? 'N/A', Icons.numbers),
        _row('Gold Threshold', item.goldThreshold?.toString() ?? 'N/A', Icons.numbers),
        _row('Platinum Threshold', item.platinumThreshold?.toString() ?? 'N/A', Icons.numbers),
        _row('Diamond Threshold', item.diamondThreshold?.toString() ?? 'N/A', Icons.numbers),
        _row('Current Points', item.currentPoints?.toString() ?? 'N/A', Icons.numbers),
        _row('Current Tier', item.currentTier?.toString() ?? 'N/A', Icons.text_fields),
        _row('Total Earned', item.totalEarned?.toString() ?? 'N/A', Icons.attach_money),
        _row('Points History', item.pointsHistory?.toString() ?? 'N/A', Icons.text_fields),
        _row('Rewards', item.rewards?.toString() ?? 'N/A', Icons.text_fields),
        _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
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
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}