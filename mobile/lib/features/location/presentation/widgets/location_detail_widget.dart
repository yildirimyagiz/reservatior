import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Location Detail Widget ──

class LocationDetailWidget extends StatelessWidget {
  final Location item;
  const LocationDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      // Status badge
      if (item.geocodingStatus != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(children: [
            const Icon(Icons.info_outline, size: 18, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Chip(
              label: Text(item.geocodingStatus!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
              backgroundColor: _stColor(item.geocodingStatus).withOpacity(0.15),
            ),
          ]),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Property Id', item.propertyId?.toString() ?? 'N/A', Icons.link),
        _row('Listing Id', item.listingId?.toString() ?? 'N/A', Icons.link),
        _row('Deal Id', item.dealId?.toString() ?? 'N/A', Icons.link),
        _row('Address Line1', item.addressLine1?.toString() ?? 'N/A', Icons.location_on),
        _row('Address Line2', item.addressLine2?.toString() ?? 'N/A', Icons.location_on),
        _row('Address Line3', item.addressLine3?.toString() ?? 'N/A', Icons.location_on),
        _row('City', item.city?.toString() ?? 'N/A', Icons.location_on),
        _row('State', item.state?.toString() ?? 'N/A', Icons.text_fields),
        _row('Zip', item.zip?.toString() ?? 'N/A', Icons.location_on),
        _row('Zip Plus4', item.zipPlus4?.toString() ?? 'N/A', Icons.location_on),
        _row('Country', item.country?.toString() ?? 'N/A', Icons.location_on),
        _row('State Name', item.stateName?.toString() ?? 'N/A', Icons.person),
        _row('State F I P S', item.stateFIPS?.toString() ?? 'N/A', Icons.text_fields),
        _row('Census Tract', item.censusTract?.toString() ?? 'N/A', Icons.text_fields),
        _row('Block Group', item.blockGroup?.toString() ?? 'N/A', Icons.text_fields),
        _row('Precinct', item.precinct?.toString() ?? 'N/A', Icons.text_fields),
        _row('School District', item.schoolDistrict?.toString() ?? 'N/A', Icons.text_fields),
        _row('Congressional District', item.congressionalDistrict?.toString() ?? 'N/A', Icons.text_fields),
        _row('Latitude', item.latitude?.toString() ?? 'N/A', Icons.numbers),
        _row('Longitude', item.longitude?.toString() ?? 'N/A', Icons.numbers),
        _row('Accuracy', item.accuracy?.toString() ?? 'N/A', Icons.text_fields),
        _row('Altitude', item.altitude?.toString() ?? 'N/A', Icons.numbers),
        _row('Elevation', item.elevation?.toString() ?? 'N/A', Icons.numbers),
        _row('Geocoding Status', item.geocodingStatus?.toString() ?? 'N/A', Icons.info_outline),
        _row('Geocoded At', _fmt(item.geocodedAt), Icons.calendar_today),
        _row('Geocoding Provider', item.geocodingProvider?.toString() ?? 'N/A', Icons.text_fields),
        _row('Confidence Score', item.confidenceScore?.toString() ?? 'N/A', Icons.numbers),
        _row('Is Verified', (item.isVerified == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Verified At', _fmt(item.verifiedAt), Icons.calendar_today),
        _row('Verified By', item.verifiedBy?.toString() ?? 'N/A', Icons.text_fields),
        _row('Usps Verified', (item.uspsVerified == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Usps Verified At', _fmt(item.uspsVerifiedAt), Icons.calendar_today),
        _row('Dpv Confirmation', item.dpvConfirmation?.toString() ?? 'N/A', Icons.text_fields),
        _row('Footnotes', item.footnotes?.toString() ?? 'N/A', Icons.notes),
        _row('Is Standardized', (item.isStandardized == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Is Residential', (item.isResidential == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Is Commercial', (item.isCommercial == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Is Valid', (item.isValid == true ? 'Yes' : 'No'), Icons.link),
        _row('Marker Type', item.markerType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Marker Icon', item.markerIcon?.toString() ?? 'N/A', Icons.text_fields),
        _row('Marker Color', item.markerColor?.toString() ?? 'N/A', Icons.text_fields),
        _row('Marker Size', item.markerSize?.toString() ?? 'N/A', Icons.numbers),
        _row('Is Visible', (item.isVisible == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Z Index', item.zIndex?.toString() ?? 'N/A', Icons.numbers),
        _row('Opacity', item.opacity?.toString() ?? 'N/A', Icons.location_on),
        _row('Title', item.title?.toString() ?? 'N/A', Icons.text_fields),
        _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
        _row('Image Url', item.imageUrl?.toString() ?? 'N/A', Icons.link),
        _row('Link Url', item.linkUrl?.toString() ?? 'N/A', Icons.link),
        _row('Category', item.category?.toString() ?? 'N/A', Icons.text_fields),
        _row('Monday Open', item.mondayOpen?.toString() ?? 'N/A', Icons.text_fields),
        _row('Monday Close', item.mondayClose?.toString() ?? 'N/A', Icons.text_fields),
        _row('Tuesday Open', item.tuesdayOpen?.toString() ?? 'N/A', Icons.text_fields),
        _row('Tuesday Close', item.tuesdayClose?.toString() ?? 'N/A', Icons.text_fields),
        _row('Wednesday Open', item.wednesdayOpen?.toString() ?? 'N/A', Icons.text_fields),
        _row('Wednesday Close', item.wednesdayClose?.toString() ?? 'N/A', Icons.text_fields),
        _row('Thursday Open', item.thursdayOpen?.toString() ?? 'N/A', Icons.text_fields),
        _row('Thursday Close', item.thursdayClose?.toString() ?? 'N/A', Icons.text_fields),
        _row('Friday Open', item.fridayOpen?.toString() ?? 'N/A', Icons.text_fields),
        _row('Friday Close', item.fridayClose?.toString() ?? 'N/A', Icons.text_fields),
        _row('Saturday Open', item.saturdayOpen?.toString() ?? 'N/A', Icons.text_fields),
        _row('Saturday Close', item.saturdayClose?.toString() ?? 'N/A', Icons.text_fields),
        _row('Sunday Open', item.sundayOpen?.toString() ?? 'N/A', Icons.text_fields),
        _row('Sunday Close', item.sundayClose?.toString() ?? 'N/A', Icons.text_fields),
        _row('Metadata', item.metadata?.toString() ?? 'N/A', Icons.text_fields),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')} ${d.hour.toString().padLeft(2,'0')}:${d.minute.toString().padLeft(2,'0')}';
}
