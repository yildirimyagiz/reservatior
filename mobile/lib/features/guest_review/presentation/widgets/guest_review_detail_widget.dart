import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── GuestReview Detail Widget  |  14 fields

class GuestReviewDetailWidget extends StatelessWidget {
  final GuestReview item;
  const GuestReviewDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Booking Id', item.bookingId?.toString() ?? 'N/A', Icons.link),
        _row('Guest Id', item.guestId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Rating', item.rating?.toString() ?? 'N/A', Icons.numbers),
        _row('Cleanliness', item.cleanliness?.toString() ?? 'N/A', Icons.numbers),
        _row('Communication', item.communication?.toString() ?? 'N/A', Icons.numbers),
        _row('Check In', item.checkIn?.toString() ?? 'N/A', Icons.numbers),
        _row('Accuracy', item.accuracy?.toString() ?? 'N/A', Icons.numbers),
        _row('Location', item.location?.toString() ?? 'N/A', Icons.location_on),
        _row('Value', item.value?.toString() ?? 'N/A', Icons.numbers),
        _row('Comment', item.comment?.toString() ?? 'N/A', Icons.notes),
        _row('Response', item.response?.toString() ?? 'N/A', Icons.text_fields),
        _row('Is Public', (item.isPublic == true ? 'Yes' : 'No'), Icons.toggle_on),
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