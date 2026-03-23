import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ExportFile Form Widget  |  Fields: exportJobId, fileName, storageKey, mimeType, sizeBytes

class ExportFileFormWidget extends StatefulWidget {
  final ExportFile? item;
  final void Function(ExportFile)? onSubmit;
  const ExportFileFormWidget({super.key, this.item, this.onSubmit});
  @override State<ExportFileFormWidget> createState() => _ExportFileFormWidgetState();
}

class _ExportFileFormWidgetState extends State<ExportFileFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _exportJobId;
  String? _fileName;
  String? _storageKey;
  String? _mimeType;
  int? _sizeBytes;

  @override
  void initState() {
    super.initState();
    _exportJobId = widget.item?.exportJobId?.toString();
    _fileName = widget.item?.fileName?.toString();
    _storageKey = widget.item?.storageKey?.toString();
    _mimeType = widget.item?.mimeType?.toString();
    _sizeBytes = widget.item?.sizeBytes;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_exportJobId?.isNotEmpty == true) 'exportJobId': _exportJobId,
        if (_fileName?.isNotEmpty == true) 'fileName': _fileName,
        if (_storageKey?.isNotEmpty == true) 'storageKey': _storageKey,
        if (_mimeType?.isNotEmpty == true) 'mimeType': _mimeType,
        if (_sizeBytes != null) 'sizeBytes': _sizeBytes,
    };
    final result = widget.item != null
        ? ExportFile.fromJson({...widget.item!.toJson(), ...data})
        : ExportFile.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Export Job Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _exportJobId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'File Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _fileName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Storage Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _storageKey = v?.isEmpty == true ? null : v,
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
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Export File'),
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