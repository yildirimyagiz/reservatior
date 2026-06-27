import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class RightToRentCheckFormWidget extends ConsumerStatefulWidget {
  final RightToRentCheck? item;
  final Function(RightToRentCheck) onSubmit;
  const RightToRentCheckFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<RightToRentCheckFormWidget> createState() =>
      _RightToRentCheckFormWidgetState();
}

class _RightToRentCheckFormWidgetState
    extends ConsumerState<RightToRentCheckFormWidget> {
  String? _leaseId;
  String? _contactId;
  String? _checkType;
  String? _reference;
  String? _status;
  DateTime? _checkedAt;
  DateTime? _expiresAt;
  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId;
    _contactId = widget.item?.contactId;
    _checkType = widget.item?.checkType;
    _reference = widget.item?.reference;
    _status = widget.item?.status;
    _checkedAt = widget.item?.checkedAt;
    _expiresAt = widget.item?.expiresAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.righttorentcheck'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.righttorentcheck'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            TextFormField(
              initialValue: _checkType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checktype'.tr()),
              onChanged: (v) => _checkType = v,
            ),
            TextFormField(
              initialValue: _reference?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reference'.tr()),
              onChanged: (v) => _reference = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_checked_at'.tr()}: ${_checkedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _checkedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _checkedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expires_at'.tr()}: ${_expiresAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiresAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiresAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_checkType != null) 'checkType': _checkType,
                  if (_reference != null) 'reference': _reference,
                  if (_status != null) 'status': _status,
                  if (_checkedAt != null)
                    'checkedAt': _checkedAt!.toIso8601String(),
                  if (_expiresAt != null)
                    'expiresAt': _expiresAt!.toIso8601String(),
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
                  widget.onSubmit(RightToRentCheck.fromJson(json));
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
