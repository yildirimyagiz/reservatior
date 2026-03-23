import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MortgageOffer Form Widget  |  Fields: contactId, propertyId, lender, offerAmount, interestRate, termYears, monthlyPayment, currency, status, offeredAt, acceptedAt, expiresAt, conditions

class MortgageOfferFormWidget extends StatefulWidget {
  final MortgageOffer? item;
  final void Function(MortgageOffer)? onSubmit;
  const MortgageOfferFormWidget({super.key, this.item, this.onSubmit});
  @override State<MortgageOfferFormWidget> createState() => _MortgageOfferFormWidgetState();
}

class _MortgageOfferFormWidgetState extends State<MortgageOfferFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _contactId;
  String? _propertyId;
  String? _lender;
  double? _offerAmount;
  double? _interestRate;
  int? _termYears;
  double? _monthlyPayment;
  String? _currency;
  String? _status;
  DateTime? _offeredAt;
  DateTime? _acceptedAt;
  DateTime? _expiresAt;
  String? _conditions;

  @override
  void initState() {
    super.initState();
    _contactId = widget.item?.contactId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _lender = widget.item?.lender?.toString();
    _offerAmount = widget.item?.offerAmount;
    _interestRate = widget.item?.interestRate;
    _termYears = widget.item?.termYears;
    _monthlyPayment = widget.item?.monthlyPayment;
    _currency = widget.item?.currency?.toString();
    _status = widget.item?.status?.toString();
    _offeredAt = widget.item?.offeredAt;
    _acceptedAt = widget.item?.acceptedAt;
    _expiresAt = widget.item?.expiresAt;
    _conditions = widget.item?.conditions?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_contactId?.isNotEmpty == true) 'contactId': _contactId,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_lender?.isNotEmpty == true) 'lender': _lender,
        if (_offerAmount != null) 'offerAmount': _offerAmount,
        if (_interestRate != null) 'interestRate': _interestRate,
        if (_termYears != null) 'termYears': _termYears,
        if (_monthlyPayment != null) 'monthlyPayment': _monthlyPayment,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_offeredAt != null) 'offeredAt': _offeredAt!.toIso8601String(),
        if (_acceptedAt != null) 'acceptedAt': _acceptedAt!.toIso8601String(),
        if (_expiresAt != null) 'expiresAt': _expiresAt!.toIso8601String(),
        if (_conditions?.isNotEmpty == true) 'conditions': _conditions,
    };
    final result = widget.item != null
        ? MortgageOffer.fromJson({...widget.item!.toJson(), ...data})
        : MortgageOffer.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Contact Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _contactId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lender', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _lender = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Offer Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _offerAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Interest Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _interestRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Term Years', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _termYears = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Monthly Payment', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _monthlyPayment = double.tryParse(v ?? ''),
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
                    context: context, initialDate: _offeredAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _offeredAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Offered At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_offeredAt != null ? _fmt(_offeredAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _acceptedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _acceptedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Accepted At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_acceptedAt != null ? _fmt(_acceptedAt) : 'Tap to select date'),
                ),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Conditions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _conditions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Mortgage Offer'),
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