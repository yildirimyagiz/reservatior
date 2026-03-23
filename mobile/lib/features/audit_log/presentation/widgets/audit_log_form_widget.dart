import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AuditLog Form Widget  |  Fields: userId, action, entityType, entityId, oldValues, newValues, changes, ipAddress, userAgent, sessionId

class AuditLogFormWidget extends StatefulWidget {
  final AuditLog? item;
  final void Function(AuditLog)? onSubmit;
  const AuditLogFormWidget({super.key, this.item, this.onSubmit});
  @override State<AuditLogFormWidget> createState() => _AuditLogFormWidgetState();
}

class _AuditLogFormWidgetState extends State<AuditLogFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _action;
  String? _entityType;
  String? _entityId;
  String? _oldValues;
  String? _newValues;
  String? _changes;
  String? _ipAddress;
  String? _userAgent;
  String? _sessionId;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _action = widget.item?.action?.toString();
    _entityType = widget.item?.entityType?.toString();
    _entityId = widget.item?.entityId?.toString();
    _oldValues = widget.item?.oldValues?.toString();
    _newValues = widget.item?.newValues?.toString();
    _changes = widget.item?.changes?.toString();
    _ipAddress = widget.item?.ipAddress?.toString();
    _userAgent = widget.item?.userAgent?.toString();
    _sessionId = widget.item?.sessionId?.toString();
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
        if (_action?.isNotEmpty == true) 'action': _action,
        if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
        if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
        if (_oldValues?.isNotEmpty == true) 'oldValues': _oldValues,
        if (_newValues?.isNotEmpty == true) 'newValues': _newValues,
        if (_changes?.isNotEmpty == true) 'changes': _changes,
        if (_ipAddress?.isNotEmpty == true) 'ipAddress': _ipAddress,
        if (_userAgent?.isNotEmpty == true) 'userAgent': _userAgent,
        if (_sessionId?.isNotEmpty == true) 'sessionId': _sessionId,
    };
    final result = widget.item != null
        ? AuditLog.fromJson({...widget.item!.toJson(), ...data})
        : AuditLog.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Action', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _action?.toString() ?? '',
                onSaved: (v) => _action = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _entityType?.toString() ?? '',
                onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _entityId?.toString() ?? '',
                onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Old Values', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _oldValues?.toString() ?? '',
                onSaved: (v) => _oldValues = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'New Values', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _newValues?.toString() ?? '',
                onSaved: (v) => _newValues = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Changes', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _changes?.toString() ?? '',
                onSaved: (v) => _changes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ip Address', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                initialValue: _ipAddress?.toString() ?? '',
                onSaved: (v) => _ipAddress = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Agent', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _userAgent?.toString() ?? '',
                onSaved: (v) => _userAgent = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Session Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _sessionId?.toString() ?? '',
                onSaved: (v) => _sessionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Audit Log'),
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