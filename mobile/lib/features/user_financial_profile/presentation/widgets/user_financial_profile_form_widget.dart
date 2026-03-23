import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── UserFinancialProfile Form Widget  |  Fields: userId, region, currency, monthlyIncome, monthlyObligations, riskTolerance, assumptions

class UserFinancialProfileFormWidget extends StatefulWidget {
  final UserFinancialProfile? item;
  final void Function(UserFinancialProfile)? onSubmit;
  const UserFinancialProfileFormWidget({super.key, this.item, this.onSubmit});
  @override State<UserFinancialProfileFormWidget> createState() => _UserFinancialProfileFormWidgetState();
}

class _UserFinancialProfileFormWidgetState extends State<UserFinancialProfileFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _region;
  String? _currency;
  double? _monthlyIncome;
  double? _monthlyObligations;
  String? _riskTolerance;
  String? _assumptions;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _region = widget.item?.region?.toString();
    _currency = widget.item?.currency?.toString();
    _monthlyIncome = widget.item?.monthlyIncome;
    _monthlyObligations = widget.item?.monthlyObligations;
    _riskTolerance = widget.item?.riskTolerance?.toString();
    _assumptions = widget.item?.assumptions?.toString();
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
        if (_region?.isNotEmpty == true) 'region': _region,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_monthlyIncome != null) 'monthlyIncome': _monthlyIncome,
        if (_monthlyObligations != null) 'monthlyObligations': _monthlyObligations,
        if (_riskTolerance?.isNotEmpty == true) 'riskTolerance': _riskTolerance,
        if (_assumptions?.isNotEmpty == true) 'assumptions': _assumptions,
    };
    final result = widget.item != null
        ? UserFinancialProfile.fromJson({...widget.item!.toJson(), ...data})
        : UserFinancialProfile.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Region', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _region = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Monthly Income', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _monthlyIncome = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Monthly Obligations', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _monthlyObligations = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Risk Tolerance', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _riskTolerance = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Assumptions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _assumptions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create User Financial Profile'),
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