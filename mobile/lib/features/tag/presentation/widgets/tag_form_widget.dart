import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Tag Form Widget  |  Fields: name, color

class TagFormWidget extends StatefulWidget {
  final Tag? item;
  final void Function(Tag)? onSubmit;
  const TagFormWidget({super.key, this.item, this.onSubmit});
  @override State<TagFormWidget> createState() => _TagFormWidgetState();
}

class _TagFormWidgetState extends State<TagFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _color;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _color = widget.item?.color?.toString();
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
        if (_color?.isNotEmpty == true) 'color': _color,
    };
    final result = widget.item != null
        ? Tag.fromJson({...widget.item!.toJson(), ...data})
        : Tag.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Color', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _color = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Tag'),
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