import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── SystemMetrics Form Widget  |  Fields: metricType, metricName, value, unit, timestamp, dimensions, tags, collectedAt

class SystemMetricsFormWidget extends StatefulWidget {
  final SystemMetrics? item;
  final void Function(SystemMetrics)? onSubmit;
  const SystemMetricsFormWidget({super.key, this.item, this.onSubmit});
  @override State<SystemMetricsFormWidget> createState() => _SystemMetricsFormWidgetState();
}

class _SystemMetricsFormWidgetState extends State<SystemMetricsFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _metricType;
  String? _metricName;
  double? _value;
  String? _unit;
  DateTime? _timestamp;
  String? _dimensions;
  String? _tags;
  DateTime? _collectedAt;

  @override
  void initState() {
    super.initState();
    _metricType = widget.item?.metricType?.toString();
    _metricName = widget.item?.metricName?.toString();
    _value = widget.item?.value;
    _unit = widget.item?.unit?.toString();
    _timestamp = widget.item?.timestamp;
    _dimensions = widget.item?.dimensions?.toString();
    _tags = widget.item?.tags?.toString();
    _collectedAt = widget.item?.collectedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_metricType?.isNotEmpty == true) 'metricType': _metricType,
        if (_metricName?.isNotEmpty == true) 'metricName': _metricName,
        if (_value != null) 'value': _value,
        if (_unit?.isNotEmpty == true) 'unit': _unit,
        if (_timestamp != null) 'timestamp': _timestamp!.toIso8601String(),
        if (_dimensions?.isNotEmpty == true) 'dimensions': _dimensions,
        if (_tags?.isNotEmpty == true) 'tags': _tags,
        if (_collectedAt != null) 'collectedAt': _collectedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? SystemMetrics.fromJson({...widget.item!.toJson(), ...data})
        : SystemMetrics.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Metric Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _metricType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Metric Name', prefixIcon: const Icon(Icons.person), border: const OutlineInputBorder()),
                onSaved: (v) => _metricName = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Value', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _value = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Unit', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _unit = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _timestamp ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _timestamp = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Timestamp',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_timestamp != null ? _fmt(_timestamp) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Dimensions', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _dimensions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tags', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _tags = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _collectedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _collectedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Collected At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_collectedAt != null ? _fmt(_collectedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create System Metrics'),
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