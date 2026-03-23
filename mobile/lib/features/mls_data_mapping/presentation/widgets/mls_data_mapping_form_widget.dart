import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MlsDataMapping Form Widget  |  Fields: mlsProvider, fieldName, standardField, dataType, isRequired, transformRule

class MlsDataMappingFormWidget extends StatefulWidget {
  final MlsDataMapping? item;
  final void Function(MlsDataMapping)? onSubmit;
  const MlsDataMappingFormWidget({super.key, this.item, this.onSubmit});
  @override State<MlsDataMappingFormWidget> createState() => _MlsDataMappingFormWidgetState();
}

class _MlsDataMappingFormWidgetState extends State<MlsDataMappingFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _mlsProvider;
  String? _fieldName;
  String? _standardField;
  String? _dataType;
  bool _isRequired = false;
  String? _transformRule;

  @override
  void initState() {
    super.initState();
    _mlsProvider = widget.item?.mlsProvider?.toString();
    _fieldName = widget.item?.fieldName?.toString();
    _standardField = widget.item?.standardField?.toString();
    _dataType = widget.item?.dataType?.toString();
    _isRequired = widget.item?.isRequired ?? false;
    _transformRule = widget.item?.transformRule?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_mlsProvider?.isNotEmpty == true) 'mlsProvider': _mlsProvider,
        if (_fieldName?.isNotEmpty == true) 'fieldName': _fieldName,
        if (_standardField?.isNotEmpty == true) 'standardField': _standardField,
        if (_dataType?.isNotEmpty == true) 'dataType': _dataType,
        'isRequired': _isRequired,
        if (_transformRule?.isNotEmpty == true) 'transformRule': _transformRule,
    };
    final result = widget.item != null
        ? MlsDataMapping.fromJson({...widget.item!.toJson(), ...data})
        : MlsDataMapping.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Mls Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _mlsProvider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Field Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _fieldName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Standard Field', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _standardField = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _dataType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Required'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isRequired,
                  onChanged: (v) { ss(() {}); setState(() => _isRequired = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Transform Rule', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _transformRule = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Mls Data Mapping'),
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