import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIFraudDetection Form Widget  |  Fields: entityType, entityId, riskScore, riskFactors, riskCategory, recommendedActions, detectedAt, reviewedAt, reviewedBy, resolution

class AIFraudDetectionFormWidget extends StatefulWidget {
  final AIFraudDetection? item;
  final void Function(AIFraudDetection)? onSubmit;
  const AIFraudDetectionFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIFraudDetectionFormWidget> createState() => _AIFraudDetectionFormWidgetState();
}

class _AIFraudDetectionFormWidgetState extends State<AIFraudDetectionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _entityType;
  String? _entityId;
  double? _riskScore;
  String? _riskFactors;
  String? _riskCategory;
  String? _recommendedActions;
  DateTime? _detectedAt;
  DateTime? _reviewedAt;
  String? _reviewedBy;
  String? _resolution;

  @override
  void initState() {
    super.initState();
    _entityType = widget.item?.entityType?.toString();
    _entityId = widget.item?.entityId?.toString();
    _riskScore = widget.item?.riskScore;
    _riskFactors = widget.item?.riskFactors?.toString();
    _riskCategory = widget.item?.riskCategory?.toString();
    _recommendedActions = widget.item?.recommendedActions?.toString();
    _detectedAt = widget.item?.detectedAt;
    _reviewedAt = widget.item?.reviewedAt;
    _reviewedBy = widget.item?.reviewedBy?.toString();
    _resolution = widget.item?.resolution?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_entityType?.isNotEmpty == true) 'entityType': _entityType,
        if (_entityId?.isNotEmpty == true) 'entityId': _entityId,
        if (_riskScore != null) 'riskScore': _riskScore,
        if (_riskFactors?.isNotEmpty == true) 'riskFactors': _riskFactors,
        if (_riskCategory?.isNotEmpty == true) 'riskCategory': _riskCategory,
        if (_recommendedActions?.isNotEmpty == true) 'recommendedActions': _recommendedActions,
        if (_detectedAt != null) 'detectedAt': _detectedAt!.toIso8601String(),
        if (_reviewedAt != null) 'reviewedAt': _reviewedAt!.toIso8601String(),
        if (_reviewedBy?.isNotEmpty == true) 'reviewedBy': _reviewedBy,
        if (_resolution?.isNotEmpty == true) 'resolution': _resolution,
    };
    final result = widget.item != null
        ? AIFraudDetection.fromJson({...widget.item!.toJson(), ...data})
        : AIFraudDetection.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Entity Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _entityType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Entity Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _entityId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Risk Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _riskScore = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Risk Factors', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _riskFactors = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Risk Category', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _riskCategory = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Recommended Actions', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _recommendedActions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _detectedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _detectedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Detected At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_detectedAt != null ? _fmt(_detectedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _reviewedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _reviewedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Reviewed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_reviewedAt != null ? _fmt(_reviewedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reviewed By', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _reviewedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Resolution', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _resolution = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Fraud Detection'),
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