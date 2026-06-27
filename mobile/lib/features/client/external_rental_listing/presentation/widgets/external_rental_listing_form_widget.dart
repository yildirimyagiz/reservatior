import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ExternalRentalListingFormWidget extends ConsumerStatefulWidget {
  final ExternalRentalListing? item;
  final Function(ExternalRentalListing) onSubmit;
  const ExternalRentalListingFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<ExternalRentalListingFormWidget> createState() =>
      _ExternalRentalListingFormWidgetState();
}

class _ExternalRentalListingFormWidgetState
    extends ConsumerState<ExternalRentalListingFormWidget> {
  String? _integrationId;
  String? _externalId;
  String? _externalUrl;
  String? _title;
  String? _description;
  String? _addres;
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
  DateTime? _lastSyncedAt;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _integrationId = widget.item?.integrationId;
    _externalId = widget.item?.externalId;
    _externalUrl = widget.item?.externalUrl;
    _title = widget.item?.title;
    _description = widget.item?.description;
    _addres = widget.item?.addres;
    _city = widget.item?.city;
    _state = widget.item?.state;
    _zip = widget.item?.zip;
    _country = widget.item?.country;
    _latitude = widget.item?.latitude;
    _longitude = widget.item?.longitude;
    _nightlyRate = widget.item?.nightlyRate;
    _currency = widget.item?.currency;
    _cleaningFee = widget.item?.cleaningFee;
    _serviceFee = widget.item?.serviceFee;
    _checkInTime = widget.item?.checkInTime;
    _checkOutTime = widget.item?.checkOutTime;
    _minStay = widget.item?.minStay;
    _maxStay = widget.item?.maxStay;
    _bedrooms = widget.item?.bedrooms;
    _bathrooms = widget.item?.bathrooms;
    _maxGuests = widget.item?.maxGuests;
    _lastSyncedAt = widget.item?.lastSyncedAt;
    _isActive = widget.item?.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.externalrentallisting'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.externalrentallisting'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _integrationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.integrationid'.tr()),
              onChanged: (v) => _integrationId = v,
            ),
            TextFormField(
              initialValue: _externalId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.externalid'.tr()),
              onChanged: (v) => _externalId = v,
            ),
            TextFormField(
              initialValue: _externalUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.externalurl'.tr()),
              onChanged: (v) => _externalUrl = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _addres?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.addres'.tr()),
              onChanged: (v) => _addres = v,
            ),
            TextFormField(
              initialValue: _city?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.city'.tr()),
              onChanged: (v) => _city = v,
            ),
            TextFormField(
              initialValue: _state?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.state'.tr()),
              onChanged: (v) => _state = v,
            ),
            TextFormField(
              initialValue: _zip?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.zip'.tr()),
              onChanged: (v) => _zip = v,
            ),
            TextFormField(
              initialValue: _country?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.country'.tr()),
              onChanged: (v) => _country = v,
            ),
            TextFormField(
              initialValue: _latitude?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.latitude'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _latitude = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _longitude?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.longitude'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _longitude = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _nightlyRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.nightlyrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _nightlyRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _cleaningFee?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.cleaningfee'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _cleaningFee = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _serviceFee?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.servicefee'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _serviceFee = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _checkInTime?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checkintime'.tr()),
              onChanged: (v) => _checkInTime = v,
            ),
            TextFormField(
              initialValue: _checkOutTime?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checkouttime'.tr()),
              onChanged: (v) => _checkOutTime = v,
            ),
            TextFormField(
              initialValue: _minStay?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.minstay'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _minStay = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxStay?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxstay'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxStay = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _bedrooms?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bedrooms'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _bedrooms = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _bathrooms?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bathrooms'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _bathrooms = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _maxGuests?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxguests'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxGuests = int.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_synced_at'.tr()}: ${_lastSyncedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastSyncedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastSyncedAt = d);
              },
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_integrationId != null) 'integrationId': _integrationId,
                  if (_externalId != null) 'externalId': _externalId,
                  if (_externalUrl != null) 'externalUrl': _externalUrl,
                  if (_title != null) 'title': _title,
                  if (_description != null) 'description': _description,
                  if (_addres != null) 'addres': _addres,
                  if (_city != null) 'city': _city,
                  if (_state != null) 'state': _state,
                  if (_zip != null) 'zip': _zip,
                  if (_country != null) 'country': _country,
                  if (_latitude != null) 'latitude': _latitude,
                  if (_longitude != null) 'longitude': _longitude,
                  if (_nightlyRate != null) 'nightlyRate': _nightlyRate,
                  if (_currency != null) 'currency': _currency,
                  if (_cleaningFee != null) 'cleaningFee': _cleaningFee,
                  if (_serviceFee != null) 'serviceFee': _serviceFee,
                  if (_checkInTime != null) 'checkInTime': _checkInTime,
                  if (_checkOutTime != null) 'checkOutTime': _checkOutTime,
                  if (_minStay != null) 'minStay': _minStay,
                  if (_maxStay != null) 'maxStay': _maxStay,
                  if (_bedrooms != null) 'bedrooms': _bedrooms,
                  if (_bathrooms != null) 'bathrooms': _bathrooms,
                  if (_maxGuests != null) 'maxGuests': _maxGuests,
                  if (_lastSyncedAt != null)
                    'lastSyncedAt': _lastSyncedAt!.toIso8601String(),
                  'isActive': _isActive,
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(ExternalRentalListing.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
