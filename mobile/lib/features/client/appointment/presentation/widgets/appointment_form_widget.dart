import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AppointmentFormWidget extends ConsumerStatefulWidget {
  final Appointment? item;
  final Function(Appointment) onSubmit;
  const AppointmentFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AppointmentFormWidget> createState() =>
      _AppointmentFormWidgetState();
}

class _AppointmentFormWidgetState extends ConsumerState<AppointmentFormWidget> {
  String? _propertyId;
  String? _listingId;
  String? _contactId;
  String? _title;
  String? _description;
  String? _appointmentType;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _timezone;
  String? _status;
  String? _location;
  String? _assignedToUserId;
  String? _assignedToContactId;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _contactId = widget.item?.contactId;
    _title = widget.item?.title;
    _description = widget.item?.description;
    _appointmentType = widget.item?.appointmentType;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _timezone = widget.item?.timezone;
    _status = widget.item?.status;
    _location = widget.item?.location;
    _assignedToUserId = widget.item?.assignedToUserId;
    _assignedToContactId = widget.item?.assignedToContactId;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.appointment'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.appointment'.tr()}",
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
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
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
            TextFormField(
              initialValue: _appointmentType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.appointmenttype'.tr()),
              onChanged: (v) => _appointmentType = v,
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
              initialValue: _timezone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.timezone'.tr()),
              onChanged: (v) => _timezone = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _location?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.location'.tr()),
              onChanged: (v) => _location = v,
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
            TextFormField(
              initialValue: _notes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.notes'.tr()),
              onChanged: (v) => _notes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_title != null) 'title': _title,
                  if (_description != null) 'description': _description,
                  if (_appointmentType != null)
                    'appointmentType': _appointmentType,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_timezone != null) 'timezone': _timezone,
                  if (_status != null) 'status': _status,
                  if (_location != null) 'location': _location,
                  if (_assignedToUserId != null)
                    'assignedToUserId': _assignedToUserId,
                  if (_assignedToContactId != null)
                    'assignedToContactId': _assignedToContactId,
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
                  widget.onSubmit(Appointment.fromJson(json));
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
