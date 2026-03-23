import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AutomationTask Form Widget  |  Fields: taskType, persona, command, status, schedule, lastRun, nextRun, configuration, result, error

class AutomationTaskFormWidget extends StatefulWidget {
  final AutomationTask? item;
  final void Function(AutomationTask)? onSubmit;
  const AutomationTaskFormWidget({super.key, this.item, this.onSubmit});
  @override State<AutomationTaskFormWidget> createState() => _AutomationTaskFormWidgetState();
}

class _AutomationTaskFormWidgetState extends State<AutomationTaskFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _taskType;
  String? _persona;
  String? _command;
  String? _status;
  String? _schedule;
  DateTime? _lastRun;
  DateTime? _nextRun;
  String? _configuration;
  String? _result;
  String? _error;

  @override
  void initState() {
    super.initState();
    _taskType = widget.item?.taskType?.toString();
    _persona = widget.item?.persona?.toString();
    _command = widget.item?.command?.toString();
    _status = widget.item?.status?.toString();
    _schedule = widget.item?.schedule?.toString();
    _lastRun = widget.item?.lastRun;
    _nextRun = widget.item?.nextRun;
    _configuration = widget.item?.configuration?.toString();
    _result = widget.item?.result?.toString();
    _error = widget.item?.error?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_taskType?.isNotEmpty == true) 'taskType': _taskType,
        if (_persona?.isNotEmpty == true) 'persona': _persona,
        if (_command?.isNotEmpty == true) 'command': _command,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_schedule?.isNotEmpty == true) 'schedule': _schedule,
        if (_lastRun != null) 'lastRun': _lastRun!.toIso8601String(),
        if (_nextRun != null) 'nextRun': _nextRun!.toIso8601String(),
        if (_configuration?.isNotEmpty == true) 'configuration': _configuration,
        if (_result?.isNotEmpty == true) 'result': _result,
        if (_error?.isNotEmpty == true) 'error': _error,
    };
    final result = widget.item != null
        ? AutomationTask.fromJson({...widget.item!.toJson(), ...data})
        : AutomationTask.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Task Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _taskType?.toString() ?? '',
                onSaved: (v) => _taskType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Persona', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _persona?.toString() ?? '',
                onSaved: (v) => _persona = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Command', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _command?.toString() ?? '',
                onSaved: (v) => _command = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                initialValue: _status?.toString() ?? '',
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Schedule', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _schedule?.toString() ?? '',
                onSaved: (v) => _schedule = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastRun ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastRun = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Run',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastRun != null ? _fmt(_lastRun) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _nextRun ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _nextRun = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Next Run',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_nextRun != null ? _fmt(_nextRun) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Configuration', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _configuration?.toString() ?? '',
                onSaved: (v) => _configuration = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Result', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _result?.toString() ?? '',
                onSaved: (v) => _result = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                initialValue: _error?.toString() ?? '',
                onSaved: (v) => _error = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Automation Task'),
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