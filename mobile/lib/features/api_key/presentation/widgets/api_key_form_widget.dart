import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ApiKey Form Widget  |  Fields: userId, name, keyHash, lastUsedAt, expiresAt

class ApiKeyFormWidget extends StatefulWidget {
  final ApiKey? item;
  final void Function(ApiKey)? onSubmit;
  const ApiKeyFormWidget({super.key, this.item, this.onSubmit});
  @override State<ApiKeyFormWidget> createState() => _ApiKeyFormWidgetState();
}

class _ApiKeyFormWidgetState extends State<ApiKeyFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _name;
  String? _keyHash;
  DateTime? _lastUsedAt;
  DateTime? _expiresAt;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _name = widget.item?.name?.toString();
    _keyHash = widget.item?.keyHash?.toString();
    _lastUsedAt = widget.item?.lastUsedAt;
    _expiresAt = widget.item?.expiresAt;
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
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_keyHash?.isNotEmpty == true) 'keyHash': _keyHash,
        if (_lastUsedAt != null) 'lastUsedAt': _lastUsedAt!.toIso8601String(),
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? ApiKey.fromJson({...widget.item!.toJson(), ...data})
        : ApiKey.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _name?.toString() ?? '',
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Key Hash', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _keyHash?.toString() ?? '',
                onSaved: (v) => _keyHash = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastUsedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastUsedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Used At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastUsedAt != null ? _fmt(_lastUsedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _expiresAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _expiresAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Expires At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_expiresAt != null ? _fmt(_expiresAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Api Key'),
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