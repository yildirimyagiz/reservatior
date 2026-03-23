import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── TaxDepreciation Form Widget  |  Fields: propertyId, assetType, costBasis, depreciationMethod, usefulLife, salvageValue, startDate, accumulatedDepreciation, organizationId

class TaxDepreciationFormWidget extends StatefulWidget {
  final TaxDepreciation? item;
  final void Function(TaxDepreciation)? onSubmit;
  const TaxDepreciationFormWidget({super.key, this.item, this.onSubmit});
  @override State<TaxDepreciationFormWidget> createState() => _TaxDepreciationFormWidgetState();
}

class _TaxDepreciationFormWidgetState extends State<TaxDepreciationFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _assetType;
  double? _costBasis;
  String? _depreciationMethod;
  int? _usefulLife;
  double? _salvageValue;
  DateTime? _startDate;
  double? _accumulatedDepreciation;
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _assetType = widget.item?.assetType?.toString();
    _costBasis = widget.item?.costBasis;
    _depreciationMethod = widget.item?.depreciationMethod?.toString();
    _usefulLife = widget.item?.usefulLife;
    _salvageValue = widget.item?.salvageValue;
    _startDate = widget.item?.startDate;
    _accumulatedDepreciation = widget.item?.accumulatedDepreciation;
    _organizationId = widget.item?.organizationId?.toString();
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
        if (_assetType?.isNotEmpty == true) 'assetType': _assetType,
        if (_costBasis != null) 'costBasis': _costBasis,
        if (_depreciationMethod?.isNotEmpty == true) 'depreciationMethod': _depreciationMethod,
        if (_usefulLife != null) 'usefulLife': _usefulLife,
        if (_salvageValue != null) 'salvageValue': _salvageValue,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_accumulatedDepreciation != null) 'accumulatedDepreciation': _accumulatedDepreciation,
        if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
    };
    final result = widget.item != null
        ? TaxDepreciation.fromJson({...widget.item!.toJson(), ...data})
        : TaxDepreciation.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Asset Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _assetType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cost Basis', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _costBasis = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Depreciation Method', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _depreciationMethod = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Useful Life', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _usefulLife = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Salvage Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _salvageValue = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Start Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startDate != null ? _fmt(_startDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Accumulated Depreciation', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _accumulatedDepreciation = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Organization Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Tax Depreciation'),
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