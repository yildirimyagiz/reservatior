import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── LedgerEntry Form Widget  |  Fields: propertyId, listingId, leaseId, bookingId, contractId, billId, transactionId, type, amount, currency, occurredAt, note, meta

class LedgerEntryFormWidget extends StatefulWidget {
  final LedgerEntry? item;
  final void Function(LedgerEntry)? onSubmit;
  const LedgerEntryFormWidget({super.key, this.item, this.onSubmit});
  @override State<LedgerEntryFormWidget> createState() => _LedgerEntryFormWidgetState();
}

class _LedgerEntryFormWidgetState extends State<LedgerEntryFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _contractId;
  String? _billId;
  String? _transactionId;
  String? _type;
  double? _amount;
  String? _currency;
  DateTime? _occurredAt;
  String? _note;
  String? _meta;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _listingId = widget.item?.listingId?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _bookingId = widget.item?.bookingId?.toString();
    _contractId = widget.item?.contractId?.toString();
    _billId = widget.item?.billId?.toString();
    _transactionId = widget.item?.transactionId?.toString();
    _type = widget.item?.type?.toString();
    _amount = widget.item?.amount;
    _currency = widget.item?.currency?.toString();
    _occurredAt = widget.item?.occurredAt;
    _note = widget.item?.note?.toString();
    _meta = widget.item?.meta?.toString();
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
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
        if (_bookingId?.isNotEmpty == true) 'bookingId': _bookingId,
        if (_contractId?.isNotEmpty == true) 'contractId': _contractId,
        if (_billId?.isNotEmpty == true) 'billId': _billId,
        if (_transactionId?.isNotEmpty == true) 'transactionId': _transactionId,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_amount != null) 'amount': _amount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_occurredAt != null) 'occurredAt': _occurredAt!.toIso8601String(),
        if (_note?.isNotEmpty == true) 'note': _note,
        if (_meta?.isNotEmpty == true) 'meta': _meta,
    };
    final result = widget.item != null
        ? LedgerEntry.fromJson({...widget.item!.toJson(), ...data})
        : LedgerEntry.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Booking Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _bookingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contract Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contractId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bill Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _billId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Transaction Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _transactionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
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
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _occurredAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _occurredAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Occurred At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_occurredAt != null ? _fmt(_occurredAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Note', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _note = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Meta', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _meta = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ledger Entry'),
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