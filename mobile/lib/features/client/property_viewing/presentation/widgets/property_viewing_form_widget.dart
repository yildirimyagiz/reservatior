import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PropertyViewingFormWidget extends ConsumerStatefulWidget {
  final PropertyViewing? item;
  final Function(PropertyViewing) onSubmit;
  const PropertyViewingFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PropertyViewingFormWidget> createState() =>
      _PropertyViewingFormWidgetState();
}

class _PropertyViewingFormWidgetState
    extends ConsumerState<PropertyViewingFormWidget> {
  String? _propertyId;
  String? _listingId;
  String? _viewingType;
  DateTime? _scheduledDate;
  int? _duration;
  String? _attendeeName;
  String? _attendeeEmail;
  String? _attendeePhone;
  String? _attendeeType;
  String? _status;
  String? _assignedAgentId;
  String? _feedback;
  String? _interestedLevel;
  bool? _followUpRequired;
  String? _followUpNotes;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _listingId = widget.item?.listingId;
    _viewingType = widget.item?.viewingType;
    _scheduledDate = widget.item?.scheduledDate;
    _duration = widget.item?.duration;
    _attendeeName = widget.item?.attendeeName;
    _attendeeEmail = widget.item?.attendeeEmail;
    _attendeePhone = widget.item?.attendeePhone;
    _attendeeType = widget.item?.attendeeType;
    _status = widget.item?.status;
    _assignedAgentId = widget.item?.assignedAgentId;
    _feedback = widget.item?.feedback;
    _interestedLevel = widget.item?.interestedLevel;
    _followUpRequired = widget.item?.followUpRequired;
    _followUpNotes = widget.item?.followUpNotes;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.propertyviewing'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.propertyviewing'.tr()}",
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
              initialValue: _viewingType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.viewingtype'.tr()),
              onChanged: (v) => _viewingType = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_scheduled_date'.tr()}: ${_scheduledDate ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _scheduledDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _scheduledDate = d);
              },
            ),
            TextFormField(
              initialValue: _duration?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.duration'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _duration = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _attendeeName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.attendeename'.tr()),
              onChanged: (v) => _attendeeName = v,
            ),
            TextFormField(
              initialValue: _attendeeEmail?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.attendeeemail'.tr()),
              onChanged: (v) => _attendeeEmail = v,
            ),
            TextFormField(
              initialValue: _attendeePhone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.attendeephone'.tr()),
              onChanged: (v) => _attendeePhone = v,
            ),
            TextFormField(
              initialValue: _attendeeType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.attendeetype'.tr()),
              onChanged: (v) => _attendeeType = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            TextFormField(
              initialValue: _assignedAgentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.assignedagentid'.tr()),
              onChanged: (v) => _assignedAgentId = v,
            ),
            TextFormField(
              initialValue: _feedback?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.feedback'.tr()),
              onChanged: (v) => _feedback = v,
            ),
            TextFormField(
              initialValue: _interestedLevel?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.interestedlevel'.tr()),
              onChanged: (v) => _interestedLevel = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.followuprequired'.tr()),
              value: _followUpRequired ?? false,
              onChanged: (v) => setState(() => _followUpRequired = v),
            ),
            TextFormField(
              initialValue: _followUpNotes?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.followupnotes'.tr()),
              onChanged: (v) => _followUpNotes = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_listingId != null) 'listingId': _listingId,
                  if (_viewingType != null) 'viewingType': _viewingType,
                  if (_scheduledDate != null)
                    'scheduledDate': _scheduledDate!.toIso8601String(),
                  if (_duration != null) 'duration': _duration,
                  if (_attendeeName != null) 'attendeeName': _attendeeName,
                  if (_attendeeEmail != null) 'attendeeEmail': _attendeeEmail,
                  if (_attendeePhone != null) 'attendeePhone': _attendeePhone,
                  if (_attendeeType != null) 'attendeeType': _attendeeType,
                  if (_status != null) 'status': _status,
                  if (_assignedAgentId != null)
                    'assignedAgentId': _assignedAgentId,
                  if (_feedback != null) 'feedback': _feedback,
                  if (_interestedLevel != null)
                    'interestedLevel': _interestedLevel,
                  'followUpRequired': _followUpRequired,
                  if (_followUpNotes != null) 'followUpNotes': _followUpNotes,
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
                  widget.onSubmit(PropertyViewing.fromJson(json));
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
