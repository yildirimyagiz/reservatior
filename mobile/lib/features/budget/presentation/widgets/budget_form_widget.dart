import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Budget Form Widget  |  Fields: userId, name, description, budgetType, period, startDate, endDate, totalAmount, currency, lineItems, categories, alerts, actualSpent, isActive

class BudgetFormWidget extends StatefulWidget {
  final Budget? item;
  final void Function(Budget)? onSubmit;
  const BudgetFormWidget({super.key, this.item, this.onSubmit});
  @override State<BudgetFormWidget> createState() => _BudgetFormWidgetState();
}

class _BudgetFormWidgetState extends State<BudgetFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _userId;
  String? _name;
  String? _description;
  String? _budgetType;
  String? _period;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _totalAmount;
  String? _currency;
  String? _lineItems;
  String? _categories;
  String? _alerts;
  double? _actualSpent;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _userId = widget.item?.userId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _budgetType = widget.item?.budgetType?.toString();
    _period = widget.item?.period?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _totalAmount = widget.item?.totalAmount;
    _currency = widget.item?.currency?.toString();
    _lineItems = widget.item?.lineItems?.toString();
    _categories = widget.item?.categories?.toString();
    _alerts = widget.item?.alerts?.toString();
    _actualSpent = widget.item?.actualSpent;
    _isActive = widget.item?.isActive ?? false;
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
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_budgetType?.isNotEmpty == true) 'budgetType': _budgetType,
        if (_period?.isNotEmpty == true) 'period': _period,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_totalAmount != null) 'totalAmount': _totalAmount,
        if (_currency?.isNotEmpty == true) 'currency': _currency,
        if (_lineItems?.isNotEmpty == true) 'lineItems': _lineItems,
        if (_categories?.isNotEmpty == true) 'categories': _categories,
        if (_alerts?.isNotEmpty == true) 'alerts': _alerts,
        if (_actualSpent != null) 'actualSpent': _actualSpent,
        'isActive': _isActive,
    };
    final result = widget.item != null
        ? Budget.fromJson({...widget.item!.toJson(), ...data})
        : Budget.fromJson(data);
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
                initialValue: _userId?.toString() ?? '',
                onSaved: (v) => _userId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _name?.toString() ?? '',
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                initialValue: _description?.toString() ?? '',
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Budget Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _budgetType?.toString() ?? '',
                onSaved: (v) => _budgetType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Period', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _period?.toString() ?? '',
                onSaved: (v) => _period = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Start Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startDate != null ? _fmt(_startDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _endDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _endDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'End Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_endDate != null ? _fmt(_endDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Total Amount', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                initialValue: _totalAmount?.toString() ?? '',
                onSaved: (v) => _totalAmount = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _currency?.toString() ?? '',
                onSaved: (v) => _currency = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Line Items', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _lineItems?.toString() ?? '',
                onSaved: (v) => _lineItems = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Categories', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _categories?.toString() ?? '',
                onSaved: (v) => _categories = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alerts', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _alerts?.toString() ?? '',
                onSaved: (v) => _alerts = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Actual Spent', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _actualSpent?.toString() ?? '',
                onSaved: (v) => _actualSpent = double.tryParse(v ?? ''),
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
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Budget'),
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