import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIPropertyValuation Form Widget  |  Fields: modelId, propertyId, predictedValue, confidenceScore, valuationDate, inputFeatures, comparableSales, marketTrends, status

class AIPropertyValuationFormWidget extends StatefulWidget {
  final AIPropertyValuation? item;
  final void Function(AIPropertyValuation)? onSubmit;
  const AIPropertyValuationFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIPropertyValuationFormWidget> createState() => _AIPropertyValuationFormWidgetState();
}

class _AIPropertyValuationFormWidgetState extends State<AIPropertyValuationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _modelId;
  String? _propertyId;
  double? _predictedValue;
  double? _confidenceScore;
  DateTime? _valuationDate;
  String? _inputFeatures;
  String? _comparableSales;
  String? _marketTrends;
  String? _status;

  @override
  void initState() {
    super.initState();
    _modelId = widget.item?.modelId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _predictedValue = widget.item?.predictedValue;
    _confidenceScore = widget.item?.confidenceScore;
    _valuationDate = widget.item?.valuationDate;
    _inputFeatures = widget.item?.inputFeatures?.toString();
    _comparableSales = widget.item?.comparableSales?.toString();
    _marketTrends = widget.item?.marketTrends?.toString();
    _status = widget.item?.status?.toString();
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
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_predictedValue != null) 'predictedValue': _predictedValue,
        if (_confidenceScore != null) 'confidenceScore': _confidenceScore,
        if (_valuationDate != null) 'valuationDate': _valuationDate!.toIso8601String(),
        if (_inputFeatures?.isNotEmpty == true) 'inputFeatures': _inputFeatures,
        if (_comparableSales?.isNotEmpty == true) 'comparableSales': _comparableSales,
        if (_marketTrends?.isNotEmpty == true) 'marketTrends': _marketTrends,
        if (_status?.isNotEmpty == true) 'status': _status,
    };
    final result = widget.item != null
        ? AIPropertyValuation.fromJson({...widget.item!.toJson(), ...data})
        : AIPropertyValuation.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Predicted Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _predictedValue = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confidence Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _confidenceScore = double.tryParse(v ?? ''),
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
                decoration: InputDecoration(labelText: 'Input Features', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _inputFeatures = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Comparable Sales', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _comparableSales = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Market Trends', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _marketTrends = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Property Valuation'),
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