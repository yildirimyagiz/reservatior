import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIModelDeployment Form Widget  |  Fields: modelId, deploymentId, environment, status, deployedAt, lastHealthCheck, config, metrics

class AIModelDeploymentFormWidget extends StatefulWidget {
  final AIModelDeployment? item;
  final void Function(AIModelDeployment)? onSubmit;
  const AIModelDeploymentFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIModelDeploymentFormWidget> createState() => _AIModelDeploymentFormWidgetState();
}

class _AIModelDeploymentFormWidgetState extends State<AIModelDeploymentFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _modelId;
  String? _deploymentId;
  String? _environment;
  String? _status;
  DateTime? _deployedAt;
  DateTime? _lastHealthCheck;
  String? _config;
  String? _metrics;

  @override
  void initState() {
    super.initState();
    _modelId = widget.item?.modelId?.toString();
    _deploymentId = widget.item?.deploymentId?.toString();
    _environment = widget.item?.environment?.toString();
    _status = widget.item?.status?.toString();
    _deployedAt = widget.item?.deployedAt;
    _lastHealthCheck = widget.item?.lastHealthCheck;
    _config = widget.item?.config?.toString();
    _metrics = widget.item?.metrics?.toString();
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
        if (_deploymentId?.isNotEmpty == true) 'deploymentId': _deploymentId,
        if (_environment?.isNotEmpty == true) 'environment': _environment,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_deployedAt != null) 'deployedAt': _deployedAt!.toIso8601String(),
        if (_lastHealthCheck != null) 'lastHealthCheck': _lastHealthCheck!.toIso8601String(),
        if (_config?.isNotEmpty == true) 'config': _config,
        if (_metrics?.isNotEmpty == true) 'metrics': _metrics,
    };
    final result = widget.item != null
        ? AIModelDeployment.fromJson({...widget.item!.toJson(), ...data})
        : AIModelDeployment.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Deployment Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _deploymentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Environment', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _environment = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _deployedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _deployedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Deployed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_deployedAt != null ? _fmt(_deployedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastHealthCheck ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastHealthCheck = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Health Check',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastHealthCheck != null ? _fmt(_lastHealthCheck) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Config', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _config = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Metrics', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _metrics = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Model Deployment'),
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