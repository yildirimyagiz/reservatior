import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PredictiveModel Form Widget  |  Fields: modelType, trainingData, parameters, accuracy, lastTrained

class PredictiveModelFormWidget extends StatefulWidget {
  final PredictiveModel? item;
  final void Function(PredictiveModel)? onSubmit;
  const PredictiveModelFormWidget({super.key, this.item, this.onSubmit});
  @override State<PredictiveModelFormWidget> createState() => _PredictiveModelFormWidgetState();
}

class _PredictiveModelFormWidgetState extends State<PredictiveModelFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _modelType;
  String? _trainingData;
  String? _parameters;
  double? _accuracy;
  DateTime? _lastTrained;

  @override
  void initState() {
    super.initState();
    _modelType = widget.item?.modelType?.toString();
    _trainingData = widget.item?.trainingData?.toString();
    _parameters = widget.item?.parameters?.toString();
    _accuracy = widget.item?.accuracy;
    _lastTrained = widget.item?.lastTrained;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_modelType?.isNotEmpty == true) 'modelType': _modelType,
        if (_trainingData?.isNotEmpty == true) 'trainingData': _trainingData,
        if (_parameters?.isNotEmpty == true) 'parameters': _parameters,
        if (_accuracy != null) 'accuracy': _accuracy,
        if (_lastTrained != null) 'lastTrained': _lastTrained!.toIso8601String(),
    };
    final result = widget.item != null
        ? PredictiveModel.fromJson({...widget.item!.toJson(), ...data})
        : PredictiveModel.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Model Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _modelType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Training Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _trainingData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Parameters', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _parameters = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _lastTrained ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastTrained = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Trained',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastTrained != null ? _fmt(_lastTrained) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Predictive Model'),
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