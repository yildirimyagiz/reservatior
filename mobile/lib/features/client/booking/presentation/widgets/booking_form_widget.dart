import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class BookingFormWidget extends ConsumerStatefulWidget {
  final Booking? item;
  final Function(Booking) onSubmit;
  const BookingFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<BookingFormWidget> createState() => _BookingFormWidgetState();
}

class _BookingFormWidgetState extends ConsumerState<BookingFormWidget> {
  String? _listingId;
  String? _contactId;
  String? _reservationId;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _adults;
  int? _children;
  double? _priceTotal;
  String? _currency;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _contactId = widget.item?.contactId;
    _reservationId = widget.item?.reservationId;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _adults = widget.item?.adults;
    _children = widget.item?.children;
    _priceTotal = widget.item?.priceTotal;
    _currency = widget.item?.currency;
    _notes = widget.item?.notes;
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
              widget.item == null ? 'mobile.booking.formNew'.tr() : 'mobile.booking.formEdit'.tr(),
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
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            ListTile(
              title: Text('startDate: ${_startDate ?? 'mobile.booking.select'.tr()}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _startDate = d);
              },
            ),
            ListTile(
              title: Text('endDate: ${_endDate ?? 'mobile.booking.select'.tr()}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _endDate = d);
              },
            ),
            TextFormField(
              initialValue: _adults?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.adults'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _adults = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _children?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.children'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _children = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _priceTotal?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.pricetotal'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _priceTotal = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_listingId != null) 'listingId': _listingId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_adults != null) 'adults': _adults,
                  if (_children != null) 'children': _children,
                  if (_priceTotal != null) 'priceTotal': _priceTotal,
                  if (_currency != null) 'currency': _currency,
                  if (_notes != null) 'notes': _notes,
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
                  widget.onSubmit(Booking.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.booking.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
