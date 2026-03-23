import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ExchangeRate Form Widget  |  Fields: baseCurrency, quoteCurrency, rate, asOfDate, source

class ExchangeRateFormWidget extends StatefulWidget {
  final ExchangeRate? item;
  final void Function(ExchangeRate)? onSubmit;
  const ExchangeRateFormWidget({super.key, this.item, this.onSubmit});
  @override State<ExchangeRateFormWidget> createState() => _ExchangeRateFormWidgetState();
}

class _ExchangeRateFormWidgetState extends State<ExchangeRateFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _baseCurrency;
  String? _quoteCurrency;
  double? _rate;
  DateTime? _asOfDate;
  String? _source;

  @override
  void initState() {
    super.initState();
    _baseCurrency = widget.item?.baseCurrency?.toString();
    _quoteCurrency = widget.item?.quoteCurrency?.toString();
    _rate = widget.item?.rate;
    _asOfDate = widget.item?.asOfDate;
    _source = widget.item?.source?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_baseCurrency?.isNotEmpty == true) 'baseCurrency': _baseCurrency,
        if (_quoteCurrency?.isNotEmpty == true) 'quoteCurrency': _quoteCurrency,
        if (_rate != null) 'rate': _rate,
        if (_asOfDate != null) 'asOfDate': _asOfDate!.toIso8601String(),
        if (_source?.isNotEmpty == true) 'source': _source,
    };
    final result = widget.item != null
        ? ExchangeRate.fromJson({...widget.item!.toJson(), ...data})
        : ExchangeRate.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Base Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _baseCurrency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quote Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _quoteCurrency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _rate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _asOfDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _asOfDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'As Of Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_asOfDate != null ? _fmt(_asOfDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Source', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _source = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Exchange Rate'),
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