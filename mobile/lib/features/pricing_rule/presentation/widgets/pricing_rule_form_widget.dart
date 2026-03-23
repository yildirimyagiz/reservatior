import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PricingRule Form Widget  |  Fields: listingId, name, description, ruleType, conditions, actions, priority, isActive, basePrice, strategy, startDate, endDate, minNights, maxNights, weekdayPrices, taxRules, discountRules, currencyId

class PricingRuleFormWidget extends StatefulWidget {
  final PricingRule? item;
  final void Function(PricingRule)? onSubmit;
  const PricingRuleFormWidget({super.key, this.item, this.onSubmit});
  @override State<PricingRuleFormWidget> createState() => _PricingRuleFormWidgetState();
}

class _PricingRuleFormWidgetState extends State<PricingRuleFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _listingId;
  String? _name;
  String? _description;
  String? _ruleType;
  String? _conditions;
  String? _actions;
  int? _priority;
  bool _isActive = false;
  double? _basePrice;
  String? _strategy;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _minNights;
  int? _maxNights;
  String? _weekdayPrices;
  String? _taxRules;
  String? _discountRules;
  String? _currencyId;

  @override
  void initState() {
    super.initState();
    _listingId = widget.item?.listingId?.toString();
    _name = widget.item?.name?.toString();
    _description = widget.item?.description?.toString();
    _ruleType = widget.item?.ruleType?.toString();
    _conditions = widget.item?.conditions?.toString();
    _actions = widget.item?.actions?.toString();
    _priority = widget.item?.priority;
    _isActive = widget.item?.isActive ?? false;
    _basePrice = widget.item?.basePrice;
    _strategy = widget.item?.strategy?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _minNights = widget.item?.minNights;
    _maxNights = widget.item?.maxNights;
    _weekdayPrices = widget.item?.weekdayPrices?.toString();
    _taxRules = widget.item?.taxRules?.toString();
    _discountRules = widget.item?.discountRules?.toString();
    _currencyId = widget.item?.currencyId?.toString();
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
        if (_name?.isNotEmpty == true) 'name': _name,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_ruleType?.isNotEmpty == true) 'ruleType': _ruleType,
        if (_conditions?.isNotEmpty == true) 'conditions': _conditions,
        if (_actions?.isNotEmpty == true) 'actions': _actions,
        if (_priority != null) 'priority': _priority,
        'isActive': _isActive,
        if (_basePrice != null) 'basePrice': _basePrice,
        if (_strategy?.isNotEmpty == true) 'strategy': _strategy,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_minNights != null) 'minNights': _minNights,
        if (_maxNights != null) 'maxNights': _maxNights,
        if (_weekdayPrices?.isNotEmpty == true) 'weekdayPrices': _weekdayPrices,
        if (_taxRules?.isNotEmpty == true) 'taxRules': _taxRules,
        if (_discountRules?.isNotEmpty == true) 'discountRules': _discountRules,
        if (_currencyId?.isNotEmpty == true) 'currencyId': _currencyId,
    };
    final result = widget.item != null
        ? PricingRule.fromJson({...widget.item!.toJson(), ...data})
        : PricingRule.fromJson(data);
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
                onSaved: (v) => _listingId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _name = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rule Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _ruleType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Conditions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _conditions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Actions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _actions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Priority', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _priority = int.tryParse(v ?? ''),
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'Base Price', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _basePrice = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Strategy', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                onSaved: (v) => _strategy = v?.isEmpty == true ? null : v,
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
                decoration: const InputDecoration(labelText: 'Min Nights', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _minNights = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Nights', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxNights = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weekday Prices', prefixIcon: const Icon(Icons.attach_money), border: const OutlineInputBorder()),
                onSaved: (v) => _weekdayPrices = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tax Rules', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _taxRules = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Discount Rules', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _discountRules = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Currency Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _currencyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Pricing Rule'),
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