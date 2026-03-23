import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Availability Detail Widget  |  26 fields

class AvailabilityDetailWidget extends StatelessWidget {
  final Availability item;
  const AvailabilityDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Date', _fmt(item.date), Icons.calendar_today),
        _row('Is Blocked', (item.isBlocked == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Is Booked', (item.isBooked == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Reservation Id', item.reservationId?.toString() ?? 'N/A', Icons.link),
        _row('Pricing Rule Id', item.pricingRuleId?.toString() ?? 'N/A', Icons.link),
        _row('Total Units', item.totalUnits?.toString() ?? 'N/A', Icons.attach_money),
        _row('Available Units', item.availableUnits?.toString() ?? 'N/A', Icons.numbers),
        _row('Booked Units', item.bookedUnits?.toString() ?? 'N/A', Icons.numbers),
        _row('Blocked Units', item.blockedUnits?.toString() ?? 'N/A', Icons.numbers),
        _row('Special Pricing', item.specialPricing?.toString() ?? 'N/A', Icons.text_fields),
        _row('Base Price', item.basePrice?.toString() ?? 'N/A', Icons.attach_money),
        _row('Current Price', item.currentPrice?.toString() ?? 'N/A', Icons.attach_money),
        _row('Price Settings', item.priceSettings?.toString() ?? 'N/A', Icons.attach_money),
        _row('Min Nights', item.minNights?.toString() ?? 'N/A', Icons.numbers),
        _row('Max Nights', item.maxNights?.toString() ?? 'N/A', Icons.numbers),
        _row('Max Guests', item.maxGuests?.toString() ?? 'N/A', Icons.numbers),
        _row('Discount Settings', item.discountSettings?.toString() ?? 'N/A', Icons.text_fields),
        _row('Weekend Rate', item.weekendRate?.toString() ?? 'N/A', Icons.attach_money),
        _row('Weekday Rate', item.weekdayRate?.toString() ?? 'N/A', Icons.attach_money),
        _row('Weekend Multiplier', item.weekendMultiplier?.toString() ?? 'N/A', Icons.numbers),
        _row('Weekday Multiplier', item.weekdayMultiplier?.toString() ?? 'N/A', Icons.numbers),
        _row('Seasonal Multiplier', item.seasonalMultiplier?.toString() ?? 'N/A', Icons.numbers),
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