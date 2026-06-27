import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class SolicitorManagementFormWidget extends ConsumerStatefulWidget {
  final SolicitorManagement? item;
  final Function(SolicitorManagement) onSubmit;
  const SolicitorManagementFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<SolicitorManagementFormWidget> createState() =>
      _SolicitorManagementFormWidgetState();
}

class _SolicitorManagementFormWidgetState
    extends ConsumerState<SolicitorManagementFormWidget> {
  String? _dealId;
  String? _contactId;
  String? _solicitorType;
  String? _status;
  DateTime? _engagedAt;
  DateTime? _completedAt;
  double? _fee;
  String? _currency;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId;
    _contactId = widget.item?.contactId;
    _solicitorType = widget.item?.solicitorType;
    _status = widget.item?.status;
    _engagedAt = widget.item?.engagedAt;
    _completedAt = widget.item?.completedAt;
    _fee = widget.item?.fee;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.solicitormanagement'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.solicitormanagement'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _dealId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.dealid'.tr()),
              onChanged: (v) => _dealId = v,
            ),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            TextFormField(
              initialValue: _solicitorType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.solicitortype'.tr()),
              onChanged: (v) => _solicitorType = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_engaged_at'.tr()}: ${_engagedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _engagedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _engagedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_completed_at'.tr()}: ${_completedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _completedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _completedAt = d);
              },
            ),
            TextFormField(
              initialValue: _fee?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.fee'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _fee = double.tryParse(v ?? ""),
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
                  if (_dealId != null) 'dealId': _dealId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_solicitorType != null) 'solicitorType': _solicitorType,
                  if (_status != null) 'status': _status,
                  if (_engagedAt != null)
                    'engagedAt': _engagedAt!.toIso8601String(),
                  if (_completedAt != null)
                    'completedAt': _completedAt!.toIso8601String(),
                  if (_fee != null) 'fee': _fee,
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
                  widget.onSubmit(SolicitorManagement.fromJson(json));
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
