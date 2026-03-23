import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── InvestorPortfolio Form Widget  |  Fields: userId, name, targetIrr, riskTolerance, investmentHorizon, totalInvested, currentValue, totalReturns, organizationId

class InvestorPortfolioFormWidget extends StatefulWidget {
  final InvestorPortfolio? item;
  final void Function(InvestorPortfolio)? onSubmit;
  const InvestorPortfolioFormWidget({super.key, this.item, this.onSubmit});
  @override State<InvestorPortfolioFormWidget> createState() => _InvestorPortfolioFormWidgetState();
}

class _InvestorPortfolioFormWidgetState extends State<InvestorPortfolioFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _name;
  double? _targetIrr;
  String? _riskTolerance;
  String? _investmentHorizon;
  double? _totalInvested;
  double? _currentValue;
  double? _totalReturns;
  String? _organizationId;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _name = widget.item?.name?.toString();
    _targetIrr = widget.item?.targetIrr;
    _riskTolerance = widget.item?.riskTolerance?.toString();
    _investmentHorizon = widget.item?.investmentHorizon?.toString();
    _totalInvested = widget.item?.totalInvested;
    _currentValue = widget.item?.currentValue;
    _totalReturns = widget.item?.totalReturns;
    _organizationId = widget.item?.organizationId?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_userId?.isNotEmpty == true) 'userId': _userId,
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_targetIrr != null) 'targetIrr': _targetIrr,
        if (_riskTolerance?.isNotEmpty == true) 'riskTolerance': _riskTolerance,
        if (_investmentHorizon?.isNotEmpty == true) 'investmentHorizon': _investmentHorizon,
        if (_totalInvested != null) 'totalInvested': _totalInvested,
        if (_currentValue != null) 'currentValue': _currentValue,
        if (_totalReturns != null) 'totalReturns': _totalReturns,
        if (_organizationId?.isNotEmpty == true) 'organizationId': _organizationId,
    };
    final result = widget.item != null
        ? InvestorPortfolio.fromJson({...widget.item!.toJson(), ...data})
        : InvestorPortfolio.fromJson(data);
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
                decoration: InputDecoration(labelText: 'User Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Target Irr', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _targetIrr = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Risk Tolerance', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _riskTolerance = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Investment Horizon', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _investmentHorizon = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Invested', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalInvested = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Current Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _currentValue = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Returns', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _totalReturns = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Organization Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _organizationId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Investor Portfolio'),
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