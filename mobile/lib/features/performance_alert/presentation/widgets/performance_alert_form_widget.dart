import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── PerformanceAlert Form Widget  |  Fields: alertType, severity, metricName, threshold, actualValue, description, affectedServices, status, acknowledgedAt, acknowledgedBy, resolvedAt

class PerformanceAlertFormWidget extends StatefulWidget {
  final PerformanceAlert? item;
  final void Function(PerformanceAlert)? onSubmit;
  const PerformanceAlertFormWidget({super.key, this.item, this.onSubmit});
  @override State<PerformanceAlertFormWidget> createState() => _PerformanceAlertFormWidgetState();
}

class _PerformanceAlertFormWidgetState extends State<PerformanceAlertFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _alertType;
  String? _severity;
  String? _metricName;
  double? _threshold;
  double? _actualValue;
  String? _description;
  String? _affectedServices;
  String? _status;
  DateTime? _acknowledgedAt;
  String? _acknowledgedBy;
  DateTime? _resolvedAt;

  @override
  void initState() {
    super.initState();
    _alertType = widget.item?.alertType?.toString();
    _severity = widget.item?.severity?.toString();
    _metricName = widget.item?.metricName?.toString();
    _threshold = widget.item?.threshold;
    _actualValue = widget.item?.actualValue;
    _description = widget.item?.description?.toString();
    _affectedServices = widget.item?.affectedServices?.toString();
    _status = widget.item?.status?.toString();
    _acknowledgedAt = widget.item?.acknowledgedAt;
    _acknowledgedBy = widget.item?.acknowledgedBy?.toString();
    _resolvedAt = widget.item?.resolvedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_alertType?.isNotEmpty == true) 'alertType': _alertType,
        if (_severity?.isNotEmpty == true) 'severity': _severity,
        if (_metricName?.isNotEmpty == true) 'metricName': _metricName,
        if (_threshold != null) 'threshold': _threshold,
        if (_actualValue != null) 'actualValue': _actualValue,
        if (_description?.isNotEmpty == true) 'description': _description,
        if (_affectedServices?.isNotEmpty == true) 'affectedServices': _affectedServices,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_acknowledgedAt != null) 'acknowledgedAt': _acknowledgedAt!.toIso8601String(),
        if (_acknowledgedBy?.isNotEmpty == true) 'acknowledgedBy': _acknowledgedBy,
        if (_resolvedAt != null) 'resolvedAt': _resolvedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? PerformanceAlert.fromJson({...widget.item!.toJson(), ...data})
        : PerformanceAlert.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Alert Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _alertType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Severity', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _severity = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Metric Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _metricName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Threshold', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _threshold = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Actual Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _actualValue = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description', prefixIcon: const Icon(Icons.notes), border: const OutlineInputBorder()),
                onSaved: (v) => _description = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Affected Services', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _affectedServices = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _acknowledgedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _acknowledgedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Acknowledged At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_acknowledgedAt != null ? _fmt(_acknowledgedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Acknowledged By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _acknowledgedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _resolvedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _resolvedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Resolved At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_resolvedAt != null ? _fmt(_resolvedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Performance Alert'),
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