import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Amenity Form Widget  |  Fields: name, category, icon

class AmenityFormWidget extends StatefulWidget {
  final Amenity? item;
  final void Function(Amenity)? onSubmit;
  const AmenityFormWidget({super.key, this.item, this.onSubmit});
  @override State<AmenityFormWidget> createState() => _AmenityFormWidgetState();
}

class _AmenityFormWidgetState extends State<AmenityFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _category;
  String? _icon;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _category = widget.item?.category?.toString();
    _icon = widget.item?.icon?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_category?.isNotEmpty == true) 'category': _category,
        if (_icon?.isNotEmpty == true) 'icon': _icon,
    };
    final result = widget.item != null
        ? Amenity.fromJson({...widget.item!.toJson(), ...data})
        : Amenity.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _category = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Icon', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _icon = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Amenity'),
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