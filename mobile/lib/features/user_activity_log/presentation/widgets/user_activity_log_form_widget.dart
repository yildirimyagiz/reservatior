import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── UserActivityLog Form Widget  |  Fields: userId, action, entityType, entityId, metadata, ipAddress, userAgent

class UserActivityLogFormWidget extends StatefulWidget {
  final UserActivityLog? item;
  final void Function(UserActivityLog)? onSubmit;
  const UserActivityLogFormWidget({super.key, this.item, this.onSubmit});
  @override State<UserActivityLogFormWidget> createState() => _UserActivityLogFormWidgetState();
}

class _UserActivityLogFormWidgetState extends State<UserActivityLogFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _action;
  String? _entityType;
  String? _entityId;
  String? _metadata;
  String? _ipAddress;
  String? _userAgent;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _action = widget.item?.action?.toString();
    _entityType = widget.item?.entityType?.toString();
    _entityId = widget.item?.entityId?.toString();
    _metadata = widget.item?.metadata?.toString();
    _ipAddress = widget.item?.ipAddress?.toString();
    _userAgent = widget.item?.userAgent?.toString();
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
        if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
        if (_ipAddress?.isNotEmpty == true) 'ipAddress': _ipAddress,
        if (_userAgent?.isNotEmpty == true) 'userAgent': _userAgent,
    };
    final result = widget.item != null
        ? UserActivityLog.fromJson({...widget.item!.toJson(), ...data})
        : UserActivityLog.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Action', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _action = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ip Address', prefixIcon: const Icon(Icons.location_on), border: const OutlineInputBorder()),
                onSaved: (v) => _ipAddress = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Agent', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _userAgent = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create User Activity Log'),
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