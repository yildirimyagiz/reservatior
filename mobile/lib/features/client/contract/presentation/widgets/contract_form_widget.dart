import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ContractFormWidget extends ConsumerStatefulWidget {
  final Contract? item;
  final Function(Contract) onSubmit;
  const ContractFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<ContractFormWidget> createState() => _ContractFormWidgetState();
}

class _ContractFormWidgetState extends ConsumerState<ContractFormWidget> {
  String? _propertyId;
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _title;
  DateTime? _effectiveFrom;
  DateTime? _effectiveTo;
  DateTime? _nextRenewalAt;
  int? _renewalNoticeDays;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _leaseId = widget.item?.leaseId;
    _bookingId = widget.item?.bookingId;
    _title = widget.item?.title;
    _effectiveFrom = widget.item?.effectiveFrom;
    _effectiveTo = widget.item?.effectiveTo;
    _nextRenewalAt = widget.item?.nextRenewalAt;
    _renewalNoticeDays = widget.item?.renewalNoticeDays;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.contract'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.contract'.tr()}",
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
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_effective_from'.tr()}: ${_effectiveFrom ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _effectiveFrom ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _effectiveFrom = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_effective_to'.tr()}: ${_effectiveTo ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _effectiveTo ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _effectiveTo = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_next_renewal_at'.tr()}: ${_nextRenewalAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _nextRenewalAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _nextRenewalAt = d);
              },
            ),
            TextFormField(
              initialValue: _renewalNoticeDays?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.renewalnoticedays'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _renewalNoticeDays = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_bookingId != null) 'bookingId': _bookingId,
                  if (_title != null) 'title': _title,
                  if (_effectiveFrom != null)
                    'effectiveFrom': _effectiveFrom!.toIso8601String(),
                  if (_effectiveTo != null)
                    'effectiveTo': _effectiveTo!.toIso8601String(),
                  if (_nextRenewalAt != null)
                    'nextRenewalAt': _nextRenewalAt!.toIso8601String(),
                  if (_renewalNoticeDays != null)
                    'renewalNoticeDays': _renewalNoticeDays,
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
                  widget.onSubmit(Contract.fromJson(json));
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
