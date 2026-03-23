import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/location_provider.dart';
import '../../../../gen_models/models_library.dart';
import '../widgets/location_form_widget.dart';

// ── Location Client Page

class LocationClientPage extends ConsumerStatefulWidget {
  const LocationClientPage({super.key});
  @override ConsumerState<LocationClientPage> createState() => _LocationClientPageState();
}

class _LocationClientPageState extends ConsumerState<LocationClientPage> {
  final _ctrl = TextEditingController();
  String _q = '';
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(locationListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Locations'),
        backgroundColor: Colors.teal[700], foregroundColor: Colors.white,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.invalidate(locationListProvider)),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12,12,12,4),
          child: TextField(
            controller: _ctrl,
            decoration: InputDecoration(
              hintText: 'Search Locations…',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _q.isNotEmpty
                  ? IconButton(icon: const Icon(Icons.clear), onPressed: () { _ctrl.clear(); setState(() => _q = ''); })
                  : null,
              border: const OutlineInputBorder(), isDense: true,
            ),
            onChanged: (v) => setState(() => _q = v.toLowerCase()),
          ),
        ),
        Expanded(child: async.when(
          data: (items) {
            final list = _q.isEmpty ? items
                : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.listingId?.toString() ?? '') + " " + (item.dealId?.toString() ?? '') + " " + (item.addressLine1?.toString() ?? '') + " " + (item.addressLine2?.toString() ?? '') + " " + (item.addressLine3?.toString() ?? '') + " " + (item.city?.toString() ?? '') + " " + (item.state?.toString() ?? '') + " " + (item.zip?.toString() ?? '') + " " + (item.zipPlus4?.toString() ?? '') + " " + (item.country?.toString() ?? '') + " " + (item.stateName?.toString() ?? '') + " " + (item.stateFIPS?.toString() ?? '') + " " + (item.censusTract?.toString() ?? '') + " " + (item.blockGroup?.toString() ?? '') + " " + (item.precinct?.toString() ?? '') + " " + (item.schoolDistrict?.toString() ?? '') + " " + (item.congressionalDistrict?.toString() ?? '') + " " + (item.verifiedBy?.toString() ?? '') + " " + (item.dpvConfirmation?.toString() ?? '') + " " + (item.footnotes?.toString() ?? '') + " " + (item.markerColor?.toString() ?? '') + " " + (item.title?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.imageUrl?.toString() ?? '') + " " + (item.linkUrl?.toString() ?? '') + " " + (item.category?.toString() ?? '') + " " + (item.mondayOpen?.toString() ?? '') + " " + (item.mondayClose?.toString() ?? '') + " " + (item.tuesdayOpen?.toString() ?? '') + " " + (item.tuesdayClose?.toString() ?? '') + " " + (item.wednesdayOpen?.toString() ?? '') + " " + (item.wednesdayClose?.toString() ?? '') + " " + (item.thursdayOpen?.toString() ?? '') + " " + (item.thursdayClose?.toString() ?? '') + " " + (item.fridayOpen?.toString() ?? '') + " " + (item.fridayClose?.toString() ?? '') + " " + (item.saturdayOpen?.toString() ?? '') + " " + (item.saturdayClose?.toString() ?? '') + " " + (item.sundayOpen?.toString() ?? '') + " " + (item.sundayClose?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
            if (list.isEmpty) {
              return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
                const SizedBox(height: 12),
                Text('No Locations', style: TextStyle(color: Colors.grey[500])),
              ]));
            }
            return RefreshIndicator(
              onRefresh: () async => ref.invalidate(locationListProvider),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(12,4,12,88),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final item = list[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      leading: CircleAvatar(backgroundColor: _stColor(item.geocodingStatus), foregroundColor: Colors.white, child: Text(item.title != null && item.title!.toString().isNotEmpty ? item.title!.toString()[0].toUpperCase() : '?'),),
                      title: Text(item.title ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('Created At: ' + _fmt(item.createdAt)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showDetail(context, item),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text('$e', textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton.icon(onPressed: () => ref.invalidate(locationListProvider),
                icon: const Icon(Icons.refresh), label: const Text('Retry')),
          ])),
        )),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'LocationClientFAB',
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add), label: const Text('New Location'),
      ),
    );
  }

Color _stColor(dynamic status) {
  final s = status?.toString().toLowerCase() ?? '';
  if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
  if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
  if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
  return Colors.blueGrey;
}

  void _showDetail(BuildContext context, Location item) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6, minChildSize: 0.3, maxChildSize: 0.92, expand: false,
        builder: (ctx2, sc) => Column(children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              const Text('Location Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx)),
            ])),
          const Divider(),
          Expanded(child: ListView(controller: sc, padding: const EdgeInsets.all(16), children: [
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
                  _row('Image Url', item.imageUrl?.toString() ?? 'N/A', Icons.text_fields),
                  _row('Link Url', item.linkUrl?.toString() ?? 'N/A', Icons.text_fields),
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
                  _row('Tags', item.tags?.join(', ') ?? 'N/A', Icons.label_outline),
              _row('Created At', _fmt(item.createdAt), Icons.calendar_today),
                  _row('Updated At', _fmt(item.updatedAt), Icons.calendar_today),
          ])),
        ]),
      ),
    );
  }

  void _showForm(BuildContext context) {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 8),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 12),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(alignment: Alignment.centerLeft,
              child: Text('New Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
          const Divider(),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(ctx).size.height * 0.7),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: LocationFormWidget(
                onSubmit: (newItem) {
                  ref.read(locationCreateStateProvider.notifier).state = newItem;
                  Navigator.pop(ctx);
                },
              ),
            ),
          ),
        ]),
      ),
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