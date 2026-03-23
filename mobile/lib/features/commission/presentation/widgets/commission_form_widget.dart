import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Commission Form Widget  |  Fields: listingId, leaseId, bookingId, transactionId, beneficiaryUserId, beneficiaryOrgId, ruleData, amountBase, commissionAmount, currency, records

class CommissionFormWidget extends StatefulWidget {
  final Commission? item;
  final void Function(Commission)? onSubmit;
  const CommissionFormWidget({super.key, this.item, this.onSubmit});
  @override State<CommissionFormWidget> createState() => _CommissionFormWidgetState();
}

class _CommissionFormWidgetState extends State<CommissionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  String? _leaseId;
  String? _bookingId;
  String? _transactionId;
  String? _beneficiaryUserId;
  String? _beneficiaryOrgId;
  String? _ruleData;
  double? _amountBase;
  double? _commissionAmount;
  String? _currency;
  String? _records;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _leaseId = widget.item?.leaseId?.toString();
    _bookingId = widget.item?.bookingId?.toString();
    _transactionId = widget.item?.transactionId?.toString();
    _beneficiaryUserId = widget.item?.beneficiaryUserId?.toString();
    _beneficiaryOrgId = widget.item?.beneficiaryOrgId?.toString();
    _ruleData = widget.item?.ruleData?.toString();
    _amountBase = widget.item?.amountBase;
    _commissionAmount = widget.item?.commissionAmount;
    _currency = widget.item?.currency?.toString();
    _records = widget.item?.records?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_listingId?.isNotEmpty == true) 'listingId': _listingId,
        if (_leaseId?.isNotEmpty == true) 'leaseId': _leaseId,
        if (_bookingId?.isNotEmpty == true) 'bookingId': _bookingId,
        if (_transactionId?.isNotEmpty == true) 'transactionId': _transactionId,
        if (_beneficiaryUserId?.isNotEmpty == true) 'beneficiaryUserId': _beneficiaryUserId,
        if (_beneficiaryOrgId?.isNotEmpty == true) 'beneficiaryOrgId': _beneficiaryOrgId,
        if (_ruleData?.isNotEmpty == true) 'ruleData': _ruleData,
        if (_amountBase != null) 'amountBase': _amountBase,
        if (_commissionAmount != null) 'commissionAmount': _commissionAmount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_records?.isNotEmpty == true) 'records': _records,
    };
    final result = widget.item != null
        ? Commission.fromJson({...widget.item!.toJson(), ...data})
        : Commission.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Listing Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _listingId?.toString() ?? '',
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lease Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _leaseId?.toString() ?? '',
                onSaved: (v) => _leaseId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Booking Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _bookingId?.toString() ?? '',
                onSaved: (v) => _bookingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Transaction Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _transactionId?.toString() ?? '',
                onSaved: (v) => _transactionId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Beneficiary User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _beneficiaryUserId?.toString() ?? '',
                onSaved: (v) => _beneficiaryUserId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Beneficiary Org Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _beneficiaryOrgId?.toString() ?? '',
                onSaved: (v) => _beneficiaryOrgId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rule Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _ruleData?.toString() ?? '',
                onSaved: (v) => _ruleData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount Base', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _amountBase?.toString() ?? '',
                onSaved: (v) => _amountBase = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Commission Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _commissionAmount?.toString() ?? '',
                onSaved: (v) => _commissionAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _currency?.toString() ?? '',
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Records', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _records?.toString() ?? '',
                onSaved: (v) => _records = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Commission'),
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