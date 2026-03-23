import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Property Detail Widget ──

class PropertyDetailWidget extends StatelessWidget {
  final Property item;
  const PropertyDetailWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      // Status badge
      if (item.listingStatus != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(children: [
            const Icon(Icons.info_outline, size: 18, color: Colors.blueGrey),
            const SizedBox(width: 8),
            Chip(
              label: Text(item.listingStatus!.toString(), style: const TextStyle(fontWeight: FontWeight.w600)),
              backgroundColor: _stColor(item.listingStatus).withOpacity(0.15),
            ),
          ]),
        ),
        _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
        _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
        _row('Type', item.type?.toString() ?? 'N/A', Icons.text_fields),
        _row('Name', item.name?.toString() ?? 'N/A', Icons.person),
        _row('Region', item.region?.toString() ?? 'N/A', Icons.text_fields),
        _row('Currency', item.currency?.toString() ?? 'N/A', Icons.text_fields),
        _row('Address Line1', item.addressLine1?.toString() ?? 'N/A', Icons.location_on),
        _row('Address Line2', item.addressLine2?.toString() ?? 'N/A', Icons.location_on),
        _row('City', item.city?.toString() ?? 'N/A', Icons.location_on),
        _row('State', item.state?.toString() ?? 'N/A', Icons.text_fields),
        _row('Zip', item.zip?.toString() ?? 'N/A', Icons.location_on),
        _row('Country', item.country?.toString() ?? 'N/A', Icons.location_on),
        _row('Lat', item.lat?.toString() ?? 'N/A', Icons.numbers),
        _row('Lng', item.lng?.toString() ?? 'N/A', Icons.numbers),
        _row('Neighborhood Id', item.neighborhoodId?.toString() ?? 'N/A', Icons.link),
        _row('Bedrooms', item.bedrooms?.toString() ?? 'N/A', Icons.numbers),
        _row('Bathrooms', item.bathrooms?.toString() ?? 'N/A', Icons.numbers),
        _row('Area Sqm', item.areaSqm?.toString() ?? 'N/A', Icons.numbers),
        _row('Year Built', item.yearBuilt?.toString() ?? 'N/A', Icons.numbers),
        _row('Notes', item.notes?.toString() ?? 'N/A', Icons.notes),
        _row('Location Id', item.locationId?.toString() ?? 'N/A', Icons.link),
        _row('State Code', item.stateCode?.toString() ?? 'N/A', Icons.text_fields),
        _row('Property Category', item.propertyCategory?.toString() ?? 'N/A', Icons.text_fields),
        _row('Listing Type', item.listingType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Listing Status', item.listingStatus?.toString() ?? 'N/A', Icons.info_outline),
        _row('Listing Price', item.listingPrice?.toString() ?? 'N/A', Icons.attach_money),
        _row('Original Price', item.originalPrice?.toString() ?? 'N/A', Icons.attach_money),
        _row('Price History', item.priceHistory?.toString() ?? 'N/A', Icons.attach_money),
        _row('School District', item.schoolDistrict?.toString() ?? 'N/A', Icons.text_fields),
        _row('Hoa Fee', item.hoaFee?.toString() ?? 'N/A', Icons.attach_money),
        _row('Hoa Fee Frequency', item.hoaFeeFrequency?.toString() ?? 'N/A', Icons.attach_money),
        _row('Property Tax Rate', item.propertyTaxRate?.toString() ?? 'N/A', Icons.attach_money),
        _row('Last Assessment Value', item.lastAssessmentValue?.toString() ?? 'N/A', Icons.numbers),
        _row('Last Assessment Year', item.lastAssessmentYear?.toString() ?? 'N/A', Icons.numbers),
        _row('Flood Zone', item.floodZone?.toString() ?? 'N/A', Icons.text_fields),
        _row('Zoning Code', item.zoningCode?.toString() ?? 'N/A', Icons.text_fields),
        _row('Lot Size Acres', item.lotSizeAcres?.toString() ?? 'N/A', Icons.numbers),
        _row('Frontage Feet', item.frontageFeet?.toString() ?? 'N/A', Icons.attach_money),
        _row('Depth Feet', item.depthFeet?.toString() ?? 'N/A', Icons.attach_money),
        _row('Basement Type', item.basementType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Basement Finished Sq Ft', item.basementFinishedSqFt?.toString() ?? 'N/A', Icons.numbers),
        _row('Garage Type', item.garageType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Garage Capacity', item.garageCapacity?.toString() ?? 'N/A', Icons.location_on),
        _row('Parking Spaces', item.parkingSpaces?.toString() ?? 'N/A', Icons.numbers),
        _row('Parking Type', item.parkingType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Pool Type', item.poolType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Heating Type', item.heatingType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Cooling Type', item.coolingType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Fireplace Type', item.fireplaceType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Fireplace Count', item.fireplaceCount?.toString() ?? 'N/A', Icons.numbers),
        _row('View Type', item.viewType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Waterfront Type', item.waterfrontType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Waterfront Feet', item.waterfrontFeet?.toString() ?? 'N/A', Icons.attach_money),
        _row('Construction Type', item.constructionType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Roof Type', item.roofType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Roof Year', item.roofYear?.toString() ?? 'N/A', Icons.numbers),
        _row('Siding Type', item.sidingType?.toString() ?? 'N/A', Icons.text_fields),
        _row('Zip Plus4', item.zipPlus4?.toString() ?? 'N/A', Icons.location_on),
        _row('County F I P S', item.countyFIPS?.toString() ?? 'N/A', Icons.text_fields),
        _row('Census Tract', item.censusTract?.toString() ?? 'N/A', Icons.text_fields),
        _row('Mls Area', item.mlsArea?.toString() ?? 'N/A', Icons.text_fields),
        _row('Property Class', item.propertyClass?.toString() ?? 'N/A', Icons.text_fields),
        _row('Building Class', item.buildingClass?.toString() ?? 'N/A', Icons.text_fields),
        _row('Total Rooms', item.totalRooms?.toString() ?? 'N/A', Icons.attach_money),
        _row('Living Area Sq Ft', item.livingAreaSqFt?.toString() ?? 'N/A', Icons.numbers),
        _row('Lot Size Sq Ft', item.lotSizeSqFt?.toString() ?? 'N/A', Icons.numbers),
        _row('Stories', item.stories?.toString() ?? 'N/A', Icons.numbers),
        _row('Units Per Building', item.unitsPerBuilding?.toString() ?? 'N/A', Icons.numbers),
        _row('Assessed Value', item.assessedValue?.toString() ?? 'N/A', Icons.numbers),
        _row('Market Value', item.marketValue?.toString() ?? 'N/A', Icons.numbers),
        _row('Property Tax', item.propertyTax?.toString() ?? 'N/A', Icons.numbers),
        _row('Insurance Amount', item.insuranceAmount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Mortgage Balance', item.mortgageBalance?.toString() ?? 'N/A', Icons.attach_money),
        _row('Lien Amount', item.lienAmount?.toString() ?? 'N/A', Icons.attach_money),
        _row('Electricity Provider', item.electricityProvider?.toString() ?? 'N/A', Icons.location_on),
        _row('Gas Provider', item.gasProvider?.toString() ?? 'N/A', Icons.text_fields),
        _row('Water Provider', item.waterProvider?.toString() ?? 'N/A', Icons.text_fields),
        _row('Internet Provider', item.internetProvider?.toString() ?? 'N/A', Icons.text_fields),
        _row('Trash Service', item.trashService?.toString() ?? 'N/A', Icons.text_fields),
        _row('Mls Number', item.mlsNumber?.toString() ?? 'N/A', Icons.text_fields),
        _row('Mls Status', item.mlsStatus?.toString() ?? 'N/A', Icons.info_outline),
        _row('Days On Market', item.daysOnMarket?.toString() ?? 'N/A', Icons.numbers),
        _row('Price Per Sq Ft', item.pricePerSqFt?.toString() ?? 'N/A', Icons.attach_money),
        _row('Rental Yield', item.rentalYield?.toString() ?? 'N/A', Icons.numbers),
        _row('Year Renovated', item.yearRenovated?.toString() ?? 'N/A', Icons.numbers),
        _row('Energy Rating', item.energyRating?.toString() ?? 'N/A', Icons.text_fields),
        _row('Zoning Description', item.zoningDescription?.toString() ?? 'N/A', Icons.notes),
        _row('Land Use', item.landUse?.toString() ?? 'N/A', Icons.text_fields),
        _row('Building Restrictions', item.buildingRestrictions?.toString() ?? 'N/A', Icons.text_fields),
        _row('Future Development', item.futureDevelopment?.toString() ?? 'N/A', Icons.text_fields),
        _row('Lead Paint Compliance', (item.leadPaintCompliance == true ? 'Yes' : 'No'), Icons.toggle_on),
        _row('Mold Inspection Date', _fmt(item.moldInspectionDate), Icons.calendar_today),
        _row('Asbestos Inspection Date', _fmt(item.asbestosInspectionDate), Icons.calendar_today),
        _row('Radon Test Date', _fmt(item.radonTestDate), Icons.calendar_today),
        _row('Pest Control Date', _fmt(item.pestControlDate), Icons.calendar_today),
        _row('Fire Inspection Date', _fmt(item.fireInspectionDate), Icons.calendar_today),
        _row('Elevator Inspection Date', _fmt(item.elevatorInspectionDate), Icons.calendar_today),
        _row('Pool Inspection Date', _fmt(item.poolInspectionDate), Icons.calendar_today),
        _row('Last Code Compliance Date', _fmt(item.lastCodeComplianceDate), Icons.calendar_today),
        _row('Accessibility Compliance', (item.accessibilityCompliance == true ? 'Yes' : 'No'), Icons.toggle_on),
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
