import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ExternalRentalListing Form Widget  |  Fields: integrationId, platform, externalId, externalUrl, title, description, status, address, city, state, zip, country, latitude, longitude, nightlyRate, currency, cleaningFee, serviceFee, checkInTime, checkOutTime, minStay, maxStay, bedrooms, bathrooms, maxGuests, rawData, lastSyncedAt, isActive

class ExternalRentalListingFormWidget extends StatefulWidget {
  final ExternalRentalListing? item;
  final void Function(ExternalRentalListing)? onSubmit;
  const ExternalRentalListingFormWidget({super.key, this.item, this.onSubmit});
  @override State<ExternalRentalListingFormWidget> createState() => _ExternalRentalListingFormWidgetState();
}

class _ExternalRentalListingFormWidgetState extends State<ExternalRentalListingFormWidget> {
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

  @override
  void dispose() {
    super.dispose();
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
    final result = widget.item != null
        ? ExternalRentalListing.fromJson({...widget.item!.toJson(), ...data})
        : ExternalRentalListing.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Integration Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _integrationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Platform', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _platform = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'External Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _externalId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'External Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _externalUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _address = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'City', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _city = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'State', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _state = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Zip', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _zip = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Country', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _country = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Latitude', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _latitude = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Longitude', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _longitude = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nightly Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _nightlyRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cleaning Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _cleaningFee = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Service Fee', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _serviceFee = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Check In Time', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _checkInTime = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Check Out Time', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _checkOutTime = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Min Stay', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _minStay = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Stay', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxStay = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bedrooms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _bedrooms = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bathrooms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _bathrooms = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Guests', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxGuests = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Raw Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _rawData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastSyncedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastSyncedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Synced At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastSyncedAt != null ? _fmt(_lastSyncedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create External Rental Listing'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}