import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ReservationFormWidget extends ConsumerStatefulWidget {
  final Reservation? item;
  final Function(Reservation) onSubmit;
  const ReservationFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ReservationFormWidget> createState() =>
      _ReservationFormWidgetState();
}

class _ReservationFormWidgetState extends ConsumerState<ReservationFormWidget> {
  String? _listingId;
  String? _contactId;
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int? _guestCount;
  String? _specialRequests;
  double? _nightlyRate;
  double? _cleaningFee;
  double? _totalAmount;
  String? _currency;
  String? _status;
  DateTime? _validUntil;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _contactId = widget.item?.contactId;
    _checkInDate = widget.item?.checkInDate;
    _checkOutDate = widget.item?.checkOutDate;
    _guestCount = widget.item?.guestCount;
    _specialRequests = widget.item?.specialRequests;
    _nightlyRate = widget.item?.nightlyRate;
    _cleaningFee = widget.item?.cleaningFee;
    _totalAmount = widget.item?.totalAmount;
    _currency = widget.item?.currency;
    _status = widget.item?.status;
    _validUntil = widget.item?.validUntil;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.reservation'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.reservation'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_check_in_date'.tr()}: ${_checkInDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _checkInDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _checkInDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_check_out_date'.tr()}: ${_checkOutDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _checkOutDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _checkOutDate = d);
              },
            ),
            TextFormField(
              initialValue: _guestCount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.guestcount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _guestCount = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _specialRequests?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.specialrequests'.tr()),
              onChanged: (v) => _specialRequests = v,
            ),
            TextFormField(
              initialValue: _nightlyRate?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.nightlyrate'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _nightlyRate = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _cleaningFee?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.cleaningfee'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _cleaningFee = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _totalAmount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.totalamount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _totalAmount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_valid_until'.tr()}: ${_validUntil ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _validUntil ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _validUntil = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_checkInDate != null)
                    'checkInDate': _checkInDate!.toIso8601String(),
                  if (_checkOutDate != null)
                    'checkOutDate': _checkOutDate!.toIso8601String(),
                  if (_guestCount != null) 'guestCount': _guestCount,
                  if (_specialRequests != null)
                    'specialRequests': _specialRequests,
                  if (_nightlyRate != null) 'nightlyRate': _nightlyRate,
                  if (_cleaningFee != null) 'cleaningFee': _cleaningFee,
                  if (_totalAmount != null) 'totalAmount': _totalAmount,
                  if (_currency != null) 'currency': _currency,
                  if (_status != null) 'status': _status,
                  if (_validUntil != null)
                    'validUntil': _validUntil!.toIso8601String(),
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
                  widget.onSubmit(Reservation.fromJson(json));
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
