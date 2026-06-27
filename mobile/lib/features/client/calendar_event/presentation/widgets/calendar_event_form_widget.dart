import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class CalendarEventFormWidget extends ConsumerStatefulWidget {
  final CalendarEvent? item;
  final Function(CalendarEvent) onSubmit;
  const CalendarEventFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<CalendarEventFormWidget> createState() =>
      _CalendarEventFormWidgetState();
}

class _CalendarEventFormWidgetState
    extends ConsumerState<CalendarEventFormWidget> {
  String? _userId;
  String? _externalId;
  String? _externalSource;
  String? _title;
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _timezone;
  String? _location;
  bool? _isAllDay;
  DateTime? _lastSyncedAt;
  String? _syncStatus;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _externalId = widget.item?.externalId;
    _externalSource = widget.item?.externalSource;
    _title = widget.item?.title;
    _description = widget.item?.description;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _timezone = widget.item?.timezone;
    _location = widget.item?.location;
    _isAllDay = widget.item?.isAllDay;
    _lastSyncedAt = widget.item?.lastSyncedAt;
    _syncStatus = widget.item?.syncStatus;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.calendarevent'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.calendarevent'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _externalId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.externalid'.tr()),
              onChanged: (v) => _externalId = v,
            ),
            TextFormField(
              initialValue: _externalSource?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.externalsource'.tr()),
              onChanged: (v) => _externalSource = v,
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
              initialValue: _location?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.location'.tr()),
              onChanged: (v) => _location = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isallday'.tr()),
              value: _isAllDay ?? false,
              onChanged: (v) => setState(() => _isAllDay = v),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_last_synced_at'.tr()}: ${_lastSyncedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastSyncedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastSyncedAt = d);
              },
            ),
            TextFormField(
              initialValue: _syncStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.syncstatus'.tr()),
              onChanged: (v) => _syncStatus = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_externalId != null) 'externalId': _externalId,
                  if (_externalSource != null)
                    'externalSource': _externalSource,
                  if (_title != null) 'title': _title,
                  if (_description != null) 'description': _description,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_timezone != null) 'timezone': _timezone,
                  if (_location != null) 'location': _location,
                  'isAllDay': _isAllDay,
                  if (_lastSyncedAt != null)
                    'lastSyncedAt': _lastSyncedAt!.toIso8601String(),
                  if (_syncStatus != null) 'syncStatus': _syncStatus,
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
                  widget.onSubmit(CalendarEvent.fromJson(json));
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
