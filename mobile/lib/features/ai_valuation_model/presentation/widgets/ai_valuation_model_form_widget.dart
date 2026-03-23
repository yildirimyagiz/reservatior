import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIValuationModel Form Widget  |  Fields: modelName, modelVersion, accuracy, lastTrainedAt, features, hyperparameters, trainingMetrics, isActive

class AIValuationModelFormWidget extends StatefulWidget {
  final AIValuationModel? item;
  final void Function(AIValuationModel)? onSubmit;
  const AIValuationModelFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIValuationModelFormWidget> createState() => _AIValuationModelFormWidgetState();
}

class _AIValuationModelFormWidgetState extends State<AIValuationModelFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _modelName;
  String? _modelVersion;
  double? _accuracy;
  DateTime? _lastTrainedAt;
  String? _features;
  String? _hyperparameters;
  String? _trainingMetrics;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _modelName = widget.item?.modelName?.toString();
    _modelVersion = widget.item?.modelVersion?.toString();
    _accuracy = widget.item?.accuracy;
    _lastTrainedAt = widget.item?.lastTrainedAt;
    _features = widget.item?.features?.toString();
    _hyperparameters = widget.item?.hyperparameters?.toString();
    _trainingMetrics = widget.item?.trainingMetrics?.toString();
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
        if (_modelName?.isNotEmpty == true) 'modelName': _modelName,
        if (_modelVersion?.isNotEmpty == true) 'modelVersion': _modelVersion,
        if (_accuracy != null) 'accuracy': _accuracy,
        if (_lastTrainedAt != null) 'lastTrainedAt': _lastTrainedAt!.toIso8601String(),
        if (_features?.isNotEmpty == true) 'features': _features,
        if (_hyperparameters?.isNotEmpty == true) 'hyperparameters': _hyperparameters,
        if (_trainingMetrics?.isNotEmpty == true) 'trainingMetrics': _trainingMetrics,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? AIValuationModel.fromJson({...widget.item!.toJson(), ...data})
        : AIValuationModel.fromJson(data);
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
                decoration: const InputDecoration(labelText: 'Model Name', prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                onSaved: (v) => _modelName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Model Version', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _modelVersion = v?.isEmpty == true ? null : v,
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
                decoration: const InputDecoration(labelText: 'Features', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _features = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Hyperparameters', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _hyperparameters = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Training Metrics', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _trainingMetrics = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: const Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Valuation Model'),
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