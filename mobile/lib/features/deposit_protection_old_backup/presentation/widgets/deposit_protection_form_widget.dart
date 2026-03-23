import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── DepositProtection Form Widget  |  Fields: leaseId, provider, scheme, reference, amount, currency, status, protectedAt, claimedAt, returnedAt

class DepositProtectionFormWidget extends StatefulWidget {
  final DepositProtection? item;
  final void Function(DepositProtection)? onSubmit;
  const DepositProtectionFormWidget({super.key, this.item, this.onSubmit});
  @override State<DepositProtectionFormWidget> createState() => _DepositProtectionFormWidgetState();
}

class _DepositProtectionFormWidgetState extends State<DepositProtectionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _leaseId;
  String? _provider;
  String? _scheme;
  String? _reference;
  double? _amount;
  String? _currency;
  String? _status;
  DateTime? _protectedAt;
  DateTime? _claimedAt;
  DateTime? _returnedAt;

  @override
  void initState() {
    super.initState();
    _leaseId = widget.item?.leaseId?.toString();
    _provider = widget.item?.provider?.toString();
    _scheme = widget.item?.scheme?.toString();
    _reference = widget.item?.reference?.toString();
    _amount = widget.item?.amount;
    _currency = widget.item?.currency?.toString();
    _status = widget.item?.status?.toString();
    _protectedAt = widget.item?.protectedAt;
    _claimedAt = widget.item?.claimedAt;
    _returnedAt = widget.item?.returnedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
        if (_provider?.isNotEmpty == true) 'provider': _provider,
        if (_scheme?.isNotEmpty == true) 'scheme': _scheme,
        if (_reference?.isNotEmpty == true) 'reference': _reference,
        if (_amount != null) 'amount': _amount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_protectedAt != null) 'protectedAt': _protectedAt!.toIso8601String(),
        if (_claimedAt != null) 'claimedAt': _claimedAt!.toIso8601String(),
        if (_returnedAt != null) 'returnedAt': _returnedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? DepositProtection.fromJson({...widget.item!.toJson(), ...data})
        : DepositProtection.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _provider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Scheme', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _scheme = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reference', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _reference = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _amount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _protectedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _protectedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Protected At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_protectedAt != null ? _fmt(_protectedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _claimedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _claimedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Claimed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_claimedAt != null ? _fmt(_claimedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _returnedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _returnedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Returned At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_returnedAt != null ? _fmt(_returnedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Deposit Protection'),
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