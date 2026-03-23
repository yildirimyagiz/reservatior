import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Permission Form Widget ──
// Fields: key, name, description

class PermissionFormWidget extends StatefulWidget {
  final Permission? item;
  final void Function(Permission)? onSubmit;
  const PermissionFormWidget({super.key, this.item, this.onSubmit});

  @override
  State<PermissionFormWidget> createState() => _PermissionFormWidgetState();
}

class _PermissionFormWidgetState extends State<PermissionFormWidget> {
  final _key = GlobalKey<FormState>();

  String? _key;
  String? _name;
  String? _description;

  @override
  void initState() {
    super.initState();
    _key = widget.item?.key?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_key != null) 'key': _key,
        if (_name != null) 'name': _name,
        if (_description != null) 'description': _description,
    };
    final result = widget.item != null
        ? Permission.fromJson({...widget.item!.toJson(), ...data})
        : Permission.fromJson(data);
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
                maxLines: 1,
                onSaved: (v) => _key = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                maxLines: 1,
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                maxLines: 3,
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Permission'),
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
  return '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
}
