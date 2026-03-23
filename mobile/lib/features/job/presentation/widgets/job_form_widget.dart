import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── Job Form Widget  |  Fields: type, payload, status, runAt, attempts, lastError, lockedAt, lockedBy

class JobFormWidget extends StatefulWidget {
  final Job? item;
  final void Function(Job)? onSubmit;
  const JobFormWidget({super.key, this.item, this.onSubmit});
  @override State<JobFormWidget> createState() => _JobFormWidgetState();
}

class _JobFormWidgetState extends State<JobFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _type;
  String? _payload;
  String? _status;
  DateTime? _runAt;
  int? _attempts;
  String? _lastError;
  DateTime? _lockedAt;
  String? _lockedBy;

  @override
  void initState() {
    super.initState();
    _type = widget.item?.type?.toString();
    _payload = widget.item?.payload?.toString();
    _status = widget.item?.status?.toString();
    _runAt = widget.item?.runAt;
    _attempts = widget.item?.attempts;
    _lastError = widget.item?.lastError?.toString();
    _lockedAt = widget.item?.lockedAt;
    _lockedBy = widget.item?.lockedBy?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_payload?.isNotEmpty == true) 'payload': _payload,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_runAt != null) 'runAt': _runAt!.toIso8601String(),
        if (_attempts != null) 'attempts': _attempts,
        if (_lastError?.isNotEmpty == true) 'lastError': _lastError,
        if (_lockedAt != null) 'lockedAt': _lockedAt!.toIso8601String(),
        if (_lockedBy?.isNotEmpty == true) 'lockedBy': _lockedBy,
    };
    final result = widget.item != null
        ? Job.fromJson({...widget.item!.toJson(), ...data})
        : Job.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payload', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _payload = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _runAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _runAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Run At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_runAt != null ? _fmt(_runAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Attempts', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _attempts = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _lastError = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lockedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lockedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Locked At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lockedAt != null ? _fmt(_lockedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Locked By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _lockedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Job'),
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