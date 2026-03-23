import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MLModel Form Widget  |  Fields: modelName, modelType, version, accuracy, trainingData, modelPath, isActive

class MLModelFormWidget extends StatefulWidget {
  final MLModel? item;
  final void Function(MLModel)? onSubmit;
  const MLModelFormWidget({super.key, this.item, this.onSubmit});
  @override State<MLModelFormWidget> createState() => _MLModelFormWidgetState();
}

class _MLModelFormWidgetState extends State<MLModelFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _modelName;
  String? _modelType;
  String? _version;
  double? _accuracy;
  String? _trainingData;
  String? _modelPath;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _modelName = widget.item?.modelName?.toString();
    _modelType = widget.item?.modelType?.toString();
    _version = widget.item?.version?.toString();
    _accuracy = widget.item?.accuracy;
    _trainingData = widget.item?.trainingData?.toString();
    _modelPath = widget.item?.modelPath?.toString();
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
        if (_modelType?.isNotEmpty == true) 'modelType': _modelType,
        if (_version?.isNotEmpty == true) 'version': _version,
        if (_accuracy != null) 'accuracy': _accuracy,
        if (_trainingData?.isNotEmpty == true) 'trainingData': _trainingData,
        if (_modelPath?.isNotEmpty == true) 'modelPath': _modelPath,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? MLModel.fromJson({...widget.item!.toJson(), ...data})
        : MLModel.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Model Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _modelName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Model Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _modelType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Version', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _version = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Accuracy', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _accuracy = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Training Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _trainingData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Model Path', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _modelPath = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Active'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isActive,
                  onChanged: (v) { ss(() {}); setState(() => _isActive = v); },
                ),
              ),
              const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create M L Model'),
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