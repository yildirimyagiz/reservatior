import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class FinancialRecordFormWidget extends ConsumerStatefulWidget {
  final FinancialRecord? item;
  final Function(FinancialRecord) onSubmit;
  const FinancialRecordFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<FinancialRecordFormWidget> createState() =>
      _FinancialRecordFormWidgetState();
}

class _FinancialRecordFormWidgetState
    extends ConsumerState<FinancialRecordFormWidget> {
  String? _propertyId;
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _reservationId;
  String? _vendorContactId;
  String? _type;
  double? _amount;
  String? _currency;
  DateTime? _occurredAt;
  DateTime? _dueDate;
  String? _category;
  String? _description;
  String? _notes;
  DateTime? _paidAt;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _leaseId = widget.item?.leaseId;
    _bookingId = widget.item?.bookingId;
    _reservationId = widget.item?.reservationId;
    _vendorContactId = widget.item?.vendorContactId;
    _type = widget.item?.type;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency;
    _occurredAt = widget.item?.occurredAt;
    _dueDate = widget.item?.dueDate;
    _category = widget.item?.category;
    _description = widget.item?.description;
    _notes = widget.item?.notes;
    _paidAt = widget.item?.paidAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.financialrecord'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.financialrecord'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            TextFormField(
              initialValue: _bookingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.bookingid'.tr()),
              onChanged: (v) => _bookingId = v,
            ),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _vendorContactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.vendorcontactid'.tr()),
              onChanged: (v) => _vendorContactId = v,
            ),
            TextFormField(
              initialValue: _type?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.type'.tr()),
              onChanged: (v) => _type = v,
            ),
            TextFormField(
              initialValue: _amount?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.amount'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _amount = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_occurred_at'.tr()}: ${_occurredAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _occurredAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _occurredAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_due_date'.tr()}: ${_dueDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _dueDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _dueDate = d);
              },
            ),
            TextFormField(
              initialValue: _category?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.category'.tr()),
              onChanged: (v) => _category = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_paid_at'.tr()}: ${_paidAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _paidAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _paidAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_bookingId != null) 'bookingId': _bookingId,
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_vendorContactId != null)
                    'vendorContactId': _vendorContactId,
                  if (_type != null) 'type': _type,
                  if (_amount != null) 'amount': _amount,
                  if (_currency != null) 'currency': _currency,
                  if (_occurredAt != null)
                    'occurredAt': _occurredAt!.toIso8601String(),
                  if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
                  if (_category != null) 'category': _category,
                  if (_description != null) 'description': _description,
                  if (_notes != null) 'notes': _notes,
                  if (_paidAt != null) 'paidAt': _paidAt!.toIso8601String(),
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
                  widget.onSubmit(FinancialRecord.fromJson(json));
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
