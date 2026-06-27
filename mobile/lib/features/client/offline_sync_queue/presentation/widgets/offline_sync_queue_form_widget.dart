import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class OfflineSyncQueueFormWidget extends ConsumerStatefulWidget {
  final OfflineSyncQueue? item;
  final Function(OfflineSyncQueue) onSubmit;
  const OfflineSyncQueueFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<OfflineSyncQueueFormWidget> createState() =>
      _OfflineSyncQueueFormWidgetState();
}

class _OfflineSyncQueueFormWidgetState
    extends ConsumerState<OfflineSyncQueueFormWidget> {
  String? _userId;
  String? _deviceId;
  String? _entityType;
  String? _entityId;
  String? _operation;
  int? _version;
  String? _syncStatus;
  DateTime? _syncedAt;
  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId;
    _deviceId = widget.item?.deviceId;
    _entityType = widget.item?.entityType;
    _entityId = widget.item?.entityId;
    _operation = widget.item?.operation;
    _version = widget.item?.version;
    _syncStatus = widget.item?.syncStatus;
    _syncedAt = widget.item?.syncedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.offlinesyncqueue'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.offlinesyncqueue'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _userId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.userid'.tr()),
              onChanged: (v) => _userId = v,
            ),
            TextFormField(
              initialValue: _deviceId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.deviceid'.tr()),
              onChanged: (v) => _deviceId = v,
            ),
            TextFormField(
              initialValue: _entityType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entitytype'.tr()),
              onChanged: (v) => _entityType = v,
            ),
            TextFormField(
              initialValue: _entityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entityid'.tr()),
              onChanged: (v) => _entityId = v,
            ),
            TextFormField(
              initialValue: _operation?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.operation'.tr()),
              onChanged: (v) => _operation = v,
            ),
            TextFormField(
              initialValue: _version?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.version'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _version = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _syncStatus?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.syncstatus'.tr()),
              onChanged: (v) => _syncStatus = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_synced_at'.tr()}: ${_syncedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _syncedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _syncedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_userId != null) 'userId': _userId,
                  if (_deviceId != null) 'deviceId': _deviceId,
                  if (_entityType != null) 'entityType': _entityType,
                  if (_entityId != null) 'entityId': _entityId,
                  if (_operation != null) 'operation': _operation,
                  if (_version != null) 'version': _version,
                  if (_syncStatus != null) 'syncStatus': _syncStatus,
                  if (_syncedAt != null)
                    'syncedAt': _syncedAt!.toIso8601String(),
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
                  widget.onSubmit(OfflineSyncQueue.fromJson(json));
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
