import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ApiToken Form Widget  |  Fields: userId, name, tokenHash, lastUsedAt

class ApiTokenFormWidget extends StatefulWidget {
  final ApiToken? item;
  final void Function(ApiToken)? onSubmit;
  const ApiTokenFormWidget({super.key, this.item, this.onSubmit});
  @override State<ApiTokenFormWidget> createState() => _ApiTokenFormWidgetState();
}

class _ApiTokenFormWidgetState extends State<ApiTokenFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _name;
  String? _tokenHash;
  DateTime? _lastUsedAt;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _name = widget.item?.name?.toString();
    _tokenHash = widget.item?.tokenHash?.toString();
    _lastUsedAt = widget.item?.lastUsedAt;
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
        if (_tokenHash?.isNotEmpty == true) 'tokenHash': _tokenHash,
        if (_lastUsedAt != null) 'lastUsedAt': _lastUsedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? ApiToken.fromJson({...widget.item!.toJson(), ...data})
        : ApiToken.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Token Hash', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _tokenHash?.toString() ?? '',
                onSaved: (v) => _tokenHash = v?.isEmpty == true ? null : v,
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
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Api Token'),
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