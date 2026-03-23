import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Achievement Detail Widget  |  12 fields

class AchievementDetailWidget extends StatelessWidget {
  final Achievement item;
  const AchievementDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('User Id', item.userId?.toString() ?? 'N/A', Icons.link),
        _row('Goal Type', item.goalType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Goal Value', item.goalValue?.toString() ?? 'N/A', Icons.numbers),
        _row('Current Value', item.currentValue?.toString() ?? 'N/A', Icons.numbers),
        _row('Is Completed', (item.isCompleted == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Completed At', _fmt(item.completedAt), Icons.calendar_today),
        _row('Points Reward', item.pointsReward?.toString() ?? 'N/A', Icons.numbers),
        _row('Bonus Reward', item.bonusReward?.toString() ?? 'N/A', Icons.text_fields),
        _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
        _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
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