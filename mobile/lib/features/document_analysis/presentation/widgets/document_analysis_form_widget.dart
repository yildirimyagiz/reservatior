import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── DocumentAnalysis Form Widget  |  Fields: documentId, jobId, extractedText, metadata, classification, confidence, processingTime

class DocumentAnalysisFormWidget extends StatefulWidget {
  final DocumentAnalysis? item;
  final void Function(DocumentAnalysis)? onSubmit;
  const DocumentAnalysisFormWidget({super.key, this.item, this.onSubmit});
  @override State<DocumentAnalysisFormWidget> createState() => _DocumentAnalysisFormWidgetState();
}

class _DocumentAnalysisFormWidgetState extends State<DocumentAnalysisFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _documentId;
  String? _jobId;
  String? _extractedText;
  String? _metadata;
  String? _classification;
  double? _confidence;
  int? _processingTime;

  @override
  void initState() {
    super.initState();
    _documentId = widget.item?.documentId?.toString();
    _jobId = widget.item?.jobId?.toString();
    _extractedText = widget.item?.extractedText?.toString();
    _metadata = widget.item?.metadata?.toString();
    _classification = widget.item?.classification?.toString();
    _confidence = widget.item?.confidence;
    _processingTime = widget.item?.processingTime;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_documentId?.isNotEmpty == true) 'documentId': _documentId,
        if (_jobId?.isNotEmpty == true) 'jobId': _jobId,
        if (_extractedText?.isNotEmpty == true) 'extractedText': _extractedText,
        if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
        if (_classification?.isNotEmpty == true) 'classification': _classification,
        if (_confidence != null) 'confidence': _confidence,
        if (_processingTime != null) 'processingTime': _processingTime,
    };
    final result = widget.item != null
        ? DocumentAnalysis.fromJson({...widget.item!.toJson(), ...data})
        : DocumentAnalysis.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Document Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _documentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Job Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _jobId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Extracted Text', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _extractedText = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Metadata', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Classification', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _classification = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _confidence = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Processing Time', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _processingTime = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Document Analysis'),
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