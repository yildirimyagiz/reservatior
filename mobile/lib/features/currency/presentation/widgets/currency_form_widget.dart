import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Currency Form Widget  |  Fields: code, name, symbol, exchangeRate, isActive

class CurrencyFormWidget extends StatefulWidget {
  final Currency? item;
  final void Function(Currency)? onSubmit;
  const CurrencyFormWidget({super.key, this.item, this.onSubmit});
  @override State<CurrencyFormWidget> createState() => _CurrencyFormWidgetState();
}

class _CurrencyFormWidgetState extends State<CurrencyFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _code;
  String? _name;
  String? _symbol;
  double? _exchangeRate;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _code = widget.item?.code?.toString();
    _name = widget.item?.name?.toString();
    _symbol = widget.item?.symbol?.toString();
    _exchangeRate = widget.item?.exchangeRate;
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
        if (_code?.isNotEmpty == true) 'code': _code,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_symbol?.isNotEmpty == true) 'symbol': _symbol,
        if (_exchangeRate != null) 'exchangeRate': _exchangeRate,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? Currency.fromJson({...widget.item!.toJson(), ...data})
        : Currency.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Code', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _code?.toString() ?? '',
                onSaved: (v) => _code = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _name?.toString() ?? '',
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Symbol', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _symbol?.toString() ?? '',
                onSaved: (v) => _symbol = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Exchange Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _exchangeRate?.toString() ?? '',
                onSaved: (v) => _exchangeRate = double.tryParse(v ?? ''),
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create Currency'),
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