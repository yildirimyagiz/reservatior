import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class TaskFormWidget extends ConsumerStatefulWidget {
  final Task? item;
  final Function(Task) onSubmit;
  const TaskFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends ConsumerState<TaskFormWidget> {
  String? _propertyId;
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _contractId;
  String? _reservationId;
  String? _projectId;
  String? _title;
  String? _description;
  DateTime? _dueAt;
  int? _slaHours;
  String? _assignedToUserId;
  String? _assignedToContactId;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _leaseId = widget.item?.leaseId;
    _bookingId = widget.item?.bookingId;
    _contractId = widget.item?.contractId;
    _reservationId = widget.item?.reservationId;
    _projectId = widget.item?.projectId;
    _title = widget.item?.title;
    _description = widget.item?.description;
    _dueAt = widget.item?.dueAt;
    _slaHours = widget.item?.slaHours;
    _assignedToUserId = widget.item?.assignedToUserId;
    _assignedToContactId = widget.item?.assignedToContactId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.task'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.task'.tr()}",
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
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _projectId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.projectid'.tr()),
              onChanged: (v) => _projectId = v,
            ),
            TextFormField(
              initialValue: _title?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.title'.tr()),
              onChanged: (v) => _title = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_due_at'.tr()}: ${_dueAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _dueAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _dueAt = d);
              },
            ),
            TextFormField(
              initialValue: _slaHours?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.slahours'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _slaHours = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _assignedToUserId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.assignedtouserid'.tr()),
              onChanged: (v) => _assignedToUserId = v,
            ),
            TextFormField(
              initialValue: _assignedToContactId?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.assignedtocontactid'.tr(),
              ),
              onChanged: (v) => _assignedToContactId = v,
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
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_projectId != null) 'projectId': _projectId,
                  if (_title != null) 'title': _title,
                  if (_description != null) 'description': _description,
                  if (_dueAt != null) 'dueAt': _dueAt!.toIso8601String(),
                  if (_slaHours != null) 'slaHours': _slaHours,
                  if (_assignedToUserId != null)
                    'assignedToUserId': _assignedToUserId,
                  if (_assignedToContactId != null)
                    'assignedToContactId': _assignedToContactId,
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
                  widget.onSubmit(Task.fromJson(json));
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
