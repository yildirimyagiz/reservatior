import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PropertyValuation Form Widget  |  Fields: propertyId, valuationDate, value, source, confidence

class PropertyValuationFormWidget extends StatefulWidget {
  final PropertyValuation? item;
  final void Function(PropertyValuation)? onSubmit;
  const PropertyValuationFormWidget({super.key, this.item, this.onSubmit});
  @override State<PropertyValuationFormWidget> createState() => _PropertyValuationFormWidgetState();
}

class _PropertyValuationFormWidgetState extends State<PropertyValuationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  DateTime? _valuationDate;
  double? _value;
  String? _source;
  double? _confidence;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _valuationDate = widget.item?.valuationDate;
    _value = widget.item?.value;
    _source = widget.item?.source?.toString();
    _confidence = widget.item?.confidence;
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
        if (_valuationDate != null) 'valuationDate': _valuationDate!.toIso8601String(),
        if (_value != null) 'value': _value,
        if (_source?.isNotEmpty == true) 'source': _source,
        if (_confidence != null) 'confidence': _confidence,
    };
    final result = widget.item != null
        ? PropertyValuation.fromJson({...widget.item!.toJson(), ...data})
        : PropertyValuation.fromJson(data);
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
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _valuationDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _valuationDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Valuation Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_valuationDate != null ? _fmt(_valuationDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _value = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Source', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _source = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _confidence = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Property Valuation'),
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