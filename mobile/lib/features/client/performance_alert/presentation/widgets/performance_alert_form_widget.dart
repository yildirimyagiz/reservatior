import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class PerformanceAlertFormWidget extends ConsumerStatefulWidget {
  final PerformanceAlert? item;
  final Function(PerformanceAlert) onSubmit;
  const PerformanceAlertFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<PerformanceAlertFormWidget> createState() =>
      _PerformanceAlertFormWidgetState();
}

class _PerformanceAlertFormWidgetState
    extends ConsumerState<PerformanceAlertFormWidget> {
  String? _alertType;
  String? _severity;
  String? _metricName;
  double? _threshold;
  double? _actualValue;
  String? _description;
  String? _status;
  DateTime? _acknowledgedAt;
  String? _acknowledgedBy;
  DateTime? _resolvedAt;
  @override
  void initState() {
    super.initState();
    _alertType = widget.item?.alertType;
    _severity = widget.item?.severity;
    _metricName = widget.item?.metricName;
    _threshold = widget.item?.threshold;
    _actualValue = widget.item?.actualValue;
    _description = widget.item?.description;
    _status = widget.item?.status;
    _acknowledgedAt = widget.item?.acknowledgedAt;
    _acknowledgedBy = widget.item?.acknowledgedBy;
    _resolvedAt = widget.item?.resolvedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.performancealert'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.performancealert'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _alertType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.alerttype'.tr()),
              onChanged: (v) => _alertType = v,
            ),
            TextFormField(
              initialValue: _severity?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.severity'.tr()),
              onChanged: (v) => _severity = v,
            ),
            TextFormField(
              initialValue: _metricName?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.metricname'.tr()),
              onChanged: (v) => _metricName = v,
            ),
            TextFormField(
              initialValue: _threshold?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.threshold'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _threshold = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _actualValue?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.actualvalue'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _actualValue = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _description?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.description'.tr()),
              onChanged: (v) => _description = v,
            ),
            TextFormField(
              initialValue: _status?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.status'.tr()),
              onChanged: (v) => _status = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_acknowledged_at'.tr()}: ${_acknowledgedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _acknowledgedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _acknowledgedAt = d);
              },
            ),
            TextFormField(
              initialValue: _acknowledgedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.acknowledgedby'.tr()),
              onChanged: (v) => _acknowledgedBy = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_resolved_at'.tr()}: ${_resolvedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _resolvedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _resolvedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_alertType != null) 'alertType': _alertType,
                  if (_severity != null) 'severity': _severity,
                  if (_metricName != null) 'metricName': _metricName,
                  if (_threshold != null) 'threshold': _threshold,
                  if (_actualValue != null) 'actualValue': _actualValue,
                  if (_description != null) 'description': _description,
                  if (_status != null) 'status': _status,
                  if (_acknowledgedAt != null)
                    'acknowledgedAt': _acknowledgedAt!.toIso8601String(),
                  if (_acknowledgedBy != null)
                    'acknowledgedBy': _acknowledgedBy,
                  if (_resolvedAt != null)
                    'resolvedAt': _resolvedAt!.toIso8601String(),
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
                  widget.onSubmit(PerformanceAlert.fromJson(json));
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
