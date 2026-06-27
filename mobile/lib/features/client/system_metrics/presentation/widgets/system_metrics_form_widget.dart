import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class SystemMetricsFormWidget extends ConsumerStatefulWidget {
  final SystemMetrics? item;
  final Function(SystemMetrics) onSubmit;
  const SystemMetricsFormWidget({super.key, this.item, required this.onSubmit});
  @override
  ConsumerState<SystemMetricsFormWidget> createState() =>
      _SystemMetricsFormWidgetState();
}

class _SystemMetricsFormWidgetState
    extends ConsumerState<SystemMetricsFormWidget> {
  String? _metricType;
  String? _metricName;
  double? _value;
  String? _unit;
  DateTime? _timestamp;
  DateTime? _collectedAt;
  @override
  void initState() {
    super.initState();
    _metricType = widget.item?.metricType;
    _metricName = widget.item?.metricName;
    _value = widget.item?.value;
    _unit = widget.item?.unit;
    _timestamp = widget.item?.timestamp;
    _collectedAt = widget.item?.collectedAt;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.systemmetrics'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.systemmetrics'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _metricType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.metrictype'.tr()),
              onChanged: (v) => _metricType = v,
            ),
            TextFormField(
              initialValue: _metricName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.metricname'.tr()),
              onChanged: (v) => _metricName = v,
            ),
            TextFormField(
              initialValue: _value?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.value'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _value = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _unit?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.unit'.tr()),
              onChanged: (v) => _unit = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_timestamp'.tr()}: ${_timestamp ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _timestamp ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _timestamp = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_collected_at'.tr()}: ${_collectedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _collectedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _collectedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_metricType != null) 'metricType': _metricType,
                  if (_metricName != null) 'metricName': _metricName,
                  if (_value != null) 'value': _value,
                  if (_unit != null) 'unit': _unit,
                  if (_timestamp != null)
                    'timestamp': _timestamp!.toIso8601String(),
                  if (_collectedAt != null)
                    'collectedAt': _collectedAt!.toIso8601String(),
                };
                try {
                  final json = widget.item != null
                      ? {...widget.item!.toJson(), ...data}
                      : {
                          'id': 'new',
                          'createdAt': DateTime.now().toIso8601String(),
                          'updatedAt': DateTime.now().toIso8601String(),
                          ...data,
                        };
                  widget.onSubmit(SystemMetrics.fromJson(json));
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("${'mobile.admin.error_label'.tr()}: $e")));
                }
              },
              child: Text('mobile.auto.save'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
