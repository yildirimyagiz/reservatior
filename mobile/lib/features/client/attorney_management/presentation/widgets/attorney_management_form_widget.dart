import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AttorneyManagementFormWidget extends ConsumerStatefulWidget {
  final AttorneyManagement? item;
  final Function(AttorneyManagement) onSubmit;
  const AttorneyManagementFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AttorneyManagementFormWidget> createState() =>
      _AttorneyManagementFormWidgetState();
}

class _AttorneyManagementFormWidgetState
    extends ConsumerState<AttorneyManagementFormWidget> {
  String? _dealId;
  String? _contactId;
  String? _solicitorFirm;
  String? _solicitorName;
  String? _solicitorEmail;
  String? _solicitorPhone;
  String? _appointmentType;
  DateTime? _appointmentDate;
  String? _appointmentNotes;
  String? _status;
  DateTime? _searchDate;
  DateTime? _draftContractDate;
  DateTime? _finalContractDate;
  DateTime? _completionDate;
  String? _completionNotes;
  @override
  void initState() {
    super.initState();
    _dealId = widget.item?.dealId;
    _contactId = widget.item?.contactId;
    _solicitorFirm = widget.item?.solicitorFirm;
    _solicitorName = widget.item?.solicitorName;
    _solicitorEmail = widget.item?.solicitorEmail;
    _solicitorPhone = widget.item?.solicitorPhone;
    _appointmentType = widget.item?.appointmentType;
    _appointmentDate = widget.item?.appointmentDate;
    _appointmentNotes = widget.item?.appointmentNotes;
    _status = widget.item?.status;
    _searchDate = widget.item?.searchDate;
    _draftContractDate = widget.item?.draftContractDate;
    _finalContractDate = widget.item?.finalContractDate;
    _completionDate = widget.item?.completionDate;
    _completionNotes = widget.item?.completionNotes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.attorneymanagement'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.attorneymanagement'.tr()}",
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
              initialValue: _solicitorFirm?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.solicitorfirm'.tr()),
              onChanged: (v) => _solicitorFirm = v,
            ),
            TextFormField(
              initialValue: _solicitorName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.solicitorname'.tr()),
              onChanged: (v) => _solicitorName = v,
            ),
            TextFormField(
              initialValue: _solicitorEmail?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.solicitoremail'.tr()),
              onChanged: (v) => _solicitorEmail = v,
            ),
            TextFormField(
              initialValue: _solicitorPhone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.solicitorphone'.tr()),
              onChanged: (v) => _solicitorPhone = v,
            ),
            TextFormField(
              initialValue: _appointmentType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.appointmenttype'.tr()),
              onChanged: (v) => _appointmentType = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_appointment_date'.tr()}: ${_appointmentDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _appointmentDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _appointmentDate = d);
              },
            ),
            TextFormField(
              initialValue: _appointmentNotes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.appointmentnotes'.tr()),
              onChanged: (v) => _appointmentNotes = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_search_date'.tr()}: ${_searchDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _searchDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _searchDate = d);
              },
            ),
            ListTile(
              title: Text(
                'draftContractDate: ${_draftContractDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _draftContractDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _draftContractDate = d);
              },
            ),
            ListTile(
              title: Text(
                'finalContractDate: ${_finalContractDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _finalContractDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _finalContractDate = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_completion_date'.tr()}: ${_completionDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _completionDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _completionDate = d);
              },
            ),
            TextFormField(
              initialValue: _completionNotes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.completionnotes'.tr()),
              onChanged: (v) => _completionNotes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_dealId != null) 'dealId': _dealId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_solicitorFirm != null) 'solicitorFirm': _solicitorFirm,
                  if (_solicitorName != null) 'solicitorName': _solicitorName,
                  if (_solicitorEmail != null)
                    'solicitorEmail': _solicitorEmail,
                  if (_solicitorPhone != null)
                    'solicitorPhone': _solicitorPhone,
                  if (_appointmentType != null)
                    'appointmentType': _appointmentType,
                  if (_appointmentDate != null)
                    'appointmentDate': _appointmentDate!.toIso8601String(),
                  if (_appointmentNotes != null)
                    'appointmentNotes': _appointmentNotes,
                  if (_status != null) 'status': _status,
                  if (_searchDate != null)
                    'searchDate': _searchDate!.toIso8601String(),
                  if (_draftContractDate != null)
                    'draftContractDate': _draftContractDate!.toIso8601String(),
                  if (_finalContractDate != null)
                    'finalContractDate': _finalContractDate!.toIso8601String(),
                  if (_completionDate != null)
                    'completionDate': _completionDate!.toIso8601String(),
                  if (_completionNotes != null)
                    'completionNotes': _completionNotes,
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
                  widget.onSubmit(AttorneyManagement.fromJson(json));
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
