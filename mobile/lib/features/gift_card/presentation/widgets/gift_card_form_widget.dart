import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── GiftCard Form Widget  |  Fields: code, amount, balance, currency, expiresAt, isActive, issuedTo, issuedBy, issuedFor

class GiftCardFormWidget extends StatefulWidget {
  final GiftCard? item;
  final void Function(GiftCard)? onSubmit;
  const GiftCardFormWidget({super.key, this.item, this.onSubmit});
  @override State<GiftCardFormWidget> createState() => _GiftCardFormWidgetState();
}

class _GiftCardFormWidgetState extends State<GiftCardFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _code;
  double? _amount;
  double? _balance;
  String? _currency;
  DateTime? _expiresAt;
  bool _isActive = false;
  String? _issuedTo;
  String? _issuedBy;
  String? _issuedFor;

  @override
  void initState() {
    super.initState();
    _code = widget.item?.code?.toString();
    _amount = widget.item?.amount;
    _balance = widget.item?.balance;
    _currency = widget.item?.currency?.toString();
    _expiresAt = widget.item?.expiresAt;
    _isActive = widget.item?.isActive ?? false;
    _issuedTo = widget.item?.issuedTo?.toString();
    _issuedBy = widget.item?.issuedBy?.toString();
    _issuedFor = widget.item?.issuedFor?.toString();
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
        if (_amount != null) 'amount': _amount,
        if (_balance != null) 'balance': _balance,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
        'isActive': _isActive,
        if (_issuedTo?.isNotEmpty == true) 'issuedTo': _issuedTo,
        if (_issuedBy?.isNotEmpty == true) 'issuedBy': _issuedBy,
        if (_issuedFor?.isNotEmpty == true) 'issuedFor': _issuedFor,
    };
    final result = widget.item != null
        ? GiftCard.fromJson({...widget.item!.toJson(), ...data})
        : GiftCard.fromJson(data);
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
                onSaved: (v) => _code = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _amount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Balance', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _balance = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _expiresAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _expiresAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Expires At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_expiresAt != null ? _fmt(_expiresAt) : 'Tap to select date'),
                ),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Issued To', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _issuedTo = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Issued By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _issuedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Issued For', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _issuedFor = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Gift Card'),
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