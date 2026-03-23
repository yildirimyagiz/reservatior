import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── CalendarEvent Form Widget  |  Fields: userId, externalId, externalSource, title, description, startDate, endDate, timezone, location, attendees, isAllDay, recurrence, reminders, lastSyncedAt, syncStatus

class CalendarEventFormWidget extends StatefulWidget {
  final CalendarEvent? item;
  final void Function(CalendarEvent)? onSubmit;
  const CalendarEventFormWidget({super.key, this.item, this.onSubmit});
  @override State<CalendarEventFormWidget> createState() => _CalendarEventFormWidgetState();
}

class _CalendarEventFormWidgetState extends State<CalendarEventFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _externalId;
  String? _externalSource;
  String? _title;
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _timezone;
  String? _location;
  String? _attendees;
  bool _isAllDay = false;
  String? _recurrence;
  String? _reminders;
  DateTime? _lastSyncedAt;
  String? _syncStatus;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _externalId = widget.item?.externalId?.toString();
    _externalSource = widget.item?.externalSource?.toString();
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _timezone = widget.item?.timezone?.toString();
    _location = widget.item?.location?.toString();
    _attendees = widget.item?.attendees?.toString();
    _isAllDay = widget.item?.isAllDay ?? false;
    _recurrence = widget.item?.recurrence?.toString();
    _reminders = widget.item?.reminders?.toString();
    _lastSyncedAt = widget.item?.lastSyncedAt;
    _syncStatus = widget.item?.syncStatus?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_externalId?.isNotEmpty == true) 'externalId': _externalId,
        if (_externalSource?.isNotEmpty == true) 'externalSource': _externalSource,
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_timezone?.isNotEmpty == true) 'timezone': _timezone,
        if (_location?.isNotEmpty == true) 'location': _location,
        if (_attendees?.isNotEmpty == true) 'attendees': _attendees,
        'isAllDay': _isAllDay,
        if (_recurrence?.isNotEmpty == true) 'recurrence': _recurrence,
        if (_reminders?.isNotEmpty == true) 'reminders': _reminders,
        if (_lastSyncedAt != null) 'lastSyncedAt': _lastSyncedAt!.toIso8601String(),
        if (_syncStatus?.isNotEmpty == true) 'syncStatus': _syncStatus,
    };
    final result = widget.item != null
        ? CalendarEvent.fromJson({...widget.item!.toJson(), ...data})
        : CalendarEvent.fromJson(data);
    widget.onSubmit?.call(result);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _userId?.toString() ?? '',
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'External Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _externalId?.toString() ?? '',
                onSaved: (v) => _externalId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'External Source', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _externalSource?.toString() ?? '',
                onSaved: (v) => _externalSource = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _title?.toString() ?? '',
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _description?.toString() ?? '',
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Start Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startDate != null ? _fmt(_startDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _endDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'End Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_endDate != null ? _fmt(_endDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Timezone', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _timezone?.toString() ?? '',
                onSaved: (v) => _timezone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                initialValue: _location?.toString() ?? '',
                onSaved: (v) => _location = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Attendees', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _attendees?.toString() ?? '',
                onSaved: (v) => _attendees = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is All Day'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isAllDay,
                  onChanged: (v) { ss(() {}); setState(() => _isAllDay = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Recurrence', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _recurrence?.toString() ?? '',
                onSaved: (v) => _recurrence = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reminders', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _reminders?.toString() ?? '',
                onSaved: (v) => _reminders = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastSyncedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastSyncedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Synced At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastSyncedAt != null ? _fmt(_lastSyncedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sync Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                initialValue: _syncStatus?.toString() ?? '',
                onSaved: (v) => _syncStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Calendar Event'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
            ),
          ],
        ),
      ),
    );
  }
}

String _fmt(DateTime? d) {
  if (d == null) return 'N/A';
  final mo = d.month.toString().padLeft(2,'0');
  final day = d.day.toString().padLeft(2,'0');
  final h = d.hour.toString().padLeft(2,'0');
  final mi = d.minute.toString().padLeft(2,'0');
  return '${d.year}-$mo-$day $h:$mi';
}