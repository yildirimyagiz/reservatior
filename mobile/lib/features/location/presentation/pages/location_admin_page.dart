import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/location_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// Location Admin Page  |  70 fields
// Auto-generated — edit with care
// ================================================================

class LocationAdminPage extends ConsumerWidget {
  const LocationAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(locationLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(locationListProvider)),
        ],
      ),
      body: const _LocationBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'LocationFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New Location'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _LocationBody extends ConsumerStatefulWidget {
  const _LocationBody({super.key});
  @override ConsumerState<_LocationBody> createState() => __LocationBodyState();
}

class __LocationBodyState extends ConsumerState<_LocationBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(locationListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
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
          final list = _q.isEmpty
              ? items
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.propertyId?.toString() ?? '') + " " + (item.listingId?.toString() ?? '') + " " + (item.dealId?.toString() ?? '') + " " + (item.addressLine1?.toString() ?? '') + " " + (item.addressLine2?.toString() ?? '') + " " + (item.addressLine3?.toString() ?? '') + " " + (item.city?.toString() ?? '') + " " + (item.state?.toString() ?? '') + " " + (item.zip?.toString() ?? '') + " " + (item.zipPlus4?.toString() ?? '') + " " + (item.country?.toString() ?? '') + " " + (item.stateName?.toString() ?? '') + " " + (item.stateFIPS?.toString() ?? '') + " " + (item.censusTract?.toString() ?? '') + " " + (item.blockGroup?.toString() ?? '') + " " + (item.precinct?.toString() ?? '') + " " + (item.schoolDistrict?.toString() ?? '') + " " + (item.congressionalDistrict?.toString() ?? '') + " " + (item.verifiedBy?.toString() ?? '') + " " + (item.dpvConfirmation?.toString() ?? '') + " " + (item.footnotes?.toString() ?? '') + " " + (item.markerColor?.toString() ?? '') + " " + (item.title?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.imageUrl?.toString() ?? '') + " " + (item.linkUrl?.toString() ?? '') + " " + (item.category?.toString() ?? '') + " " + (item.mondayOpen?.toString() ?? '') + " " + (item.mondayClose?.toString() ?? '') + " " + (item.tuesdayOpen?.toString() ?? '') + " " + (item.tuesdayClose?.toString() ?? '') + " " + (item.wednesdayOpen?.toString() ?? '') + " " + (item.wednesdayClose?.toString() ?? '') + " " + (item.thursdayOpen?.toString() ?? '') + " " + (item.thursdayClose?.toString() ?? '') + " " + (item.fridayOpen?.toString() ?? '') + " " + (item.fridayClose?.toString() ?? '') + " " + (item.saturdayOpen?.toString() ?? '') + " " + (item.saturdayClose?.toString() ?? '') + " " + (item.sundayOpen?.toString() ?? '') + " " + (item.sundayClose?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No Locations yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(locationListProvider),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 88),
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                final item = list[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: CircleAvatar(backgroundColor: _stColor(item), foregroundColor: Colors.white, child: Text(item.title != null && item.title!.toString().isNotEmpty ? item.title!.toString()[0].toUpperCase() : '?'),),
                    title: Text(item.title ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('Created At: ' + _formatDate(item.createdAt)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.geocodingStatus != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.geocodingStatus!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
                  ),
                      IconButton(icon: const Icon(Icons.edit_outlined, size: 20), tooltip: 'Edit',
                          onPressed: () => _showForm(context, ref, item: item)),
                      IconButton(icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20), tooltip: 'Delete',
                          onPressed: () => _confirmDel(context, ref, item)),
                    ]),
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
          SelectableText('$e', textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton.icon(onPressed: () => ref.invalidate(locationListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(Location item) {
    final s = item.geocodingStatus?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, Location item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Location Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              _row('Zip', item.zip?.toString() ?? 'N/A', Icons.text_fields),
              _row('Zip Plus4', item.zipPlus4?.toString() ?? 'N/A', Icons.text_fields),
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
              _row('Geocoded At', _formatDate(item.geocodedAt), Icons.calendar_today),
              _row('Geocoding Provider', item.geocodingProvider?.toString() ?? 'N/A', Icons.text_fields),
              _row('Confidence Score', item.confidenceScore?.toString() ?? 'N/A', Icons.numbers),
              _row('Is Verified', (item.isVerified == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Verified At', _formatDate(item.verifiedAt), Icons.calendar_today),
              _row('Verified By', item.verifiedBy?.toString() ?? 'N/A', Icons.text_fields),
              _row('Usps Verified', (item.uspsVerified == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Usps Verified At', _formatDate(item.uspsVerifiedAt), Icons.calendar_today),
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
              _row('Tags', item.tags?.join(', ') ?? 'N/A', Icons.label_outline),
              _row('Created At', _formatDate(item.createdAt), Icons.calendar_today),
              _row('Updated At', _formatDate(item.updatedAt), Icons.calendar_today),
          ]),
        ),
      ),
    ),
  ));
}

Widget _row(String label, String value, IconData icon) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 5),
  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, size: 18, color: Colors.blueGrey[400]),
    const SizedBox(width: 10),
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
      const SizedBox(height: 2),
      SelectableText(value),
    ])),
  ]),
);

// ─── Form Dialog ─────────────────────────────────────────────────

void _showForm(BuildContext context, WidgetRef ref, {Location? item}) {
  showDialog(context: context, builder: (ctx) => _LocationForm(item: item, ref: ref));
}

class _LocationForm extends ConsumerStatefulWidget {
  final Location? item;
  final WidgetRef ref;
  const _LocationForm({super.key, this.item, required this.ref});
  @override ConsumerState<_LocationForm> createState() => __LocationFormState();
}

class __LocationFormState extends ConsumerState<_LocationForm> {
  final _key = GlobalKey<FormState>();

  String? _propertyId;
  String? _listingId;
  String? _dealId;
  String? _addressLine1;
  String? _addressLine2;
  String? _addressLine3;
  String? _city;
  String? _state;
  String? _zip;
  String? _zipPlus4;
  String? _country;
  String? _stateName;
  String? _stateFIPS;
  String? _censusTract;
  String? _blockGroup;
  String? _precinct;
  String? _schoolDistrict;
  String? _congressionalDistrict;
  double? _latitude;
  double? _longitude;
  String? _accuracy;
  double? _altitude;
  double? _elevation;
  String? _geocodingStatus;
  DateTime? _geocodedAt;
  String? _geocodingProvider;
  double? _confidenceScore;
  bool _isVerified = false;
  DateTime? _verifiedAt;
  String? _verifiedBy;
  bool _uspsVerified = false;
  DateTime? _uspsVerifiedAt;
  String? _dpvConfirmation;
  String? _footnotes;
  bool _isStandardized = false;
  bool _isResidential = false;
  bool _isCommercial = false;
  bool _isValid = false;
  String? _markerType;
  String? _markerIcon;
  String? _markerColor;
  int? _markerSize;
  bool _isVisible = false;
  int? _zIndex;
  double? _opacity;
  String? _title;
  String? _description;
  String? _imageUrl;
  String? _linkUrl;
  String? _category;
  String? _mondayOpen;
  String? _mondayClose;
  String? _tuesdayOpen;
  String? _tuesdayClose;
  String? _wednesdayOpen;
  String? _wednesdayClose;
  String? _thursdayOpen;
  String? _thursdayClose;
  String? _fridayOpen;
  String? _fridayClose;
  String? _saturdayOpen;
  String? _saturdayClose;
  String? _sundayOpen;
  String? _sundayClose;
  String? _metadata;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _dealId = widget.item?.dealId?.toString();
    _addressLine1 = widget.item?.addressLine1?.toString();
    _addressLine2 = widget.item?.addressLine2?.toString();
    _addressLine3 = widget.item?.addressLine3?.toString();
    _city = widget.item?.city?.toString();
    _state = widget.item?.state?.toString();
    _zip = widget.item?.zip?.toString();
    _zipPlus4 = widget.item?.zipPlus4?.toString();
    _country = widget.item?.country?.toString();
    _stateName = widget.item?.stateName?.toString();
    _stateFIPS = widget.item?.stateFIPS?.toString();
    _censusTract = widget.item?.censusTract?.toString();
    _blockGroup = widget.item?.blockGroup?.toString();
    _precinct = widget.item?.precinct?.toString();
    _schoolDistrict = widget.item?.schoolDistrict?.toString();
    _congressionalDistrict = widget.item?.congressionalDistrict?.toString();
    _latitude = widget.item?.latitude;
    _longitude = widget.item?.longitude;
    _accuracy = widget.item?.accuracy?.toString();
    _altitude = widget.item?.altitude;
    _elevation = widget.item?.elevation;
    _geocodingStatus = widget.item?.geocodingStatus?.toString();
    _geocodedAt = widget.item?.geocodedAt;
    _geocodingProvider = widget.item?.geocodingProvider?.toString();
    _confidenceScore = widget.item?.confidenceScore;
    _isVerified = widget.item?.isVerified ?? false;
    _verifiedAt = widget.item?.verifiedAt;
    _verifiedBy = widget.item?.verifiedBy?.toString();
    _uspsVerified = widget.item?.uspsVerified ?? false;
    _uspsVerifiedAt = widget.item?.uspsVerifiedAt;
    _dpvConfirmation = widget.item?.dpvConfirmation?.toString();
    _footnotes = widget.item?.footnotes?.toString();
    _isStandardized = widget.item?.isStandardized ?? false;
    _isResidential = widget.item?.isResidential ?? false;
    _isCommercial = widget.item?.isCommercial ?? false;
    _isValid = widget.item?.isValid ?? false;
    _markerType = widget.item?.markerType?.toString();
    _markerIcon = widget.item?.markerIcon?.toString();
    _markerColor = widget.item?.markerColor?.toString();
    _markerSize = widget.item?.markerSize;
    _isVisible = widget.item?.isVisible ?? false;
    _zIndex = widget.item?.zIndex;
    _opacity = widget.item?.opacity;
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _imageUrl = widget.item?.imageUrl?.toString();
    _linkUrl = widget.item?.linkUrl?.toString();
    _category = widget.item?.category?.toString();
    _mondayOpen = widget.item?.mondayOpen?.toString();
    _mondayClose = widget.item?.mondayClose?.toString();
    _tuesdayOpen = widget.item?.tuesdayOpen?.toString();
    _tuesdayClose = widget.item?.tuesdayClose?.toString();
    _wednesdayOpen = widget.item?.wednesdayOpen?.toString();
    _wednesdayClose = widget.item?.wednesdayClose?.toString();
    _thursdayOpen = widget.item?.thursdayOpen?.toString();
    _thursdayClose = widget.item?.thursdayClose?.toString();
    _fridayOpen = widget.item?.fridayOpen?.toString();
    _fridayClose = widget.item?.fridayClose?.toString();
    _saturdayOpen = widget.item?.saturdayOpen?.toString();
    _saturdayClose = widget.item?.saturdayClose?.toString();
    _sundayOpen = widget.item?.sundayOpen?.toString();
    _sundayClose = widget.item?.sundayClose?.toString();
    _metadata = widget.item?.metadata?.toString();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
      if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
      if (_dealId?.isNotEmpty == true) 'dealId': _dealId,
      if (_addressLine1?.isNotEmpty == true) 'addressLine1': _addressLine1,
      if (_addressLine2?.isNotEmpty == true) 'addressLine2': _addressLine2,
      if (_addressLine3?.isNotEmpty == true) 'addressLine3': _addressLine3,
      if (_city?.isNotEmpty == true) 'city': _city,
      if (_state?.isNotEmpty == true) 'state': _state,
      if (_zip?.isNotEmpty == true) 'zip': _zip,
      if (_zipPlus4?.isNotEmpty == true) 'zipPlus4': _zipPlus4,
      if (_country?.isNotEmpty == true) 'country': _country,
      if (_stateName?.isNotEmpty == true) 'stateName': _stateName,
      if (_stateFIPS?.isNotEmpty == true) 'stateFIPS': _stateFIPS,
      if (_censusTract?.isNotEmpty == true) 'censusTract': _censusTract,
      if (_blockGroup?.isNotEmpty == true) 'blockGroup': _blockGroup,
      if (_precinct?.isNotEmpty == true) 'precinct': _precinct,
      if (_schoolDistrict?.isNotEmpty == true) 'schoolDistrict': _schoolDistrict,
      if (_congressionalDistrict?.isNotEmpty == true) 'congressionalDistrict': _congressionalDistrict,
      if (_latitude != null) 'latitude': _latitude,
      if (_longitude != null) 'longitude': _longitude,
      if (_accuracy?.isNotEmpty == true) 'accuracy': _accuracy,
      if (_altitude != null) 'altitude': _altitude,
      if (_elevation != null) 'elevation': _elevation,
      if (_geocodingStatus?.isNotEmpty == true) 'geocodingStatus': _geocodingStatus,
      if (_geocodedAt != null) 'geocodedAt': _geocodedAt!.toIso8601String(),
      if (_geocodingProvider?.isNotEmpty == true) 'geocodingProvider': _geocodingProvider,
      if (_confidenceScore != null) 'confidenceScore': _confidenceScore,
      'isVerified': _isVerified,
      if (_verifiedAt != null) 'verifiedAt': _verifiedAt!.toIso8601String(),
      if (_verifiedBy?.isNotEmpty == true) 'verifiedBy': _verifiedBy,
      'uspsVerified': _uspsVerified,
      if (_uspsVerifiedAt != null) 'uspsVerifiedAt': _uspsVerifiedAt!.toIso8601String(),
      if (_dpvConfirmation?.isNotEmpty == true) 'dpvConfirmation': _dpvConfirmation,
      if (_footnotes?.isNotEmpty == true) 'footnotes': _footnotes,
      'isStandardized': _isStandardized,
      'isResidential': _isResidential,
      'isCommercial': _isCommercial,
      'isValid': _isValid,
      if (_markerType?.isNotEmpty == true) 'markerType': _markerType,
      if (_markerIcon?.isNotEmpty == true) 'markerIcon': _markerIcon,
      if (_markerColor?.isNotEmpty == true) 'markerColor': _markerColor,
      if (_markerSize != null) 'markerSize': _markerSize,
      'isVisible': _isVisible,
      if (_zIndex != null) 'zIndex': _zIndex,
      if (_opacity != null) 'opacity': _opacity,
      if (_title?.isNotEmpty == true) 'title': _title,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_imageUrl?.isNotEmpty == true) 'imageUrl': _imageUrl,
      if (_linkUrl?.isNotEmpty == true) 'linkUrl': _linkUrl,
      if (_category?.isNotEmpty == true) 'category': _category,
      if (_mondayOpen?.isNotEmpty == true) 'mondayOpen': _mondayOpen,
      if (_mondayClose?.isNotEmpty == true) 'mondayClose': _mondayClose,
      if (_tuesdayOpen?.isNotEmpty == true) 'tuesdayOpen': _tuesdayOpen,
      if (_tuesdayClose?.isNotEmpty == true) 'tuesdayClose': _tuesdayClose,
      if (_wednesdayOpen?.isNotEmpty == true) 'wednesdayOpen': _wednesdayOpen,
      if (_wednesdayClose?.isNotEmpty == true) 'wednesdayClose': _wednesdayClose,
      if (_thursdayOpen?.isNotEmpty == true) 'thursdayOpen': _thursdayOpen,
      if (_thursdayClose?.isNotEmpty == true) 'thursdayClose': _thursdayClose,
      if (_fridayOpen?.isNotEmpty == true) 'fridayOpen': _fridayOpen,
      if (_fridayClose?.isNotEmpty == true) 'fridayClose': _fridayClose,
      if (_saturdayOpen?.isNotEmpty == true) 'saturdayOpen': _saturdayOpen,
      if (_saturdayClose?.isNotEmpty == true) 'saturdayClose': _saturdayClose,
      if (_sundayOpen?.isNotEmpty == true) 'sundayOpen': _sundayOpen,
      if (_sundayClose?.isNotEmpty == true) 'sundayClose': _sundayClose,
      if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
    };
    if (widget.item == null) {
      widget.ref.read(locationCreateStateProvider.notifier).state = Location.fromJson(data);
    } else {
      widget.ref.read(locationUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'location': Location.fromJson({...widget.item!.toJson(), ...data}),
      };
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 700),
        child: Scaffold(
          appBar: AppBar(
            title: Text(isEdit ? 'Edit Location' : 'New Location'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.propertyId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.listingId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Deal Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.dealId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dealId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address Line1', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.addressLine1?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _addressLine1 = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address Line2', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.addressLine2?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _addressLine2 = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address Line3', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.addressLine3?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _addressLine3 = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'City', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.city?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _city = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'State', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.state?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _state = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Zip', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.zip?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _zip = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Zip Plus4', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.zipPlus4?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _zipPlus4 = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Country', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.country?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _country = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'State Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                    initialValue: widget.item.stateName?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _stateName = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'State F I P S', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.stateFIPS?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _stateFIPS = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Census Tract', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.censusTract?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _censusTract = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Block Group', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.blockGroup?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _blockGroup = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Precinct', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.precinct?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _precinct = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'School District', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.schoolDistrict?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _schoolDistrict = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Congressional District', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.congressionalDistrict?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _congressionalDistrict = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Latitude', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.latitude?.toString() ?? '',
                    onSaved: (v) => _latitude = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Longitude', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.longitude?.toString() ?? '',
                    onSaved: (v) => _longitude = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Accuracy', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.accuracy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _accuracy = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Altitude', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.altitude?.toString() ?? '',
                    onSaved: (v) => _altitude = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Elevation', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.elevation?.toString() ?? '',
                    onSaved: (v) => _elevation = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Geocoding Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.geocodingStatus?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _geocodingStatus = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _geocodedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _geocodedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Geocoded At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_geocodedAt != null ? _formatDate(_geocodedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Geocoding Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.geocodingProvider?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _geocodingProvider = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confidence Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.confidenceScore?.toString() ?? '',
                    onSaved: (v) => _confidenceScore = double.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Verified'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isVerified ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isVerified = v); },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _verifiedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _verifiedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Verified At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_verifiedAt != null ? _formatDate(_verifiedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Verified By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.verifiedBy?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _verifiedBy = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Usps Verified'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.uspsVerified ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _uspsVerified = v); },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _uspsVerifiedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _uspsVerifiedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Usps Verified At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_uspsVerifiedAt != null ? _formatDate(_uspsVerifiedAt) : 'Tap to select date'),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Dpv Confirmation', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.dpvConfirmation?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _dpvConfirmation = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Footnotes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.footnotes?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _footnotes = v?.isEmpty == true ? null : v,
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Standardized'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isStandardized ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isStandardized = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Residential'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isResidential ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isResidential = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Commercial'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isCommercial ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isCommercial = v); },
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Valid'),
                      secondary: const Icon(Icons.link),
                      value: widget.item.isValid ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isValid = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Marker Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.markerType?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _markerType = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Marker Icon', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.markerIcon?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _markerIcon = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Marker Color', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.markerColor?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _markerColor = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Marker Size', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.markerSize?.toString() ?? '',
                    onSaved: (v) => _markerSize = int.tryParse(v ?? ''),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Visible'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isVisible ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isVisible = v); },
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Z Index', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.zIndex?.toString() ?? '',
                    onSaved: (v) => _zIndex = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Opacity', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.opacity?.toString() ?? '',
                    onSaved: (v) => _opacity = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.title?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _title = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                    initialValue: widget.item.description?.toString() ?? '',
                    maxLines: 3,
                    onSaved: (v) => _description = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Image Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.imageUrl?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _imageUrl = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Link Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.linkUrl?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _linkUrl = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.category?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _category = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Monday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.mondayOpen?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _mondayOpen = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Monday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.mondayClose?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _mondayClose = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tuesday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.tuesdayOpen?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _tuesdayOpen = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Tuesday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.tuesdayClose?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _tuesdayClose = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Wednesday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.wednesdayOpen?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _wednesdayOpen = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Wednesday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.wednesdayClose?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _wednesdayClose = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Thursday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.thursdayOpen?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _thursdayOpen = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Thursday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.thursdayClose?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _thursdayClose = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Friday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.fridayOpen?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fridayOpen = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Friday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.fridayClose?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _fridayClose = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Saturday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.saturdayOpen?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _saturdayOpen = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Saturday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.saturdayClose?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _saturdayClose = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Sunday Open', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.sundayOpen?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _sundayOpen = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Sunday Close', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.sundayClose?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _sundayClose = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.metadata?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create Location'),
                  style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Delete Confirm ──────────────────────────────────────────────

void _confirmDel(BuildContext context, WidgetRef ref, Location item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete Location?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(locationDeleteStateProvider.notifier).state = item.id;
          Navigator.pop(ctx);
        },
        icon: const Icon(Icons.delete), label: const Text('Delete'),
        style: FilledButton.styleFrom(backgroundColor: Colors.red),
      ),
    ],
  ));
}

// ─── Helpers ─────────────────────────────────────────────────────

String _formatDate(DateTime? d) {
  if (d == null) return 'N/A';
  final y = d.year; final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0'); final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '$y-$mo-$day $h:$mi';
}
