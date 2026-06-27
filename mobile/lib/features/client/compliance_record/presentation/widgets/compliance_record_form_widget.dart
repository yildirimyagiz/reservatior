import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class ComplianceRecordFormWidget extends ConsumerStatefulWidget {
  final ComplianceRecord? item;
  final Function(ComplianceRecord) onSubmit;
  const ComplianceRecordFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<ComplianceRecordFormWidget> createState() =>
      _ComplianceRecordFormWidgetState();
}

class _ComplianceRecordFormWidgetState
    extends ConsumerState<ComplianceRecordFormWidget> {
  String? _entityId;
  String? _entityType;
  String? _documentUrl;
  DateTime? _expiryDate;
  String? _notes;
  bool? _isVerified;
  String? _propertyId;
  String? _agentId;
  String? _agencyId;
  String? _reservationId;
  @override
  void initState() {
    super.initState();
    _entityId = widget.item?.entityId;
    _entityType = widget.item?.entityType;
    _documentUrl = widget.item?.documentUrl;
    _expiryDate = widget.item?.expiryDate;
    _notes = widget.item?.notes;
    _isVerified = widget.item?.isVerified;
    _propertyId = widget.item?.propertyId;
    _agentId = widget.item?.agentId;
    _agencyId = widget.item?.agencyId;
    _reservationId = widget.item?.reservationId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.compliancerecord'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.compliancerecord'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _entityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entityid'.tr()),
              onChanged: (v) => _entityId = v,
            ),
            TextFormField(
              initialValue: _entityType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entitytype'.tr()),
              onChanged: (v) => _entityType = v,
            ),
            TextFormField(
              initialValue: _documentUrl?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.documenturl'.tr()),
              onChanged: (v) => _documentUrl = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_expiry_date'.tr()}: ${_expiryDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _expiryDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _expiryDate = d);
              },
            ),
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isverified'.tr()),
              value: _isVerified ?? false,
              onChanged: (v) => setState(() => _isVerified = v),
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _agentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentid'.tr()),
              onChanged: (v) => _agentId = v,
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_entityId != null) 'entityId': _entityId,
                  if (_entityType != null) 'entityType': _entityType,
                  if (_documentUrl != null) 'documentUrl': _documentUrl,
                  if (_expiryDate != null)
                    'expiryDate': _expiryDate!.toIso8601String(),
                  if (_notes != null) 'notes': _notes,
                  'isVerified': _isVerified,
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_agentId != null) 'agentId': _agentId,
                  if (_agencyId != null) 'agencyId': _agencyId,
                  if (_reservationId != null) 'reservationId': _reservationId,
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
                  widget.onSubmit(ComplianceRecord.fromJson(json));
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
