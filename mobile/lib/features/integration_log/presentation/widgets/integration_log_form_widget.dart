import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── IntegrationLog Form Widget  |  Fields: integrationType, operation, requestData, responseData, statusCode, success, errorMessage, processingTimeMs, externalId, correlationId

class IntegrationLogFormWidget extends StatefulWidget {
  final IntegrationLog? item;
  final void Function(IntegrationLog)? onSubmit;
  const IntegrationLogFormWidget({super.key, this.item, this.onSubmit});
  @override State<IntegrationLogFormWidget> createState() => _IntegrationLogFormWidgetState();
}

class _IntegrationLogFormWidgetState extends State<IntegrationLogFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _integrationType;
  String? _operation;
  String? _requestData;
  String? _responseData;
  int? _statusCode;
  bool _success = false;
  String? _errorMessage;
  int? _processingTimeMs;
  String? _externalId;
  String? _correlationId;

  @override
  void initState() {
    super.initState();
    _integrationType = widget.item?.integrationType?.toString();
    _operation = widget.item?.operation?.toString();
    _requestData = widget.item?.requestData?.toString();
    _responseData = widget.item?.responseData?.toString();
    _statusCode = widget.item?.statusCode;
    _success = widget.item?.success ?? false;
    _errorMessage = widget.item?.errorMessage?.toString();
    _processingTimeMs = widget.item?.processingTimeMs;
    _externalId = widget.item?.externalId?.toString();
    _correlationId = widget.item?.correlationId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_integrationType?.isNotEmpty == true) 'integrationType': _integrationType,
        if (_operation?.isNotEmpty == true) 'operation': _operation,
        if (_requestData?.isNotEmpty == true) 'requestData': _requestData,
        if (_responseData?.isNotEmpty == true) 'responseData': _responseData,
        if (_statusCode != null) 'statusCode': _statusCode,
        'success': _success,
        if (_errorMessage?.isNotEmpty == true) 'errorMessage': _errorMessage,
        if (_processingTimeMs != null) 'processingTimeMs': _processingTimeMs,
        if (_externalId?.isNotEmpty == true) 'externalId': _externalId,
        if (_correlationId?.isNotEmpty == true) 'correlationId': _correlationId,
    };
    final result = widget.item != null
        ? IntegrationLog.fromJson({...widget.item!.toJson(), ...data})
        : IntegrationLog.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Integration Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _integrationType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Operation', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _operation = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Request Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _requestData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Response Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _responseData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status Code', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                onSaved: (v) => _statusCode = int.tryParse(v ?? ''),
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
                decoration: InputDecoration(labelText: 'Error Message', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _errorMessage = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Processing Time Ms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _processingTimeMs = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'External Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _externalId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Correlation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _correlationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Integration Log'),
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