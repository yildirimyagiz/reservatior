import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ReportExecution Form Widget  |  Fields: reportId, executedAt, executedBy, status, resultUrl, errorMessage, parameters

class ReportExecutionFormWidget extends StatefulWidget {
  final ReportExecution? item;
  final void Function(ReportExecution)? onSubmit;
  const ReportExecutionFormWidget({super.key, this.item, this.onSubmit});
  @override State<ReportExecutionFormWidget> createState() => _ReportExecutionFormWidgetState();
}

class _ReportExecutionFormWidgetState extends State<ReportExecutionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _reportId;
  DateTime? _executedAt;
  String? _executedBy;
  String? _status;
  String? _resultUrl;
  String? _errorMessage;
  String? _parameters;

  @override
  void initState() {
    super.initState();
    _reportId = widget.item?.reportId?.toString();
    _executedAt = widget.item?.executedAt;
    _executedBy = widget.item?.executedBy?.toString();
    _status = widget.item?.status?.toString();
    _resultUrl = widget.item?.resultUrl?.toString();
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
        if (_reportId?.isNotEmpty == true) 'reportId': _reportId,
        if (_executedAt != null) 'executedAt': _executedAt!.toIso8601String(),
        if (_executedBy?.isNotEmpty == true) 'executedBy': _executedBy,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_resultUrl?.isNotEmpty == true) 'resultUrl': _resultUrl,
        if (_errorMessage?.isNotEmpty == true) 'errorMessage': _errorMessage,
        if (_parameters?.isNotEmpty == true) 'parameters': _parameters,
    };
    final result = widget.item != null
        ? ReportExecution.fromJson({...widget.item!.toJson(), ...data})
        : ReportExecution.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Report Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _reportId = v?.isEmpty == true ? null : v,
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
                decoration: InputDecoration(labelText: 'Executed By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _executedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Result Url', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _resultUrl = v?.isEmpty == true ? null : v,
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create Report Execution'),
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