import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AnalysisJob Form Widget  |  Fields: documentId, status, type, priority, startedAt, completedAt, processingTime, errorMessage, parameters

class AnalysisJobFormWidget extends StatefulWidget {
  final AnalysisJob? item;
  final void Function(AnalysisJob)? onSubmit;
  const AnalysisJobFormWidget({super.key, this.item, this.onSubmit});
  @override State<AnalysisJobFormWidget> createState() => _AnalysisJobFormWidgetState();
}

class _AnalysisJobFormWidgetState extends State<AnalysisJobFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _documentId;
  String? _status;
  String? _type;
  String? _priority;
  DateTime? _startedAt;
  DateTime? _completedAt;
  int? _processingTime;
  String? _errorMessage;
  String? _parameters;

  @override
  void initState() {
    super.initState();
    _documentId = widget.item?.documentId?.toString();
    _status = widget.item?.status?.toString();
    _type = widget.item?.type?.toString();
    _priority = widget.item?.priority?.toString();
    _startedAt = widget.item?.startedAt;
    _completedAt = widget.item?.completedAt;
    _processingTime = widget.item?.processingTime;
    _errorMessage = widget.item?.errorMessage?.toString();
    _parameters = widget.item?.parameters?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_documentId?.isNotEmpty == true) 'documentId': _documentId,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_type?.isNotEmpty == true) 'type': _type,
        if (_priority?.isNotEmpty == true) 'priority': _priority,
        if (_startedAt != null) 'startedAt': _startedAt!.toIso8601String(),
        if (_completedAt != null) 'completedAt': _completedAt!.toIso8601String(),
        if (_processingTime != null) 'processingTime': _processingTime,
        if (_errorMessage?.isNotEmpty == true) 'errorMessage': _errorMessage,
        if (_parameters?.isNotEmpty == true) 'parameters': _parameters,
    };
    final result = widget.item != null
        ? AnalysisJob.fromJson({...widget.item!.toJson(), ...data})
        : AnalysisJob.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Document Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _documentId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _type = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Priority', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _priority = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _completedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _completedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Completed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_completedAt != null ? _fmt(_completedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Processing Time', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _processingTime = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Error Message', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _errorMessage = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Parameters', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _parameters = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Analysis Job'),
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