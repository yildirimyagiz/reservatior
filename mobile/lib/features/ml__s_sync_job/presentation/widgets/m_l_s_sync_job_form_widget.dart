import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MLSSyncJob Form Widget  |  Fields: connectionId, status, startedAt, finishedAt, error, stats

class MLSSyncJobFormWidget extends StatefulWidget {
  final MLSSyncJob? item;
  final void Function(MLSSyncJob)? onSubmit;
  const MLSSyncJobFormWidget({super.key, this.item, this.onSubmit});
  @override State<MLSSyncJobFormWidget> createState() => _MLSSyncJobFormWidgetState();
}

class _MLSSyncJobFormWidgetState extends State<MLSSyncJobFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _connectionId;
  String? _status;
  DateTime? _startedAt;
  DateTime? _finishedAt;
  String? _error;
  String? _stats;

  @override
  void initState() {
    super.initState();
    _connectionId = widget.item?.connectionId?.toString();
    _status = widget.item?.status?.toString();
    _startedAt = widget.item?.startedAt;
    _finishedAt = widget.item?.finishedAt;
    _error = widget.item?.error?.toString();
    _stats = widget.item?.stats?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_connectionId?.isNotEmpty == true) 'connectionId': _connectionId,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_startedAt != null) 'startedAt': _startedAt!.toIso8601String(),
        if (_finishedAt != null) 'finishedAt': _finishedAt!.toIso8601String(),
        if (_error?.isNotEmpty == true) 'error': _error,
        if (_stats?.isNotEmpty == true) 'stats': _stats,
    };
    final result = widget.item != null
        ? MLSSyncJob.fromJson({...widget.item!.toJson(), ...data})
        : MLSSyncJob.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Connection Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _connectionId = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _startedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _startedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Started At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_startedAt != null ? _fmt(_startedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _finishedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _finishedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Finished At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_finishedAt != null ? _fmt(_finishedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Error', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _error = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Stats', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _stats = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create M L S Sync Job'),
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