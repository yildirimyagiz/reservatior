import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── CommissionRule Form Widget  |  Fields: providerId, ruleType, startDate, endDate, commission, minVolume, maxVolume, conditions

class CommissionRuleFormWidget extends StatefulWidget {
  final CommissionRule? item;
  final void Function(CommissionRule)? onSubmit;
  const CommissionRuleFormWidget({super.key, this.item, this.onSubmit});
  @override State<CommissionRuleFormWidget> createState() => _CommissionRuleFormWidgetState();
}

class _CommissionRuleFormWidgetState extends State<CommissionRuleFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _providerId;
  String? _ruleType;
  DateTime? _startDate;
  DateTime? _endDate;
  double? _commission;
  int? _minVolume;
  int? _maxVolume;
  String? _conditions;

  @override
  void initState() {
    super.initState();
    _providerId = widget.item?.providerId?.toString();
    _ruleType = widget.item?.ruleType?.toString();
    _startDate = widget.item?.startDate;
    _endDate = widget.item?.endDate;
    _commission = widget.item?.commission;
    _minVolume = widget.item?.minVolume;
    _maxVolume = widget.item?.maxVolume;
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
        if (_providerId?.isNotEmpty == true) 'providerId': _providerId,
        if (_ruleType?.isNotEmpty == true) 'ruleType': _ruleType,
        if (_startDate != null) 'startDate': _startDate!.toIso8601String(),
        if (_endDate != null) 'endDate': _endDate!.toIso8601String(),
        if (_commission != null) 'commission': _commission,
        if (_minVolume != null) 'minVolume': _minVolume,
        if (_maxVolume != null) 'maxVolume': _maxVolume,
        if (_conditions?.isNotEmpty == true) 'conditions': _conditions,
    };
    final result = widget.item != null
        ? CommissionRule.fromJson({...widget.item!.toJson(), ...data})
        : CommissionRule.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Provider Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _providerId?.toString() ?? '',
                onSaved: (v) => _providerId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rule Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _ruleType?.toString() ?? '',
                onSaved: (v) => _ruleType = v?.isEmpty == true ? null : v,
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
                decoration: const InputDecoration(labelText: 'Commission', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _commission?.toString() ?? '',
                onSaved: (v) => _commission = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Min Volume', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _minVolume?.toString() ?? '',
                onSaved: (v) => _minVolume = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Volume', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _maxVolume?.toString() ?? '',
                onSaved: (v) => _maxVolume = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Conditions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _conditions?.toString() ?? '',
                onSaved: (v) => _conditions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Commission Rule'),
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