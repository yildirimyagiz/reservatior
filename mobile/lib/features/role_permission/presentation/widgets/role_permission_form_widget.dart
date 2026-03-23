import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── RolePermission Form Widget  |  Fields: roleId, permissionId

class RolePermissionFormWidget extends StatefulWidget {
  final RolePermission? item;
  final void Function(RolePermission)? onSubmit;
  const RolePermissionFormWidget({super.key, this.item, this.onSubmit});
  @override State<RolePermissionFormWidget> createState() => _RolePermissionFormWidgetState();
}

class _RolePermissionFormWidgetState extends State<RolePermissionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _roleId;
  String? _permissionId;

  @override
  void initState() {
    super.initState();
    _roleId = widget.item?.roleId?.toString();
    _permissionId = widget.item?.permissionId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_roleId?.isNotEmpty == true) 'roleId': _roleId,
        if (_permissionId?.isNotEmpty == true) 'permissionId': _permissionId,
    };
    final result = widget.item != null
        ? RolePermission.fromJson({...widget.item!.toJson(), ...data})
        : RolePermission.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Role Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _roleId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Permission Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _permissionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Role Permission'),
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