import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── CommunicationTemplate Form Widget  |  Fields: name, type, templateType, subject, htmlContent, textContent, title, message, category, variables, isActive

class CommunicationTemplateFormWidget extends StatefulWidget {
  final CommunicationTemplate? item;
  final void Function(CommunicationTemplate)? onSubmit;
  const CommunicationTemplateFormWidget({super.key, this.item, this.onSubmit});
  @override State<CommunicationTemplateFormWidget> createState() => _CommunicationTemplateFormWidgetState();
}

class _CommunicationTemplateFormWidgetState extends State<CommunicationTemplateFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _name;
  String? _type;
  String? _templateType;
  String? _subject;
  String? _htmlContent;
  String? _textContent;
  String? _title;
  String? _message;
  String? _category;
  String? _variables;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _name = widget.item?.name?.toString();
    _type = widget.item?.type?.toString();
    _templateType = widget.item?.templateType?.toString();
    _subject = widget.item?.subject?.toString();
    _htmlContent = widget.item?.htmlContent?.toString();
    _textContent = widget.item?.textContent?.toString();
    _title = widget.item?.title?.toString();
    _message = widget.item?.message?.toString();
    _category = widget.item?.category?.toString();
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
        if (_templateType?.isNotEmpty == true) 'templateType': _templateType,
        if (_subject?.isNotEmpty == true) 'subject': _subject,
        if (_htmlContent?.isNotEmpty == true) 'htmlContent': _htmlContent,
        if (_textContent?.isNotEmpty == true) 'textContent': _textContent,
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_message?.isNotEmpty == true) 'message': _message,
        if (_category?.isNotEmpty == true) 'category': _category,
        if (_variables?.isNotEmpty == true) 'variables': _variables,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? CommunicationTemplate.fromJson({...widget.item!.toJson(), ...data})
        : CommunicationTemplate.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Template Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _templateType?.toString() ?? '',
                onSaved: (v) => _templateType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Subject', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _subject?.toString() ?? '',
                onSaved: (v) => _subject = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Html Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _htmlContent?.toString() ?? '',
                onSaved: (v) => _htmlContent = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Text Content', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _textContent?.toString() ?? '',
                onSaved: (v) => _textContent = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _title?.toString() ?? '',
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _message?.toString() ?? '',
                onSaved: (v) => _message = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _category?.toString() ?? '',
                onSaved: (v) => _category = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Variables', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _variables?.toString() ?? '',
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create Communication Template'),
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