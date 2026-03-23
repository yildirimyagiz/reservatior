import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIModel Form Widget  |  Fields: modelName, modelVersion, modelType, provider, endpointUrl, apiKey, status, accuracy, lastTrainedAt, config, metadata

class AIModelFormWidget extends StatefulWidget {
  final AIModel? item;
  final void Function(AIModel)? onSubmit;
  const AIModelFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIModelFormWidget> createState() => _AIModelFormWidgetState();
}

class _AIModelFormWidgetState extends State<AIModelFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _modelName;
  String? _modelVersion;
  String? _modelType;
  String? _provider;
  String? _endpointUrl;
  String? _apiKey;
  String? _status;
  double? _accuracy;
  DateTime? _lastTrainedAt;
  String? _config;
  String? _metadata;

  @override
  void initState() {
    super.initState();
    _modelName = widget.item?.modelName?.toString();
    _modelVersion = widget.item?.modelVersion?.toString();
    _modelType = widget.item?.modelType?.toString();
    _provider = widget.item?.provider?.toString();
    _endpointUrl = widget.item?.endpointUrl?.toString();
    _apiKey = widget.item?.apiKey?.toString();
    _status = widget.item?.status?.toString();
    _accuracy = widget.item?.accuracy;
    _lastTrainedAt = widget.item?.lastTrainedAt;
    _config = widget.item?.config?.toString();
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
        if (_modelName?.isNotEmpty == true) 'modelName': _modelName,
        if (_modelVersion?.isNotEmpty == true) 'modelVersion': _modelVersion,
        if (_modelType?.isNotEmpty == true) 'modelType': _modelType,
        if (_provider?.isNotEmpty == true) 'provider': _provider,
        if (_endpointUrl?.isNotEmpty == true) 'endpointUrl': _endpointUrl,
        if (_apiKey?.isNotEmpty == true) 'apiKey': _apiKey,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_accuracy != null) 'accuracy': _accuracy,
        if (_lastTrainedAt != null) 'lastTrainedAt': _lastTrainedAt!.toIso8601String(),
        if (_config?.isNotEmpty == true) 'config': _config,
        if (_metadata?.isNotEmpty == true) 'metadata': _metadata,
    };
    final result = widget.item != null
        ? AIModel.fromJson({...widget.item!.toJson(), ...data})
        : AIModel.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Model Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                onSaved: (v) => _modelName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Model Version', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _modelVersion = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Model Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _modelType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Provider', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _provider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Endpoint Url', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _endpointUrl = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Api Key', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _apiKey = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Accuracy', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _accuracy = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastTrainedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastTrainedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Trained At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastTrainedAt != null ? _fmt(_lastTrainedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Config', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _config = v?.isEmpty == true ? null : v,
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Model'),
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