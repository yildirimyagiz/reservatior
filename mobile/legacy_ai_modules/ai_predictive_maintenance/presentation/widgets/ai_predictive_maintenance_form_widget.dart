import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiPredictiveMaintenanceFormWidget extends ConsumerStatefulWidget {
  final AiPredictiveMaintenance? item;
  final Function(AiPredictiveMaintenance) onSubmit;
  const AiPredictiveMaintenanceFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiPredictiveMaintenanceFormWidget> createState() =>
      _AiPredictiveMaintenanceFormWidgetState();
}

class _AiPredictiveMaintenanceFormWidgetState
    extends ConsumerState<AiPredictiveMaintenanceFormWidget> {
  String? _propertyId;
  String? _componentType;
  double? _failureProbability;
  DateTime? _predictedFailureDate;
  String? _riskLevel;
  double? _estimatedCost;
  DateTime? _lastInspectionDate;
  String? _recommendedAction;
  DateTime? _generatedAt;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _componentType = widget.item?.componentType;
    _failureProbability = widget.item?.failureProbability;
    _predictedFailureDate = widget.item?.predictedFailureDate;
    _riskLevel = widget.item?.riskLevel;
    _estimatedCost = widget.item?.estimatedCost;
    _lastInspectionDate = widget.item?.lastInspectionDate;
    _recommendedAction = widget.item?.recommendedAction;
    _generatedAt = widget.item?.generatedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aipredictivemaintenance'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aipredictivemaintenance'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _componentType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.componenttype'.tr()),
              onChanged: (v) => _componentType = v,
            ),
            TextFormField(
              initialValue: _failureProbability?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.failureprobability'.tr(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => _failureProbability = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text(
                'predictedFailureDate: ${_predictedFailureDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _predictedFailureDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _predictedFailureDate = d);
              },
            ),
            TextFormField(
              initialValue: _riskLevel?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.risklevel'.tr()),
              onChanged: (v) => _riskLevel = v,
            ),
            TextFormField(
              initialValue: _estimatedCost?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.estimatedcost'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _estimatedCost = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text(
                'lastInspectionDate: ${_lastInspectionDate ?? "Select"}',
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _lastInspectionDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _lastInspectionDate = d);
              },
            ),
            TextFormField(
              initialValue: _recommendedAction?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.recommendedaction'.tr()),
              onChanged: (v) => _recommendedAction = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_generated_at'.tr()}: ${_generatedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _generatedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _generatedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_componentType != null) 'componentType': _componentType,
                  if (_failureProbability != null)
                    'failureProbability': _failureProbability,
                  if (_predictedFailureDate != null)
                    'predictedFailureDate': _predictedFailureDate!
                        .toIso8601String(),
                  if (_riskLevel != null) 'riskLevel': _riskLevel,
                  if (_estimatedCost != null) 'estimatedCost': _estimatedCost,
                  if (_lastInspectionDate != null)
                    'lastInspectionDate': _lastInspectionDate!
                        .toIso8601String(),
                  if (_recommendedAction != null)
                    'recommendedAction': _recommendedAction,
                  if (_generatedAt != null)
                    'generatedAt': _generatedAt!.toIso8601String(),
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
                  widget.onSubmit(AiPredictiveMaintenance.fromJson(json));
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
