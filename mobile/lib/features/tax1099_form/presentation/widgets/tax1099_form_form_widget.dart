import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Tax1099Form Form Widget  |  Fields: recipientId, taxYear, formType, amount, description, issuedAt, mailedAt

class Tax1099FormFormWidget extends StatefulWidget {
  final Tax1099Form? item;
  final void Function(Tax1099Form)? onSubmit;
  const Tax1099FormFormWidget({super.key, this.item, this.onSubmit});
  @override State<Tax1099FormFormWidget> createState() => _Tax1099FormFormWidgetState();
}

class _Tax1099FormFormWidgetState extends State<Tax1099FormFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _recipientId;
  int? _taxYear;
  String? _formType;
  double? _amount;
  String? _description;
  DateTime? _issuedAt;
  DateTime? _mailedAt;

  @override
  void initState() {
    super.initState();
    _recipientId = widget.item?.recipientId?.toString();
    _taxYear = widget.item?.taxYear;
    _formType = widget.item?.formType?.toString();
    _amount = widget.item?.amount;
    _description = widget.item?.description?.toString();
    _issuedAt = widget.item?.issuedAt;
    _mailedAt = widget.item?.mailedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_recipientId?.isNotEmpty == true) 'recipientId': _recipientId,
        if (_taxYear != null) 'taxYear': _taxYear,
        if (_formType?.isNotEmpty == true) 'formType': _formType,
        if (_amount != null) 'amount': _amount,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_issuedAt != null) 'issuedAt': _issuedAt!.toIso8601String(),
        if (_mailedAt != null) 'mailedAt': _mailedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? Tax1099Form.fromJson({...widget.item!.toJson(), ...data})
        : Tax1099Form.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Recipient Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _recipientId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tax Year', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _taxYear = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Form Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _formType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _amount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _issuedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _issuedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Issued At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_issuedAt != null ? _fmt(_issuedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _mailedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _mailedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Mailed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_mailedAt != null ? _fmt(_mailedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Tax1099 Form'),
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