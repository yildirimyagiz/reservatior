import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── GuestProfile Detail Widget  |  9 fields

class GuestProfileDetailWidget extends StatelessWidget {
  final GuestProfile item;
  const GuestProfileDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Contact Id', item.contactId?.toString() ?? 'N/A', Icons.link),
        _row('Preferred Check In Time', item.preferredCheckInTime?.toString() ?? 'N/A', Icons.text_fields),
        _row('Preferred Amenities', item.preferredAmenities?.join(', ') ?? 'N/A', Icons.star_outline),
        _row('Dietary Restrictions', item.dietaryRestrictions?.toString() ?? 'N/A', Icons.text_fields),
        _row('Accessibility Needs', item.accessibilityNeeds?.toString() ?? 'N/A', Icons.text_fields),
        _row('Loyalty Points', item.loyaltyPoints?.toString() ?? 'N/A', Icons.numbers),
        _row('Lifetime Spent', item.lifetimeSpent?.toString() ?? 'N/A', Icons.numbers),
        _row('Booking Count', item.bookingCount?.toString() ?? 'N/A', Icons.numbers),
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