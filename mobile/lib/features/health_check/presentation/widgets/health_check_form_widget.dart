import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── HealthCheck Form Widget  |  Fields: serviceName, componentName, status, responseTime, details, errorMessage, checkedAt

class HealthCheckFormWidget extends StatefulWidget {
  final HealthCheck? item;
  final void Function(HealthCheck)? onSubmit;
  const HealthCheckFormWidget({super.key, this.item, this.onSubmit});
  @override State<HealthCheckFormWidget> createState() => _HealthCheckFormWidgetState();
}

class _HealthCheckFormWidgetState extends State<HealthCheckFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _serviceName;
  String? _componentName;
  String? _status;
  int? _responseTime;
  String? _details;
  String? _errorMessage;
  DateTime? _checkedAt;

  @override
  void initState() {
    super.initState();
    _serviceName = widget.item?.serviceName?.toString();
    _componentName = widget.item?.componentName?.toString();
    _status = widget.item?.status?.toString();
    _responseTime = widget.item?.responseTime;
    _details = widget.item?.details?.toString();
    _errorMessage = widget.item?.errorMessage?.toString();
    _checkedAt = widget.item?.checkedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_serviceName?.isNotEmpty == true) 'serviceName': _serviceName,
        if (_componentName?.isNotEmpty == true) 'componentName': _componentName,
        if (_status?.isNotEmpty == true) 'status': _status,
        if (_responseTime != null) 'responseTime': _responseTime,
        if (_details?.isNotEmpty == true) 'details': _details,
        if (_errorMessage?.isNotEmpty == true) 'errorMessage': _errorMessage,
        if (_checkedAt != null) 'checkedAt': _checkedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? HealthCheck.fromJson({...widget.item!.toJson(), ...data})
        : HealthCheck.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Service Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _serviceName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Component Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _componentName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Response Time', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _responseTime = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Details', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _details = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Error Message', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _errorMessage = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _checkedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _checkedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Checked At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_checkedAt != null ? _fmt(_checkedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Health Check'),
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