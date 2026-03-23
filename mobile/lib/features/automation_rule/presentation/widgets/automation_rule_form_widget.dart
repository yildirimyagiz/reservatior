import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AutomationRule Form Widget  |  Fields: ruleName, ruleType, triggerType, triggerConfig, conditions, actions, isActive, lastExecutedAt, executionCount

class AutomationRuleFormWidget extends StatefulWidget {
  final AutomationRule? item;
  final void Function(AutomationRule)? onSubmit;
  const AutomationRuleFormWidget({super.key, this.item, this.onSubmit});
  @override State<AutomationRuleFormWidget> createState() => _AutomationRuleFormWidgetState();
}

class _AutomationRuleFormWidgetState extends State<AutomationRuleFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _ruleName;
  String? _ruleType;
  String? _triggerType;
  String? _triggerConfig;
  String? _conditions;
  String? _actions;
  bool _isActive = false;
  DateTime? _lastExecutedAt;
  int? _executionCount;

  @override
  void initState() {
    super.initState();
    _ruleName = widget.item?.ruleName?.toString();
    _ruleType = widget.item?.ruleType?.toString();
    _triggerType = widget.item?.triggerType?.toString();
    _triggerConfig = widget.item?.triggerConfig?.toString();
    _conditions = widget.item?.conditions?.toString();
    _actions = widget.item?.actions?.toString();
    _isActive = widget.item?.isActive ?? false;
    _lastExecutedAt = widget.item?.lastExecutedAt;
    _executionCount = widget.item?.executionCount;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_ruleName?.isNotEmpty == true) 'ruleName': _ruleName,
        if (_ruleType?.isNotEmpty == true) 'ruleType': _ruleType,
        if (_triggerType?.isNotEmpty == true) 'triggerType': _triggerType,
        if (_triggerConfig?.isNotEmpty == true) 'triggerConfig': _triggerConfig,
        if (_conditions?.isNotEmpty == true) 'conditions': _conditions,
        if (_actions?.isNotEmpty == true) 'actions': _actions,
        'isActive': _isActive,
        if (_lastExecutedAt != null) 'lastExecutedAt': _lastExecutedAt!.toIso8601String(),
        if (_executionCount != null) 'executionCount': _executionCount,
    };
    final result = widget.item != null
        ? AutomationRule.fromJson({...widget.item!.toJson(), ...data})
        : AutomationRule.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Rule Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                initialValue: _ruleName?.toString() ?? '',
                onSaved: (v) => _ruleName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rule Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _ruleType?.toString() ?? '',
                onSaved: (v) => _ruleType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Trigger Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _triggerType?.toString() ?? '',
                onSaved: (v) => _triggerType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Trigger Config', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _triggerConfig?.toString() ?? '',
                onSaved: (v) => _triggerConfig = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Conditions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _conditions?.toString() ?? '',
                onSaved: (v) => _conditions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Actions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _actions?.toString() ?? '',
                onSaved: (v) => _actions = v?.isEmpty == true ? null : v,
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
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastExecutedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastExecutedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Executed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastExecutedAt != null ? _fmt(_lastExecutedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Execution Count', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _executionCount?.toString() ?? '',
                onSaved: (v) => _executionCount = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Automation Rule'),
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