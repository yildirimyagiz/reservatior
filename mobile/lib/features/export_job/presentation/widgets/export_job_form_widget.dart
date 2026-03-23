import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ExportJob Form Widget  |  Fields: type, status, params, startedAt, finishedAt, error

class ExportJobFormWidget extends StatefulWidget {
  final ExportJob? item;
  final void Function(ExportJob)? onSubmit;
  const ExportJobFormWidget({super.key, this.item, this.onSubmit});
  @override State<ExportJobFormWidget> createState() => _ExportJobFormWidgetState();
}

class _ExportJobFormWidgetState extends State<ExportJobFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _type;
  String? _status;
  String? _params;
  DateTime? _startedAt;
  DateTime? _finishedAt;
  String? _error;

  @override
  void initState() {
    super.initState();
    _type = widget.item?.type?.toString();
    _status = widget.item?.status?.toString();
    _params = widget.item?.params?.toString();
    _startedAt = widget.item?.startedAt;
    _finishedAt = widget.item?.finishedAt;
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
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_params?.isNotEmpty == true) 'params': _params,
        if (_startedAt != null) 'startedAt': _startedAt!.toIso8601String(),
        if (_finishedAt != null) 'finishedAt': _finishedAt!.toIso8601String(),
        if (_error?.isNotEmpty == true) 'error': _error,
    };
    final result = widget.item != null
        ? ExportJob.fromJson({...widget.item!.toJson(), ...data})
        : ExportJob.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Params', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _params = v?.isEmpty == true ? null : v,
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
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Export Job'),
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