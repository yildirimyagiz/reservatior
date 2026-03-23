import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIPrediction Form Widget  |  Fields: modelId, requestId, batchId, modelType, inputData, outputData, result, confidence, processingTimeMs, processingTime, status, success, errorMessage, userId, propertyId, metadata

class AIPredictionFormWidget extends StatefulWidget {
  final AIPrediction? item;
  final void Function(AIPrediction)? onSubmit;
  const AIPredictionFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIPredictionFormWidget> createState() => _AIPredictionFormWidgetState();
}

class _AIPredictionFormWidgetState extends State<AIPredictionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _modelId;
  String? _requestId;
  String? _batchId;
  String? _modelType;
  String? _inputData;
  String? _outputData;
  String? _result;
  double? _confidence;
  int? _processingTimeMs;
  int? _processingTime;
  String? _status;
  bool _success = false;
  String? _errorMessage;
  String? _userId;
  String? _propertyId;
  String? _metadata;

  @override
  void initState() {
    super.initState();
    _modelId = widget.item?.modelId?.toString();
    _requestId = widget.item?.requestId?.toString();
    _batchId = widget.item?.batchId?.toString();
    _modelType = widget.item?.modelType?.toString();
    _inputData = widget.item?.inputData?.toString();
    _outputData = widget.item?.outputData?.toString();
    _result = widget.item?.result?.toString();
    _confidence = widget.item?.confidence;
    _processingTimeMs = widget.item?.processingTimeMs;
    _processingTime = widget.item?.processingTime;
    _status = widget.item?.status?.toString();
    _success = widget.item?.success ?? false;
    _errorMessage = widget.item?.errorMessage?.toString();
    _userId = widget.item?.userId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _metadata = widget.item?.metadata?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_modelId?.isNotEmpty == true) 'modelId': _modelId,
        if (_requestId?.isNotEmpty == true) 'requestId': _requestId,
        if (_batchId?.isNotEmpty == true) 'batchId': _batchId,
        if (_modelType?.isNotEmpty == true) 'modelType': _modelType,
        if (_inputData?.isNotEmpty == true) 'inputData': _inputData,
        if (_outputData?.isNotEmpty == true) 'outputData': _outputData,
        if (_result?.isNotEmpty == true) 'result': _result,
        if (_confidence != null) 'confidence': _confidence,
        if (_processingTimeMs != null) 'processingTimeMs': _processingTimeMs,
        if (_processingTime != null) 'processingTime': _processingTime,
        if (_status?.isNotEmpty == true) 'status': _status,
        'success': _success,
        if (_errorMessage?.isNotEmpty == true) 'errorMessage': _errorMessage,
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
    };
    final result = widget.item != null
        ? AIPrediction.fromJson({...widget.item!.toJson(), ...data})
        : AIPrediction.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Model Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _modelId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Request Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _requestId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Batch Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _batchId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Model Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _modelType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Input Data', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _inputData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Output Data', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _outputData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Result', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _result = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _confidence = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Processing Time Ms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _processingTimeMs = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Processing Time', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _processingTime = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Success'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _success,
                  onChanged: (v) { ss(() {}); setState(() => _success = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Error Message', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _errorMessage = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Metadata', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _metadata = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Prediction'),
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