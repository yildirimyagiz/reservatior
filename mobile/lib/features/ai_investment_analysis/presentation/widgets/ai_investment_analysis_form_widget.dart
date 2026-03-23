import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIInvestmentAnalysis Form Widget  |  Fields: propertyId, analysisType, timeHorizon, projectedReturns, cashFlowProjection, riskMetrics, keyAssumptions, sensitivityAnalysis, confidence, generatedAt

class AIInvestmentAnalysisFormWidget extends StatefulWidget {
  final AIInvestmentAnalysis? item;
  final void Function(AIInvestmentAnalysis)? onSubmit;
  const AIInvestmentAnalysisFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIInvestmentAnalysisFormWidget> createState() => _AIInvestmentAnalysisFormWidgetState();
}

class _AIInvestmentAnalysisFormWidgetState extends State<AIInvestmentAnalysisFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _analysisType;
  String? _timeHorizon;
  String? _projectedReturns;
  String? _cashFlowProjection;
  String? _riskMetrics;
  String? _keyAssumptions;
  String? _sensitivityAnalysis;
  double? _confidence;
  DateTime? _generatedAt;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _analysisType = widget.item?.analysisType?.toString();
    _timeHorizon = widget.item?.timeHorizon?.toString();
    _projectedReturns = widget.item?.projectedReturns?.toString();
    _cashFlowProjection = widget.item?.cashFlowProjection?.toString();
    _riskMetrics = widget.item?.riskMetrics?.toString();
    _keyAssumptions = widget.item?.keyAssumptions?.toString();
    _sensitivityAnalysis = widget.item?.sensitivityAnalysis?.toString();
    _confidence = widget.item?.confidence;
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
        if (_analysisType?.isNotEmpty == true) 'analysisType': _analysisType,
        if (_timeHorizon?.isNotEmpty == true) 'timeHorizon': _timeHorizon,
        if (_projectedReturns?.isNotEmpty == true) 'projectedReturns': _projectedReturns,
        if (_cashFlowProjection?.isNotEmpty == true) 'cashFlowProjection': _cashFlowProjection,
        if (_riskMetrics?.isNotEmpty == true) 'riskMetrics': _riskMetrics,
        if (_keyAssumptions?.isNotEmpty == true) 'keyAssumptions': _keyAssumptions,
        if (_sensitivityAnalysis?.isNotEmpty == true) 'sensitivityAnalysis': _sensitivityAnalysis,
        if (_confidence != null) 'confidence': _confidence,
        if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? AIInvestmentAnalysis.fromJson({...widget.item!.toJson(), ...data})
        : AIInvestmentAnalysis.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Analysis Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _analysisType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Time Horizon', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _timeHorizon = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Projected Returns', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _projectedReturns = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cash Flow Projection', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _cashFlowProjection = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Risk Metrics', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _riskMetrics = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Key Assumptions', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _keyAssumptions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Sensitivity Analysis', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _sensitivityAnalysis = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _confidence = double.tryParse(v ?? ''),
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
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Investment Analysis'),
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