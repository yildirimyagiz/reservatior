import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── VacationRental Detail Widget  |  28 fields

class VacationRentalDetailWidget extends StatelessWidget {
  final VacationRental item;
  const VacationRentalDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
        _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Rental Type', item.rentalType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Instant Booking', (item.instantBooking == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Base Nightly Rate', item.baseNightlyRate?.toString() ?? 'N/A', Icons.attach_money),
        _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Cleaning Fee', item.cleaningFee?.toString() ?? 'N/A', Icons.attach_money),
        _row('Security Deposit', item.securityDeposit?.toString() ?? 'N/A', Icons.numbers),
        _row('Weekly Discount', item.weeklyDiscount?.toString() ?? 'N/A', Icons.numbers),
        _row('Monthly Discount', item.monthlyDiscount?.toString() ?? 'N/A', Icons.numbers),
        _row('Check In Time', item.checkInTime?.toString() ?? 'N/A', Icons.text_fields),
        _row('Check Out Time', item.checkOutTime?.toString() ?? 'N/A', Icons.text_fields),
        _row('Min Stay Nights', item.minStayNights?.toString() ?? 'N/A', Icons.numbers),
        _row('Max Stay Nights', item.maxStayNights?.toString() ?? 'N/A', Icons.numbers),
        _row('Advance Booking Days', item.advanceBookingDays?.toString() ?? 'N/A', Icons.numbers),
        _row('Max Guests', item.maxGuests?.toString() ?? 'N/A', Icons.numbers),
        _row('Children Allowed', (item.childrenAllowed == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Pets Allowed', (item.petsAllowed == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Smoking Allowed', (item.smokingAllowed == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Events Allowed', (item.eventsAllowed == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('House Rules', item.houseRules?.toString() ?? 'N/A', Icons.text_fields),
        _row('Cancellation Policy', item.cancellationPolicy?.toString() ?? 'N/A', Icons.text_fields),
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