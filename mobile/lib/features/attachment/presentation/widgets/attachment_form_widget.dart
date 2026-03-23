import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Attachment Form Widget  |  Fields: propertyId, entityType, entityId, fileName, mimeType, sizeBytes, storageKey, url, checksum, transactionId, taskId, messageId, propertyComplianceId, reviewId

class AttachmentFormWidget extends StatefulWidget {
  final Attachment? item;
  final void Function(Attachment)? onSubmit;
  const AttachmentFormWidget({super.key, this.item, this.onSubmit});
  @override State<AttachmentFormWidget> createState() => _AttachmentFormWidgetState();
}

class _AttachmentFormWidgetState extends State<AttachmentFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _entityType;
  String? _entityId;
  String? _fileName;
  String? _mimeType;
  int? _sizeBytes;
  String? _storageKey;
  String? _url;
  String? _checksum;
  String? _transactionId;
  String? _taskId;
  String? _messageId;
  String? _propertyComplianceId;
  String? _reviewId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _entityType = widget.item?.entityType?.toString();
    _entityId = widget.item?.entityId?.toString();
    _fileName = widget.item?.fileName?.toString();
    _mimeType = widget.item?.mimeType?.toString();
    _sizeBytes = widget.item?.sizeBytes;
    _storageKey = widget.item?.storageKey?.toString();
    _url = widget.item?.url?.toString();
    _checksum = widget.item?.checksum?.toString();
    _transactionId = widget.item?.transactionId?.toString();
    _taskId = widget.item?.taskId?.toString();
    _messageId = widget.item?.messageId?.toString();
    _propertyComplianceId = widget.item?.propertyComplianceId?.toString();
    _reviewId = widget.item?.reviewId?.toString();
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
        if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
        if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
        if (_fileName?.isNotEmpty == true) 'fileName': _fileName,
        if (_mimeType?.isNotEmpty == true) 'mimeType': _mimeType,
        if (_sizeBytes != null) 'sizeBytes': _sizeBytes,
        if (_storageKey?.isNotEmpty == true) 'storageKey': _storageKey,
        if (_url?.isNotEmpty == true) 'url': _url,
        if (_checksum?.isNotEmpty == true) 'checksum': _checksum,
        if (_transactionId?.isNotEmpty == true) 'transactionId': _transactionId,
        if (_taskId?.isNotEmpty == true) 'taskId': _taskId,
        if (_messageId?.isNotEmpty == true) 'messageId': _messageId,
        if (_propertyComplianceId?.isNotEmpty == true) 'propertyComplianceId': _propertyComplianceId,
        if (_reviewId?.isNotEmpty == true) 'reviewId': _reviewId,
    };
    final result = widget.item != null
        ? Attachment.fromJson({...widget.item!.toJson(), ...data})
        : Attachment.fromJson(data);
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
                initialValue: _propertyId?.toString() ?? '',
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _entityType?.toString() ?? '',
                onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _entityId?.toString() ?? '',
                onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'File Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _fileName?.toString() ?? '',
                onSaved: (v) => _fileName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Mime Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _mimeType?.toString() ?? '',
                onSaved: (v) => _mimeType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Size Bytes', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _sizeBytes?.toString() ?? '',
                onSaved: (v) => _sizeBytes = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Storage Key', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _storageKey?.toString() ?? '',
                onSaved: (v) => _storageKey = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _url?.toString() ?? '',
                onSaved: (v) => _url = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Checksum', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _checksum?.toString() ?? '',
                onSaved: (v) => _checksum = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Transaction Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _transactionId?.toString() ?? '',
                onSaved: (v) => _transactionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Task Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _taskId?.toString() ?? '',
                onSaved: (v) => _taskId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _messageId?.toString() ?? '',
                onSaved: (v) => _messageId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Compliance Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _propertyComplianceId?.toString() ?? '',
                onSaved: (v) => _propertyComplianceId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Review Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _reviewId?.toString() ?? '',
                onSaved: (v) => _reviewId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Attachment'),
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