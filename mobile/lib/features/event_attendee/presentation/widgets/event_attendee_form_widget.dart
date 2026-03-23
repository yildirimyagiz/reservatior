import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── EventAttendee Form Widget  |  Fields: eventId, contactId, userId, rsvpStatus, notes

class EventAttendeeFormWidget extends StatefulWidget {
  final EventAttendee? item;
  final void Function(EventAttendee)? onSubmit;
  const EventAttendeeFormWidget({super.key, this.item, this.onSubmit});
  @override State<EventAttendeeFormWidget> createState() => _EventAttendeeFormWidgetState();
}

class _EventAttendeeFormWidgetState extends State<EventAttendeeFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _eventId;
  String? _contactId;
  String? _userId;
  String? _rsvpStatus;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _eventId = widget.item?.eventId?.toString();
    _contactId = widget.item?.contactId?.toString();
    _userId = widget.item?.userId?.toString();
    _rsvpStatus = widget.item?.rsvpStatus?.toString();
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
        if (_eventId?.isNotEmpty == true) 'eventId': _eventId,
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_rsvpStatus?.isNotEmpty == true) 'rsvpStatus': _rsvpStatus,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? EventAttendee.fromJson({...widget.item!.toJson(), ...data})
        : EventAttendee.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Event Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _eventId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rsvp Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _rsvpStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Event Attendee'),
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