import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyDocument Form Widget  |  Fields: propertyId, title, fileName, mimeType, sizeBytes, storageKey, category

class PropertyDocumentFormWidget extends StatefulWidget {
  final PropertyDocument? item;
  final void Function(PropertyDocument)? onSubmit;
  const PropertyDocumentFormWidget({super.key, this.item, this.onSubmit});
  @override State<PropertyDocumentFormWidget> createState() => _PropertyDocumentFormWidgetState();
}

class _PropertyDocumentFormWidgetState extends State<PropertyDocumentFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _title;
  String? _fileName;
  String? _mimeType;
  int? _sizeBytes;
  String? _storageKey;
  String? _category;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _title = widget.item?.title?.toString();
    _fileName = widget.item?.fileName?.toString();
    _mimeType = widget.item?.mimeType?.toString();
    _sizeBytes = widget.item?.sizeBytes;
    _storageKey = widget.item?.storageKey?.toString();
    _category = widget.item?.category?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_title?.isNotEmpty == true) 'title': _title,
        if (_fileName?.isNotEmpty == true) 'fileName': _fileName,
        if (_mimeType?.isNotEmpty == true) 'mimeType': _mimeType,
        if (_sizeBytes != null) 'sizeBytes': _sizeBytes,
        if (_storageKey?.isNotEmpty == true) 'storageKey': _storageKey,
        if (_category?.isNotEmpty == true) 'category': _category,
    };
    final result = widget.item != null
        ? PropertyDocument.fromJson({...widget.item!.toJson(), ...data})
        : PropertyDocument.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _title = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'File Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _fileName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mime Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _mimeType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Size Bytes', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _sizeBytes = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Storage Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _storageKey = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Category', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _category = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property Document'),
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