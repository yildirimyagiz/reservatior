import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyCompliance Form Widget  |  Fields: propertyId, type, status, data, inspectorId, inspectorContactId

class PropertyComplianceFormWidget extends StatefulWidget {
  final PropertyCompliance? item;
  final void Function(PropertyCompliance)? onSubmit;
  const PropertyComplianceFormWidget({super.key, this.item, this.onSubmit});
  @override State<PropertyComplianceFormWidget> createState() => _PropertyComplianceFormWidgetState();
}

class _PropertyComplianceFormWidgetState extends State<PropertyComplianceFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _type;
  String? _status;
  String? _data;
  String? _inspectorId;
  String? _inspectorContactId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _type = widget.item?.type?.toString();
    _status = widget.item?.status?.toString();
    _data = widget.item?.data?.toString();
    _inspectorId = widget.item?.inspectorId?.toString();
    _inspectorContactId = widget.item?.inspectorContactId?.toString();
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
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_data?.isNotEmpty == true) 'data': _data,
        if (_inspectorId?.isNotEmpty == true) 'inspectorId': _inspectorId,
        if (_inspectorContactId?.isNotEmpty == true) 'inspectorContactId': _inspectorContactId,
    };
    final result = widget.item != null
        ? PropertyCompliance.fromJson({...widget.item!.toJson(), ...data})
        : PropertyCompliance.fromJson(data);
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
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _data = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Inspector Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _inspectorId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Inspector Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _inspectorContactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property Compliance'),
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