import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── DocumentTemplate Form Widget  |  Fields: name, type, category, templateContent, variables, isActive

class DocumentTemplateFormWidget extends StatefulWidget {
  final DocumentTemplate? item;
  final void Function(DocumentTemplate)? onSubmit;
  const DocumentTemplateFormWidget({super.key, this.item, this.onSubmit});
  @override State<DocumentTemplateFormWidget> createState() => _DocumentTemplateFormWidgetState();
}

class _DocumentTemplateFormWidgetState extends State<DocumentTemplateFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _type;
  String? _category;
  String? _templateContent;
  String? _variables;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _category = widget.item?.category?.toString();
    _templateContent = widget.item?.templateContent?.toString();
    _variables = widget.item?.variables?.toString();
    _isActive = widget.item?.isActive ?? false;
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
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_category?.isNotEmpty == true) 'category': _category,
        if (_templateContent?.isNotEmpty == true) 'templateContent': _templateContent,
        if (_variables?.isNotEmpty == true) 'variables': _variables,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? DocumentTemplate.fromJson({...widget.item!.toJson(), ...data})
        : DocumentTemplate.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _category = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Template Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _templateContent = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Variables', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _variables = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Document Template'),
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