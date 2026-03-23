import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PaymentInstallment Form Widget  |  Fields: negotiationId, installmentNo, amount, currency, dueDate, status, paidAt, paymentMethod, referenceNo, notes

class PaymentInstallmentFormWidget extends StatefulWidget {
  final PaymentInstallment? item;
  final void Function(PaymentInstallment)? onSubmit;
  const PaymentInstallmentFormWidget({super.key, this.item, this.onSubmit});
  @override State<PaymentInstallmentFormWidget> createState() => _PaymentInstallmentFormWidgetState();
}

class _PaymentInstallmentFormWidgetState extends State<PaymentInstallmentFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _negotiationId;
  int? _installmentNo;
  double? _amount;
  String? _currency;
  DateTime? _dueDate;
  String? _status;
  DateTime? _paidAt;
  String? _paymentMethod;
  String? _referenceNo;
  String? _notes;

  @override
  void initState() {
    super.initState();
    _negotiationId = widget.item?.negotiationId?.toString();
    _installmentNo = widget.item?.installmentNo;
    _amount = widget.item?.amount;
    _currency = widget.item?.currency?.toString();
    _dueDate = widget.item?.dueDate;
    _status = widget.item?.status?.toString();
    _paidAt = widget.item?.paidAt;
    _paymentMethod = widget.item?.paymentMethod?.toString();
    _referenceNo = widget.item?.referenceNo?.toString();
    _notes = widget.item?.notes?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_negotiationId?.isNotEmpty == true) 'negotiationId': _negotiationId,
        if (_installmentNo != null) 'installmentNo': _installmentNo,
        if (_amount != null) 'amount': _amount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_dueDate != null) 'dueDate': _dueDate!.toIso8601String(),
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_paidAt != null) 'paidAt': _paidAt!.toIso8601String(),
        if (_paymentMethod?.isNotEmpty == true) 'paymentMethod': _paymentMethod,
        if (_referenceNo?.isNotEmpty == true) 'referenceNo': _referenceNo,
        if (_notes?.isNotEmpty == true) 'notes': _notes,
    };
    final result = widget.item != null
        ? PaymentInstallment.fromJson({...widget.item!.toJson(), ...data})
        : PaymentInstallment.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Negotiation Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _negotiationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Installment No', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _installmentNo = int.tryParse(v ?? ''),
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
                    context: context, initialDate: _dueDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _dueDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Due Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_dueDate != null ? _fmt(_dueDate) : 'Tap to select date'),
                ),
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
                    context: context, initialDate: _paidAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _paidAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Paid At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_paidAt != null ? _fmt(_paidAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payment Method', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _paymentMethod = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reference No', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _referenceNo = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Notes', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _notes = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Payment Installment'),
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