import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AnalyticsFormWidget extends ConsumerStatefulWidget {
  final Analytics? item;
  final Function(Analytics) onSubmit;
  const AnalyticsFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<AnalyticsFormWidget> createState() =>
      _AnalyticsFormWidgetState();
}

class _AnalyticsFormWidgetState extends ConsumerState<AnalyticsFormWidget> {
  String? _entityId;
  String? _entityType;
  DateTime? _timestamp;
  String? _propertyId;
  String? _userId;
  String? _agentId;
  String? _agencyId;
  String? _reservationId;
  String? _taskId;
  String? _taxRecordId;
  dynamic? _agency;
  dynamic? _agent;
  dynamic? _property;
  dynamic? _reservation;
  dynamic? _task;
  @override
  void initState() {
    super.initState();
    _entityId = widget.item?.entityId;
    _entityType = widget.item?.entityType;
    _timestamp = widget.item?.timestamp;
    _propertyId = widget.item?.propertyId;
    _userId = widget.item?.userId;
    _agentId = widget.item?.agentId;
    _agencyId = widget.item?.agencyId;
    _reservationId = widget.item?.reservationId;
    _taskId = widget.item?.taskId;
    _taxRecordId = widget.item?.taxRecordId;
    _agency = widget.item?.agency;
    _agent = widget.item?.agent;
    _property = widget.item?.property;
    _reservation = widget.item?.reservation;
    _task = widget.item?.task;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.analytics'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.analytics'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _entityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entityid'.tr()),
              onChanged: (v) => _entityId = v,
            ),
            TextFormField(
              initialValue: _entityType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entitytype'.tr()),
              onChanged: (v) => _entityType = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_timestamp'.tr()}: ${_timestamp ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _timestamp ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _timestamp = d);
              },
            ),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _agentId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agentid'.tr()),
              onChanged: (v) => _agentId = v,
            ),
            TextFormField(
              initialValue: _agencyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agencyid'.tr()),
              onChanged: (v) => _agencyId = v,
            ),
            TextFormField(
              initialValue: _reservationId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservationid'.tr()),
              onChanged: (v) => _reservationId = v,
            ),
            TextFormField(
              initialValue: _taskId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.taskid'.tr()),
              onChanged: (v) => _taskId = v,
            ),
            TextFormField(
              initialValue: _taxRecordId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.taxrecordid'.tr()),
              onChanged: (v) => _taxRecordId = v,
            ),
            TextFormField(
              initialValue: _agency?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agency'.tr()),
              onChanged: (v) => _agency = v,
            ),
            TextFormField(
              initialValue: _agent?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.agent'.tr()),
              onChanged: (v) => _agent = v,
            ),
            TextFormField(
              initialValue: _property?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.property'.tr()),
              onChanged: (v) => _property = v,
            ),
            TextFormField(
              initialValue: _reservation?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reservation'.tr()),
              onChanged: (v) => _reservation = v,
            ),
            TextFormField(
              initialValue: _task?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.task'.tr()),
              onChanged: (v) => _task = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_entityId != null) 'entityId': _entityId,
                  if (_entityType != null) 'entityType': _entityType,
                  if (_timestamp != null)
                    'timestamp': _timestamp!.toIso8601String(),
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_userId != null) 'userId': _userId,
                  if (_agentId != null) 'agentId': _agentId,
                  if (_agencyId != null) 'agencyId': _agencyId,
                  if (_reservationId != null) 'reservationId': _reservationId,
                  if (_taskId != null) 'taskId': _taskId,
                  if (_taxRecordId != null) 'taxRecordId': _taxRecordId,
                  if (_agency != null) 'agency': _agency,
                  if (_agent != null) 'agent': _agent,
                  if (_property != null) 'property': _property,
                  if (_reservation != null) 'reservation': _reservation,
                  if (_task != null) 'task': _task,
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
                  widget.onSubmit(Analytics.fromJson(json));
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
