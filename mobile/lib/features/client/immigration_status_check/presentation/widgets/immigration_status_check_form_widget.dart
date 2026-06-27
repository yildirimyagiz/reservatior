import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ImmigrationStatusCheckFormWidget extends ConsumerStatefulWidget {
  final ImmigrationStatusCheck? item;
  final Function(ImmigrationStatusCheck) onSubmit;
  const ImmigrationStatusCheckFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<ImmigrationStatusCheckFormWidget> createState() =>
      _ImmigrationStatusCheckFormWidgetState();
}

class _ImmigrationStatusCheckFormWidgetState
    extends ConsumerState<ImmigrationStatusCheckFormWidget> {
  String? _leaseId;
  String? _tenantId;
  String? _checkStatus;
  DateTime? _checkDate;
  DateTime? _validUntil;
  String? _immigrationStatus;
  String? _visaType;
  DateTime? _visaExpiry;
  String? _documentType;
  String? _documentNumber;
  bool? _documentVerified;
  String? _shareCode;
  String? _checkReference;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId;
    _tenantId = widget.item?.tenantId;
    _checkStatus = widget.item?.checkStatus;
    _checkDate = widget.item?.checkDate;
    _validUntil = widget.item?.validUntil;
    _immigrationStatus = widget.item?.immigrationStatus;
    _visaType = widget.item?.visaType;
    _visaExpiry = widget.item?.visaExpiry;
    _documentType = widget.item?.documentType;
    _documentNumber = widget.item?.documentNumber;
    _documentVerified = widget.item?.documentVerified;
    _shareCode = widget.item?.shareCode;
    _checkReference = widget.item?.checkReference;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.immigrationstatuscheck'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.immigrationstatuscheck'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _leaseId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.leaseid'.tr()),
              onChanged: (v) => _leaseId = v,
            ),
            TextFormField(
              initialValue: _tenantId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tenantid'.tr()),
              onChanged: (v) => _tenantId = v,
            ),
            TextFormField(
              initialValue: _checkStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checkstatus'.tr()),
              onChanged: (v) => _checkStatus = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_check_date'.tr()}: ${_checkDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _checkDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _checkDate = d);
              },
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
            TextFormField(
              initialValue: _immigrationStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.immigrationstatus'.tr()),
              onChanged: (v) => _immigrationStatus = v,
            ),
            TextFormField(
              initialValue: _visaType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.visatype'.tr()),
              onChanged: (v) => _visaType = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_visa_expiry'.tr()}: ${_visaExpiry ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _visaExpiry ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _visaExpiry = d);
              },
            ),
            TextFormField(
              initialValue: _documentType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.documenttype'.tr()),
              onChanged: (v) => _documentType = v,
            ),
            TextFormField(
              initialValue: _documentNumber?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.documentnumber'.tr()),
              onChanged: (v) => _documentNumber = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.documentverified'.tr()),
              value: _documentVerified ?? false,
              onChanged: (v) => setState(() => _documentVerified = v),
            ),
            TextFormField(
              initialValue: _shareCode?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.sharecode'.tr()),
              onChanged: (v) => _shareCode = v,
            ),
            TextFormField(
              initialValue: _checkReference?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.checkreference'.tr()),
              onChanged: (v) => _checkReference = v,
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
                  if (_leaseId != null) 'leaseId': _leaseId,
                  if (_tenantId != null) 'tenantId': _tenantId,
                  if (_checkStatus != null) 'checkStatus': _checkStatus,
                  if (_checkDate != null)
                    'checkDate': _checkDate!.toIso8601String(),
                  if (_validUntil != null)
                    'validUntil': _validUntil!.toIso8601String(),
                  if (_immigrationStatus != null)
                    'immigrationStatus': _immigrationStatus,
                  if (_visaType != null) 'visaType': _visaType,
                  if (_visaExpiry != null)
                    'visaExpiry': _visaExpiry!.toIso8601String(),
                  if (_documentType != null) 'documentType': _documentType,
                  if (_documentNumber != null)
                    'documentNumber': _documentNumber,
                  'documentVerified': _documentVerified,
                  if (_shareCode != null) 'shareCode': _shareCode,
                  if (_checkReference != null)
                    'checkReference': _checkReference,
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
                  widget.onSubmit(ImmigrationStatusCheck.fromJson(json));
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
