import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/providers/external_rental_listing_provider.dart';
import '../../../../gen_models/models_library.dart';

// ================================================================
// ExternalRentalListing Admin Page  |  33 fields
// Auto-generated — edit with care
// ================================================================

class ExternalRentalListingAdminPage extends ConsumerWidget {
  const ExternalRentalListingAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(externalRentalListingLoadingProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('External Rental Listing Management'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
        actions: [
          if (loading) const Padding(
            padding: EdgeInsets.all(14),
            child: SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
          ),
          IconButton(icon: const Icon(Icons.refresh), tooltip: 'Refresh',
              onPressed: () => ref.invalidate(externalRentalListingListProvider)),
        ],
      ),
      body: const _ExternalRentalListingBody(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'ExternalRentalListingFAB',
        onPressed: () => _showForm(context, ref),
        icon: const Icon(Icons.add), label: const Text('New External Rental Listing'),
      ),
    );
  }
}

// ─── List Body ───────────────────────────────────────────────────

class _ExternalRentalListingBody extends ConsumerStatefulWidget {
  const _ExternalRentalListingBody({super.key});
  @override ConsumerState<_ExternalRentalListingBody> createState() => __ExternalRentalListingBodyState();
}

class __ExternalRentalListingBodyState extends ConsumerState<_ExternalRentalListingBody> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(externalRentalListingListProvider);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: TextField(
          controller: _ctrl,
          decoration: InputDecoration(
            hintText: 'Search External Rental Listings…',
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
              : items.where((item) => ((item.orgId?.toString() ?? '') + " " + (item.integrationId?.toString() ?? '') + " " + (item.externalId?.toString() ?? '') + " " + (item.externalUrl?.toString() ?? '') + " " + (item.title?.toString() ?? '') + " " + (item.description?.toString() ?? '') + " " + (item.address?.toString() ?? '') + " " + (item.city?.toString() ?? '') + " " + (item.state?.toString() ?? '') + " " + (item.zip?.toString() ?? '') + " " + (item.country?.toString() ?? '') + " " + (item.currency?.toString() ?? '') + " " + (item.checkInTime?.toString() ?? '') + " " + (item.checkOutTime?.toString() ?? '') + " " + (item.createdBy?.toString() ?? '')).toLowerCase().contains(_q)).toList();
          if (list.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.inbox_outlined, size: 56, color: Colors.grey[350]),
              const SizedBox(height: 12),
              Text(_q.isNotEmpty ? 'No results for "$_q"' : 'No External Rental Listings yet',
                  style: TextStyle(color: Colors.grey[500])),
            ]));
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(externalRentalListingListProvider),
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
                    subtitle: Text('Status: ' + item.status?.toString() ?? 'N/A'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      
                if (item.status != null)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _stColor(item).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: _stColor(item).withOpacity(0.4)),
                    ),
                    child: Text(item.status!.toString(), style: TextStyle(fontSize: 11, color: _stColor(item), fontWeight: FontWeight.w600)),
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
          ElevatedButton.icon(onPressed: () => ref.invalidate(externalRentalListingListProvider),
              icon: const Icon(Icons.refresh), label: const Text('Retry')),
        ])),
      )),
    ]);
  }
  Color _stColor(ExternalRentalListing item) {
    final s = item.status?.toString().toLowerCase() ?? '';
    if (s.contains('active') || s.contains('approved') || s.contains('complete') || s.contains('paid') || s.contains('success')) return Colors.green;
    if (s.contains('pending') || s.contains('process') || s.contains('wait') || s.contains('draft')) return Colors.orange;
    if (s.contains('cancel') || s.contains('reject') || s.contains('fail') || s.contains('inactiv') || s.contains('expir')) return Colors.red;
    return Colors.blueGrey;
  }
}

// ─── Detail Dialog ───────────────────────────────────────────────

void _showDetail(BuildContext context, ExternalRentalListing item) {
  showDialog(context: context, builder: (ctx) => Dialog(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500, maxHeight: 640),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('External Rental Listing Details'),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(ctx))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _row('Id', item.id?.toString() ?? 'N/A', Icons.tag),
              _row('Org Id', item.orgId?.toString() ?? 'N/A', Icons.link),
              _row('Integration Id', item.integrationId?.toString() ?? 'N/A', Icons.link),
              _row('Platform', item.platform?.toString() ?? 'N/A', Icons.text_fields),
              _row('External Id', item.externalId?.toString() ?? 'N/A', Icons.link),
              _row('External Url', item.externalUrl?.toString() ?? 'N/A', Icons.link),
              _row('Title', item.title?.toString() ?? 'N/A', Icons.text_fields),
              _row('Description', item.description?.toString() ?? 'N/A', Icons.notes),
              _row('Status', item.status?.toString() ?? 'N/A', Icons.info_outline),
              _row('Address', item.address?.toString() ?? 'N/A', Icons.location_on),
              _row('City', item.city?.toString() ?? 'N/A', Icons.location_on),
              _row('State', item.state?.toString() ?? 'N/A', Icons.text_fields),
              _row('Zip', item.zip?.toString() ?? 'N/A', Icons.text_fields),
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
              _row('Last Synced At', _formatDate(item.lastSyncedAt), Icons.calendar_today),
              _row('Is Active', (item.isActive == true ? 'Yes' : 'No'), Icons.toggle_on),
              _row('Created By', item.createdBy?.toString() ?? 'N/A', Icons.text_fields),
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

void _showForm(BuildContext context, WidgetRef ref, {ExternalRentalListing? item}) {
  showDialog(context: context, builder: (ctx) => _ExternalRentalListingForm(item: item, ref: ref));
}

class _ExternalRentalListingForm extends ConsumerStatefulWidget {
  final ExternalRentalListing? item;
  final WidgetRef ref;
  const _ExternalRentalListingForm({super.key, this.item, required this.ref});
  @override ConsumerState<_ExternalRentalListingForm> createState() => __ExternalRentalListingFormState();
}

class __ExternalRentalListingFormState extends ConsumerState<_ExternalRentalListingForm> {
  final _key = GlobalKey<FormState>();

  String? _integrationId;
  String? _platform;
  String? _externalId;
  String? _externalUrl;
  String? _title;
  String? _description;
  String? _status;
  String? _address;
  String? _city;
  String? _state;
  String? _zip;
  String? _country;
  double? _latitude;
  double? _longitude;
  double? _nightlyRate;
  String? _currency;
  double? _cleaningFee;
  double? _serviceFee;
  String? _checkInTime;
  String? _checkOutTime;
  int? _minStay;
  int? _maxStay;
  int? _bedrooms;
  double? _bathrooms;
  int? _maxGuests;
  String? _rawData;
  DateTime? _lastSyncedAt;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _integrationId = widget.item?.integrationId?.toString();
    _platform = widget.item?.platform?.toString();
    _externalId = widget.item?.externalId?.toString();
    _externalUrl = widget.item?.externalUrl?.toString();
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _status = widget.item?.status?.toString();
    _address = widget.item?.address?.toString();
    _city = widget.item?.city?.toString();
    _state = widget.item?.state?.toString();
    _zip = widget.item?.zip?.toString();
    _country = widget.item?.country?.toString();
    _latitude = widget.item?.latitude;
    _longitude = widget.item?.longitude;
    _nightlyRate = widget.item?.nightlyRate;
    _currency = widget.item?.currency?.toString();
    _cleaningFee = widget.item?.cleaningFee;
    _serviceFee = widget.item?.serviceFee;
    _checkInTime = widget.item?.checkInTime?.toString();
    _checkOutTime = widget.item?.checkOutTime?.toString();
    _minStay = widget.item?.minStay;
    _maxStay = widget.item?.maxStay;
    _bedrooms = widget.item?.bedrooms;
    _bathrooms = widget.item?.bathrooms;
    _maxGuests = widget.item?.maxGuests;
    _rawData = widget.item?.rawData?.toString();
    _lastSyncedAt = widget.item?.lastSyncedAt;
    _isActive = widget.item?.isActive ?? false;
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
      if (_integrationId?.isNotEmpty == true) 'integrationId': _integrationId,
      if (_platform?.isNotEmpty == true) 'platform': _platform,
      if (_externalId?.isNotEmpty == true) 'externalId': _externalId,
      if (_externalUrl?.isNotEmpty == true) 'externalUrl': _externalUrl,
      if (_title?.isNotEmpty == true) 'title': _title,
      if (_description?.isNotEmpty == true) 'description': _description,
      if (_status?.isNotEmpty == true) 'status': _status,
      if (_address?.isNotEmpty == true) 'address': _address,
      if (_city?.isNotEmpty == true) 'city': _city,
      if (_state?.isNotEmpty == true) 'state': _state,
      if (_zip?.isNotEmpty == true) 'zip': _zip,
      if (_country?.isNotEmpty == true) 'country': _country,
      if (_latitude != null) 'latitude': _latitude,
      if (_longitude != null) 'longitude': _longitude,
      if (_nightlyRate != null) 'nightlyRate': _nightlyRate,
      if (_currency?.isNotEmpty == true) 'currency': _currency,
      if (_cleaningFee != null) 'cleaningFee': _cleaningFee,
      if (_serviceFee != null) 'serviceFee': _serviceFee,
      if (_checkInTime?.isNotEmpty == true) 'checkInTime': _checkInTime,
      if (_checkOutTime?.isNotEmpty == true) 'checkOutTime': _checkOutTime,
      if (_minStay != null) 'minStay': _minStay,
      if (_maxStay != null) 'maxStay': _maxStay,
      if (_bedrooms != null) 'bedrooms': _bedrooms,
      if (_bathrooms != null) 'bathrooms': _bathrooms,
      if (_maxGuests != null) 'maxGuests': _maxGuests,
      if (_rawData?.isNotEmpty == true) 'rawData': _rawData,
      if (_lastSyncedAt != null) 'lastSyncedAt': _lastSyncedAt!.toIso8601String(),
      'isActive': _isActive,
    };
    if (widget.item == null) {
      widget.ref.read(externalRentalListingCreateStateProvider.notifier).state = ExternalRentalListing.fromJson(data);
    } else {
      widget.ref.read(externalRentalListingUpdateStateProvider.notifier).state = {
        'id': widget.item!.id,
        'externalRentalListing': ExternalRentalListing.fromJson({...widget.item!.toJson(), ...data}),
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
            title: Text(isEdit ? 'Edit External Rental Listing' : 'New External Rental Listing'),
            automaticallyImplyLeading: false,
            actions: [IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))],
          ),
          body: Form(
            key: _key,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Integration Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.integrationId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _integrationId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Platform', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.platform?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _platform = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'External Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.externalId?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _externalId = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'External Url', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                    initialValue: widget.item.externalUrl?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _externalUrl = v?.isEmpty == true ? null : v,
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
                    decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                    initialValue: widget.item.status?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _status = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Address', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.address?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _address = v?.isEmpty == true ? null : v,
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
                    decoration: InputDecoration(labelText: 'Country', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                    initialValue: widget.item.country?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _country = v?.isEmpty == true ? null : v,
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
                    decoration: const InputDecoration(labelText: 'Nightly Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.nightlyRate?.toString() ?? '',
                    onSaved: (v) => _nightlyRate = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.currency?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Cleaning Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.cleaningFee?.toString() ?? '',
                    onSaved: (v) => _cleaningFee = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Service Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.serviceFee?.toString() ?? '',
                    onSaved: (v) => _serviceFee = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Check In Time', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.checkInTime?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _checkInTime = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Check Out Time', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.checkOutTime?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _checkOutTime = v?.isEmpty == true ? null : v,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Min Stay', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.minStay?.toString() ?? '',
                    onSaved: (v) => _minStay = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Max Stay', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.maxStay?.toString() ?? '',
                    onSaved: (v) => _maxStay = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Bedrooms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.bedrooms?.toString() ?? '',
                    onSaved: (v) => _bedrooms = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Bathrooms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    initialValue: widget.item.bathrooms?.toString() ?? '',
                    onSaved: (v) => _bathrooms = double.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Max Guests', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    initialValue: widget.item.maxGuests?.toString() ?? '',
                    onSaved: (v) => _maxGuests = int.tryParse(v ?? ''),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Raw Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                    initialValue: widget.item.rawData?.toString() ?? '',
                    maxLines: 1,
                    onSaved: (v) => _rawData = v?.isEmpty == true ? null : v,
                  ),
                  InkWell(
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _lastSyncedAt ?? DateTime.now(),
                        firstDate: DateTime(2000), lastDate: DateTime(2100),
                      );
                      if (d != null) setState(() => _lastSyncedAt = d);
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Last Synced At',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      child: Text(_lastSyncedAt != null ? _formatDate(_lastSyncedAt) : 'Tap to select date'),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (ctx2, ss) => SwitchListTile(
                      title: Text('Is Active'),
                      secondary: const Icon(Icons.toggle_on),
                      value: widget.item.isActive ?? false,
                      onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                    ),
                  ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _submit,
                  icon: Icon(isEdit ? Icons.save : Icons.add),
                  label: Text(isEdit ? 'Save Changes' : 'Create External Rental Listing'),
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

void _confirmDel(BuildContext context, WidgetRef ref, ExternalRentalListing item) {
  showDialog(context: context, builder: (ctx) => AlertDialog(
    icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 40),
    title: const Text('Delete External Rental Listing?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      FilledButton.icon(
        onPressed: () {
          ref.read(externalRentalListingDeleteStateProvider.notifier).state = item.id;
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
