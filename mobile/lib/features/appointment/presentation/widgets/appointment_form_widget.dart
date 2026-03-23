import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Appointment Form Widget  |  Fields: propertyId, listingId, contactId, title, description, appointmentType, startDate, endDate, timezone, status, location, assignedToUserId, assignedToContactId, reminders, notes

class AppointmentFormWidget extends StatefulWidget {
  final Appointment? item;
  final void Function(Appointment)? onSubmit;
  const AppointmentFormWidget({super.key, this.item, this.onSubmit});
  @override State<AppointmentFormWidget> createState() => _AppointmentFormWidgetState();
}

class _AppointmentFormWidgetState extends State<AppointmentFormWidget> {
  final _key = GlobalKey<FormState>();
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
  String? _reminders;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _title = widget.item?.title?.toString();
    _description = widget.item?.description?.toString();
    _appointmentType = widget.item?.appointmentType?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _timezone = widget.item?.timezone?.toString();
    _status = widget.item?.status?.toString();
    _location = widget.item?.location?.toString();
    _assignedToUserId = widget.item?.assignedToUserId?.toString();
    _assignedToContactId = widget.item?.assignedToContactId?.toString();
    _reminders = widget.item?.reminders?.toString();
    _notes = widget.item?.notes?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_appointmentType?.isNotEmpty == true) 'appointmentType': _appointmentType,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_timezone?.isNotEmpty == true) 'timezone': _timezone,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_location?.isNotEmpty == true) 'location': _location,
        if (_assignedToUserId?.isNotEmpty == true) 'assignedToUserId': _assignedToUserId,
        if (_assignedToContactId?.isNotEmpty == true) 'assignedToContactId': _assignedToContactId,
        if (_reminders?.isNotEmpty == true) 'reminders': _reminders,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? Appointment.fromJson({...widget.item!.toJson(), ...data})
        : Appointment.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _propertyId?.toString() ?? '',
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _listingId?.toString() ?? '',
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _contactId?.toString() ?? '',
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Appointment Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _appointmentType?.toString() ?? '',
                onSaved: (v) => _appointmentType = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                initialValue: _status?.toString() ?? '',
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                initialValue: _location?.toString() ?? '',
                onSaved: (v) => _location = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assigned To User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _assignedToUserId?.toString() ?? '',
                onSaved: (v) => _assignedToUserId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assigned To Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _assignedToContactId?.toString() ?? '',
                onSaved: (v) => _assignedToContactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reminders', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _reminders?.toString() ?? '',
                onSaved: (v) => _reminders = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _notes?.toString() ?? '',
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Appointment'),
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