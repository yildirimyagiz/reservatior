import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class LeaseFormWidget extends ConsumerStatefulWidget {
  final Lease? item;
  final Function(Lease) onSubmit;
  const LeaseFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<LeaseFormWidget> createState() => _LeaseFormWidgetState();
}

class _LeaseFormWidgetState extends ConsumerState<LeaseFormWidget> {
  String? _listingId;
  String? _tenantId;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _rent;
  String? _currency;
  double? _deposit;
  int? _rentDueDay;
  String? _notes;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId;
    _tenantId = widget.item?.tenantId;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _rent = widget.item?.rent;
    _currency = widget.item?.currency;
    _deposit = widget.item?.deposit;
    _rentDueDay = widget.item?.rentDueDay;
    _notes = widget.item?.notes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.lease'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.lease'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _listingId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.listingid'.tr()),
              onChanged: (v) => _listingId = v,
            ),
            TextFormField(
              initialValue: _tenantId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tenantid'.tr()),
              onChanged: (v) => _tenantId = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_start_date'.tr()}: ${_startDate ?? 'mobile.admin.select'.tr()}"),
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
              title: Text("${'mobile.admin.field_end_date'.tr()}: ${_endDate ?? 'mobile.admin.select'.tr()}"),
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
              initialValue: _rent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rent'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _rent = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _currency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.currency'.tr()),
              onChanged: (v) => _currency = v,
            ),
            TextFormField(
              initialValue: _deposit?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.deposit'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _deposit = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _rentDueDay?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rentdueday'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _rentDueDay = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
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
                  if (_listingId != null) 'listingId': _listingId,
                  if (_tenantId != null) 'tenantId': _tenantId,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_rent != null) 'rent': _rent,
                  if (_currency != null) 'currency': _currency,
                  if (_deposit != null) 'deposit': _deposit,
                  if (_rentDueDay != null) 'rentDueDay': _rentDueDay,
                  if (_notes != null) 'notes': _notes,
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
                  widget.onSubmit(Lease.fromJson(json));
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
