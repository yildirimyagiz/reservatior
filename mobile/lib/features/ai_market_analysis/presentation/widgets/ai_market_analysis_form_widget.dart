import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIMarketAnalysis Form Widget  |  Fields: analysisType, location, analysisPeriod, dataPoints, predictions, insights, confidence, generatedAt, status

class AIMarketAnalysisFormWidget extends StatefulWidget {
  final AIMarketAnalysis? item;
  final void Function(AIMarketAnalysis)? onSubmit;
  const AIMarketAnalysisFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIMarketAnalysisFormWidget> createState() => _AIMarketAnalysisFormWidgetState();
}

class _AIMarketAnalysisFormWidgetState extends State<AIMarketAnalysisFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _analysisType;
  String? _location;
  String? _analysisPeriod;
  String? _dataPoints;
  String? _predictions;
  String? _insights;
  double? _confidence;
  DateTime? _generatedAt;
  String? _status;

  @override
  void initState() {
    super.initState();
    _analysisType = widget.item?.analysisType?.toString();
    _location = widget.item?.location?.toString();
    _analysisPeriod = widget.item?.analysisPeriod?.toString();
    _dataPoints = widget.item?.dataPoints?.toString();
    _predictions = widget.item?.predictions?.toString();
    _insights = widget.item?.insights?.toString();
    _confidence = widget.item?.confidence;
    _generatedAt = widget.item?.generatedAt;
    _status = widget.item?.status?.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_analysisType?.isNotEmpty == true) 'analysisType': _analysisType,
        if (_location?.isNotEmpty == true) 'location': _location,
        if (_analysisPeriod?.isNotEmpty == true) 'analysisPeriod': _analysisPeriod,
        if (_dataPoints?.isNotEmpty == true) 'dataPoints': _dataPoints,
        if (_predictions?.isNotEmpty == true) 'predictions': _predictions,
        if (_insights?.isNotEmpty == true) 'insights': _insights,
        if (_confidence != null) 'confidence': _confidence,
        if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
        if (_status?.isNotEmpty == true) 'status': _status,
    };
    final result = widget.item != null
        ? AIMarketAnalysis.fromJson({...widget.item!.toJson(), ...data})
        : AIMarketAnalysis.fromJson(data);
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
                decoration: InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                  labelText: 'Analysis Type', 
                  prefixIcon: Icon(Icons.text_fields), 
                  border: OutlineInputBorder()
                ),
                onSaved: (v) => _analysisType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location', 
                  prefixIcon: Icon(Icons.location_on), 
                  border: OutlineInputBorder()
                decoration: const InputDecoration(
                  labelText: 'Generated At',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                onSaved: (v) => _location = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                decoration: const InputDecoration(
                  labelText: 'Analysis Period', 
                  prefixIcon: Icon(Icons.text_fields), 
                  border: OutlineInputBorder()
                ),
                onSaved: (v) => _analysisPeriod = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Data Points', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _dataPoints = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Predictions', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                decoration: const InputDecoration(
                  labelText: 'Predictions', 
                  prefixIcon: Icon(Icons.text_fields), 
                  border: OutlineInputBorder()
                ),
                onSaved: (v) => _predictions = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Insights', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                decoration: const InputDecoration(
                  labelText: 'Insights', 
                  prefixIcon: Icon(Icons.text_fields), 
                  border: OutlineInputBorder()
                ),
                onSaved: (v) => _insights = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confidence', 
                  prefixIcon: Icon(Icons.numbers), 
                  border: OutlineInputBorder()
                ),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: const Icon(Icons.info_outline), border: const OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Market Analysis'),
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