import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class LedgerEntryFormWidget extends ConsumerStatefulWidget {
  final LedgerEntry? item;
  final Function(LedgerEntry) onSubmit;
  const LedgerEntryFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<LedgerEntryFormWidget> createState() =>
      _LedgerEntryFormWidgetState();
}

class _LedgerEntryFormWidgetState extends ConsumerState<LedgerEntryFormWidget> {
  String? _propertyId;
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _contractId;
  String? _billId;
  String? _transactionId;
  double? _amount;
  String? _currency;
  DateTime? _occurredAt;
  String? _note;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _leaseId = widget.item?.leaseId;
    _bookingId = widget.item?.bookingId;
    _contractId = widget.item?.contractId;
    _billId = widget.item?.billId;
    _transactionId = widget.item?.transactionId;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency;
    _occurredAt = widget.item?.occurredAt;
    _note = widget.item?.note;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.ledgerentry'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.ledgerentry'.tr()}",
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
              initialValue: _contractId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contractid'.tr()),
              onChanged: (v) => _contractId = v,
            ),
            TextFormField(
              initialValue: _billId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.billid'.tr()),
              onChanged: (v) => _billId = v,
            ),
            TextFormField(
              initialValue: _transactionId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.transactionid'.tr()),
              onChanged: (v) => _transactionId = v,
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
            TextFormField(
              initialValue: _note?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.note'.tr()),
              onChanged: (v) => _note = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_bookingId != null) 'bookingId': _bookingId,
                  if (_contractId != null) 'contractId': _contractId,
                  if (_billId != null) 'billId': _billId,
                  if (_transactionId != null) 'transactionId': _transactionId,
                  if (_amount != null) 'amount': _amount,
                  if (_currency != null) 'currency': _currency,
                  if (_occurredAt != null)
                    'occurredAt': _occurredAt!.toIso8601String(),
                  if (_note != null) 'note': _note,
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
                  widget.onSubmit(LedgerEntry.fromJson(json));
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
