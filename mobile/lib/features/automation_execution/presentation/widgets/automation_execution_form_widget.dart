import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AutomationExecution Form Widget  |  Fields: ruleId, triggerEvent, executionData, status, executedAt, processingTimeMs

class AutomationExecutionFormWidget extends StatefulWidget {
  final AutomationExecution? item;
  final void Function(AutomationExecution)? onSubmit;
  const AutomationExecutionFormWidget({super.key, this.item, this.onSubmit});
  @override State<AutomationExecutionFormWidget> createState() => _AutomationExecutionFormWidgetState();
}

class _AutomationExecutionFormWidgetState extends State<AutomationExecutionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _ruleId;
  String? _triggerEvent;
  String? _executionData;
  String? _status;
  DateTime? _executedAt;
  int? _processingTimeMs;

  @override
  void initState() {
    super.initState();
    _ruleId = widget.item?.ruleId?.toString();
    _triggerEvent = widget.item?.triggerEvent?.toString();
    _executionData = widget.item?.executionData?.toString();
    _status = widget.item?.status?.toString();
    _executedAt = widget.item?.executedAt;
    _processingTimeMs = widget.item?.processingTimeMs;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_ruleId?.isNotEmpty == true) 'ruleId': _ruleId,
        if (_triggerEvent?.isNotEmpty == true) 'triggerEvent': _triggerEvent,
        if (_executionData?.isNotEmpty == true) 'executionData': _executionData,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_executedAt != null) 'executedAt': _executedAt!.toIso8601String(),
        if (_processingTimeMs != null) 'processingTimeMs': _processingTimeMs,
    };
    final result = widget.item != null
        ? AutomationExecution.fromJson({...widget.item!.toJson(), ...data})
        : AutomationExecution.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Rule Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                initialValue: _ruleId?.toString() ?? '',
                onSaved: (v) => _ruleId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Trigger Event', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _triggerEvent?.toString() ?? '',
                onSaved: (v) => _triggerEvent = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Execution Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _executionData?.toString() ?? '',
                onSaved: (v) => _executionData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                initialValue: _status?.toString() ?? '',
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _executedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _executedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Executed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_executedAt != null ? _fmt(_executedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Processing Time Ms', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                initialValue: _processingTimeMs?.toString() ?? '',
                onSaved: (v) => _processingTimeMs = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Automation Execution'),
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