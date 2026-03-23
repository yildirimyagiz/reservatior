import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Role Form Widget  |  Fields: key, name, locationId

class RoleFormWidget extends StatefulWidget {
  final Role? item;
  final void Function(Role)? onSubmit;
  const RoleFormWidget({super.key, this.item, this.onSubmit});
  @override State<RoleFormWidget> createState() => _RoleFormWidgetState();
}

class _RoleFormWidgetState extends State<RoleFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _key;
  String? _name;
  String? _locationId;

  @override
  void initState() {
    super.initState();
    _key = widget.item?.key?.toString();
    _name = widget.item?.name?.toString();
    _locationId = widget.item?.locationId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_key?.isNotEmpty == true) 'key': _key,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_locationId?.isNotEmpty == true) 'locationId': _locationId,
    };
    final result = widget.item != null
        ? Role.fromJson({...widget.item!.toJson(), ...data})
        : Role.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _key = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Location Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _locationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Role'),
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