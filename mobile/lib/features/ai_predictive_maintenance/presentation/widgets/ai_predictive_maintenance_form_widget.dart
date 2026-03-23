import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIPredictiveMaintenance Form Widget  |  Fields: propertyId, componentType, failureProbability, predictedFailureDate, riskLevel, estimatedCost, contributingFactors, lastInspectionDate, recommendedAction, generatedAt

class AIPredictiveMaintenanceFormWidget extends StatefulWidget {
  final AIPredictiveMaintenance? item;
  final void Function(AIPredictiveMaintenance)? onSubmit;
  const AIPredictiveMaintenanceFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIPredictiveMaintenanceFormWidget> createState() => _AIPredictiveMaintenanceFormWidgetState();
}

class _AIPredictiveMaintenanceFormWidgetState extends State<AIPredictiveMaintenanceFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _componentType;
  double? _failureProbability;
  DateTime? _predictedFailureDate;
  String? _riskLevel;
  double? _estimatedCost;
  String? _contributingFactors;
  DateTime? _lastInspectionDate;
  String? _recommendedAction;
  DateTime? _generatedAt;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _componentType = widget.item?.componentType?.toString();
    _failureProbability = widget.item?.failureProbability;
    _predictedFailureDate = widget.item?.predictedFailureDate;
    _riskLevel = widget.item?.riskLevel?.toString();
    _estimatedCost = widget.item?.estimatedCost;
    _contributingFactors = widget.item?.contributingFactors?.toString();
    _lastInspectionDate = widget.item?.lastInspectionDate;
    _recommendedAction = widget.item?.recommendedAction?.toString();
    _generatedAt = widget.item?.generatedAt;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_propertyId?.isNotEmpty == true) 'propertyId': _propertyId,
        if (_componentType?.isNotEmpty == true) 'componentType': _componentType,
        if (_failureProbability != null) 'failureProbability': _failureProbability,
        if (_predictedFailureDate != null) 'predictedFailureDate': _predictedFailureDate!.toIso8601String(),
        if (_riskLevel?.isNotEmpty == true) 'riskLevel': _riskLevel,
        if (_estimatedCost != null) 'estimatedCost': _estimatedCost,
        if (_contributingFactors?.isNotEmpty == true) 'contributingFactors': _contributingFactors,
        if (_lastInspectionDate != null) 'lastInspectionDate': _lastInspectionDate!.toIso8601String(),
        if (_recommendedAction?.isNotEmpty == true) 'recommendedAction': _recommendedAction,
        if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? AIPredictiveMaintenance.fromJson({...widget.item!.toJson(), ...data})
        : AIPredictiveMaintenance.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Property Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _propertyId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Component Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _componentType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Failure Probability', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _failureProbability = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _predictedFailureDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _predictedFailureDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Predicted Failure Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_predictedFailureDate != null ? _fmt(_predictedFailureDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Risk Level', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _riskLevel = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Estimated Cost', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _estimatedCost = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contributing Factors', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _contributingFactors = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _lastInspectionDate ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _lastInspectionDate = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Last Inspection Date',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_lastInspectionDate != null ? _fmt(_lastInspectionDate) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Recommended Action', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _recommendedAction = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _generatedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _generatedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Generated At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_generatedAt != null ? _fmt(_generatedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Predictive Maintenance'),
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