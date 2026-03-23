import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Channel Form Widget  |  Fields: cuid, name, type, category, description

class ChannelFormWidget extends StatefulWidget {
  final Channel? item;
  final void Function(Channel)? onSubmit;
  const ChannelFormWidget({super.key, this.item, this.onSubmit});
  @override State<ChannelFormWidget> createState() => _ChannelFormWidgetState();
}

class _ChannelFormWidgetState extends State<ChannelFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _cuid;
  String? _name;
  String? _type;
  String? _category;
  String? _description;

  @override
  void initState() {
    super.initState();
    _cuid = widget.item?.cuid?.toString();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _category = widget.item?.category?.toString();
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
        if (_cuid?.isNotEmpty == true) 'cuid': _cuid,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_category?.isNotEmpty == true) 'category': _category,
        if (_description?.isNotEmpty == true) 'description': _description,
    };
    final result = widget.item != null
        ? Channel.fromJson({...widget.item!.toJson(), ...data})
        : Channel.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Cuid', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _cuid?.toString() ?? '',
                onSaved: (v) => _cuid = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _name?.toString() ?? '',
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _type?.toString() ?? '',
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _category?.toString() ?? '',
                onSaved: (v) => _category = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _description?.toString() ?? '',
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Channel'),
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