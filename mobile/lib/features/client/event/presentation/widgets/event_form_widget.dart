import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class EventFormWidget extends ConsumerStatefulWidget {
  final Event? item;
  final Function(Event) onSubmit;
  const EventFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<EventFormWidget> createState() => _EventFormWidgetState();
}

class _EventFormWidgetState extends ConsumerState<EventFormWidget> {
  String? _propertyId;
  String? _name;
  String? _description;
  String? _eventType;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _maxAttendees;
  bool? _isPublic;
  String? _status;
  bool? _isActive;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _name = widget.item?.name;
    _description = widget.item?.description;
    _eventType = widget.item?.eventType;
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _maxAttendees = widget.item?.maxAttendees;
    _isPublic = widget.item?.isPublic;
    _status = widget.item?.status;
    _isActive = widget.item?.isActive;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.event'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.event'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _name?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.name'.tr()),
              onChanged: (v) => _name = v,
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _eventType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.eventtype'.tr()),
              onChanged: (v) => _eventType = v,
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
              initialValue: _maxAttendees?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxattendees'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxAttendees = int.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.ispublic'.tr()),
              value: _isPublic ?? false,
              onChanged: (v) => setState(() => _isPublic = v),
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            SwitchListTile(
              title: Text('mobile.auto.isactive'.tr()),
              value: _isActive ?? false,
              onChanged: (v) => setState(() => _isActive = v),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_name != null) 'name': _name,
                  if (_description != null) 'description': _description,
                  if (_eventType != null) 'eventType': _eventType,
                  if (_startDate != null)
                    'startDate': _startDate!.toIso8601String(),
                  if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
                  if (_maxAttendees != null) 'maxAttendees': _maxAttendees,
                  'isPublic': _isPublic,
                  if (_status != null) 'status': _status,
                  'isActive': _isActive,
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
                  widget.onSubmit(Event.fromJson(json));
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
