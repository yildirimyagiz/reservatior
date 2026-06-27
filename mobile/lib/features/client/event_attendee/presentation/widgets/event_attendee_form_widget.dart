import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class EventAttendeeFormWidget extends ConsumerStatefulWidget {
  final EventAttendee? item;
  final Function(EventAttendee) onSubmit;
  const EventAttendeeFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<EventAttendeeFormWidget> createState() =>
      _EventAttendeeFormWidgetState();
}

class _EventAttendeeFormWidgetState
    extends ConsumerState<EventAttendeeFormWidget> {
  String? _eventId;
  String? _contactId;
  String? _userId;
  String? _rsvpStatus;
  String? _notes;
  @override
  void initState() {
    super.initState();
    _eventId = widget.item?.eventId;
    _contactId = widget.item?.contactId;
    _userId = widget.item?.userId;
    _rsvpStatus = widget.item?.rsvpStatus;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.eventattendee'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.eventattendee'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _eventId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.eventid'.tr()),
              onChanged: (v) => _eventId = v,
            ),
            TextFormField(
              initialValue: _contactId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.contactid'.tr()),
              onChanged: (v) => _contactId = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _rsvpStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.rsvpstatus'.tr()),
              onChanged: (v) => _rsvpStatus = v,
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
                  if (_eventId != null) 'eventId': _eventId,
                  if (_contactId != null) 'contactId': _contactId,
                  if (_userId != null) 'userId': _userId,
                  if (_rsvpStatus != null) 'rsvpStatus': _rsvpStatus,
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
                  widget.onSubmit(EventAttendee.fromJson(json));
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
