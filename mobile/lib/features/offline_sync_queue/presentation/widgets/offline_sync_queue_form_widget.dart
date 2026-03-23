import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── OfflineSyncQueue Form Widget  |  Fields: userId, deviceId, entityType, entityId, operation, data, version, syncStatus, syncedAt

class OfflineSyncQueueFormWidget extends StatefulWidget {
  final OfflineSyncQueue? item;
  final void Function(OfflineSyncQueue)? onSubmit;
  const OfflineSyncQueueFormWidget({super.key, this.item, this.onSubmit});
  @override State<OfflineSyncQueueFormWidget> createState() => _OfflineSyncQueueFormWidgetState();
}

class _OfflineSyncQueueFormWidgetState extends State<OfflineSyncQueueFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _deviceId;
  String? _entityType;
  String? _entityId;
  String? _operation;
  String? _data;
  int? _version;
  String? _syncStatus;
  DateTime? _syncedAt;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _deviceId = widget.item?.deviceId?.toString();
    _entityType = widget.item?.entityType?.toString();
    _entityId = widget.item?.entityId?.toString();
    _operation = widget.item?.operation?.toString();
    _data = widget.item?.data?.toString();
    _version = widget.item?.version;
    _syncStatus = widget.item?.syncStatus?.toString();
    _syncedAt = widget.item?.syncedAt;
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
        if (_deviceId?.isNotEmpty == true) 'deviceId': _deviceId,
        if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
        if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
        if (_operation?.isNotEmpty == true) 'operation': _operation,
        if (_data?.isNotEmpty == true) 'data': _data,
        if (_version != null) 'version': _version,
        if (_syncStatus?.isNotEmpty == true) 'syncStatus': _syncStatus,
        if (_syncedAt != null) 'syncedAt': _syncedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? OfflineSyncQueue.fromJson({...widget.item!.toJson(), ...data})
        : OfflineSyncQueue.fromJson(data);
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
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Device Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _deviceId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Operation', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _operation = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _data = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Version', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _version = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sync Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _syncStatus = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _syncedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _syncedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Synced At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_syncedAt != null ? _fmt(_syncedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Offline Sync Queue'),
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