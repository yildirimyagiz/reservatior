import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── InvestorProperty Form Widget  |  Fields: portfolioId, propertyId, acquiredAt, acquiredCost, mortgageBalance, mortgageRate, mortgageTerm, insuranceProvider, insuranceAmount

class InvestorPropertyFormWidget extends StatefulWidget {
  final InvestorProperty? item;
  final void Function(InvestorProperty)? onSubmit;
  const InvestorPropertyFormWidget({super.key, this.item, this.onSubmit});
  @override State<InvestorPropertyFormWidget> createState() => _InvestorPropertyFormWidgetState();
}

class _InvestorPropertyFormWidgetState extends State<InvestorPropertyFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _portfolioId;
  String? _propertyId;
  DateTime? _acquiredAt;
  double? _acquiredCost;
  double? _mortgageBalance;
  double? _mortgageRate;
  int? _mortgageTerm;
  String? _insuranceProvider;
  double? _insuranceAmount;

  @override
  void initState() {
    super.initState();
    _portfolioId = widget.item?.portfolioId?.toString();
    _propertyId = widget.item?.propertyId?.toString();
    _acquiredAt = widget.item?.acquiredAt;
    _acquiredCost = widget.item?.acquiredCost;
    _mortgageBalance = widget.item?.mortgageBalance;
    _mortgageRate = widget.item?.mortgageRate;
    _mortgageTerm = widget.item?.mortgageTerm;
    _insuranceProvider = widget.item?.insuranceProvider?.toString();
    _insuranceAmount = widget.item?.insuranceAmount;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_portfolioId?.isNotEmpty == true) 'portfolioId': _portfolioId,
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_acquiredAt != null) 'acquiredAt': _acquiredAt!.toIso8601String(),
        if (_acquiredCost != null) 'acquiredCost': _acquiredCost,
        if (_mortgageBalance != null) 'mortgageBalance': _mortgageBalance,
        if (_mortgageRate != null) 'mortgageRate': _mortgageRate,
        if (_mortgageTerm != null) 'mortgageTerm': _mortgageTerm,
        if (_insuranceProvider?.isNotEmpty == true) 'insuranceProvider': _insuranceProvider,
        if (_insuranceAmount != null) 'insuranceAmount': _insuranceAmount,
    };
    final result = widget.item != null
        ? InvestorProperty.fromJson({...widget.item!.toJson(), ...data})
        : InvestorProperty.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Portfolio Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _portfolioId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _acquiredAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _acquiredAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Acquired At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_acquiredAt != null ? _fmt(_acquiredAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Acquired Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _acquiredCost = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mortgage Balance', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _mortgageBalance = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mortgage Rate', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _mortgageRate = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mortgage Term', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _mortgageTerm = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Insurance Provider', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _insuranceProvider = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Insurance Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _insuranceAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Investor Property'),
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