import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ExternalRentalListing Detail Widget  |  33 fields

class ExternalRentalListingDetailWidget extends StatelessWidget {
  final ExternalRentalListing item;
  const ExternalRentalListingDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      if (item.status != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Chip(
            avatar: const Icon(Icons.info_outline, size: 16),
            label: Text(item.status!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: _stColor(item.status).withOpacity(0.15),
          ),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Integration Id', item.integrationId?.toString() ?? 'N/A', Icons.link),
        _row('Platform', item.platform?.toString() ?? 'N/A', Icons.text_fields),
        _row('External Id', item.externalId?.toString() ?? 'N/A', Icons.link),
        _row('External Url', item.externalUrl?.toString() ?? 'N/A', Icons.text_fields),
        _row('Title', item.title?.toString() ?? 'N/A', Icons.text_fields),
        _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
        _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
        _row('Address', item.address?.toString() ?? 'N/A', Icons.location_on),
        _row('City', item.city?.toString() ?? 'N/A', Icons.location_on),
        _row('State', item.state?.toString() ?? 'N/A', Icons.text_fields),
        _row('Zip', item.zip?.toString() ?? 'N/A', Icons.location_on),
        _row('Country', item.country?.toString() ?? 'N/A', Icons.location_on),
        _row('Latitude', item.latitude?.toString() ?? 'N/A', Icons.numbers),
        _row('Longitude', item.longitude?.toString() ?? 'N/A', Icons.numbers),
        _row('Nightly Rate', item.nightlyRate?.toString() ?? 'N/A', Icons.attach_money),
        _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Cleaning Fee', item.cleaningFee?.toString() ?? 'N/A', Icons.attach_money),
        _row('Service Fee', item.serviceFee?.toString() ?? 'N/A', Icons.attach_money),
        _row('Check In Time', item.checkInTime?.toString() ?? 'N/A', Icons.text_fields),
        _row('Check Out Time', item.checkOutTime?.toString() ?? 'N/A', Icons.text_fields),
        _row('Min Stay', item.minStay?.toString() ?? 'N/A', Icons.numbers),
        _row('Max Stay', item.maxStay?.toString() ?? 'N/A', Icons.numbers),
        _row('Bedrooms', item.bedrooms?.toString() ?? 'N/A', Icons.numbers),
        _row('Bathrooms', item.bathrooms?.toString() ?? 'N/A', Icons.numbers),
        _row('Max Guests', item.maxGuests?.toString() ?? 'N/A', Icons.numbers),
        _row('Raw Data', item.rawData?.toString() ?? 'N/A', Icons.text_fields),
        _row('Last Synced At', _fmt(item.lastSyncedAt), Icons.calendar_today),
        _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
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