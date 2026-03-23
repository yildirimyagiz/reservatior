import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AILeadScore Form Widget  |  Fields: modelId, leadId, score, scoreBreakdown, confidence, scoredAt, featuresUsed, status

class AILeadScoreFormWidget extends StatefulWidget {
  final AILeadScore? item;
  final void Function(AILeadScore)? onSubmit;
  const AILeadScoreFormWidget({super.key, this.item, this.onSubmit});
  @override State<AILeadScoreFormWidget> createState() => _AILeadScoreFormWidgetState();
}

class _AILeadScoreFormWidgetState extends State<AILeadScoreFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _modelId;
  String? _leadId;
  double? _score;
  String? _scoreBreakdown;
  double? _confidence;
  DateTime? _scoredAt;
  String? _featuresUsed;
  String? _status;

  @override
  void initState() {
    super.initState();
    _modelId = widget.item?.modelId?.toString();
    _leadId = widget.item?.leadId?.toString();
    _score = widget.item?.score;
    _scoreBreakdown = widget.item?.scoreBreakdown?.toString();
    _confidence = widget.item?.confidence;
    _scoredAt = widget.item?.scoredAt;
    _featuresUsed = widget.item?.featuresUsed?.toString();
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
        if (_modelId?.isNotEmpty == true) 'modelId': _modelId,
        if (_leadId?.isNotEmpty == true) 'leadId': _leadId,
        if (_score != null) 'score': _score,
        if (_scoreBreakdown?.isNotEmpty == true) 'scoreBreakdown': _scoreBreakdown,
        if (_confidence != null) 'confidence': _confidence,
        if (_scoredAt != null) 'scoredAt': _scoredAt!.toIso8601String(),
        if (_featuresUsed?.isNotEmpty == true) 'featuresUsed': _featuresUsed,
        if (_status?.isNotEmpty == true) 'status': _status,
    };
    final result = widget.item != null
        ? AILeadScore.fromJson({...widget.item!.toJson(), ...data})
        : AILeadScore.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Model Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _modelId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lead Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _leadId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _score = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Score Breakdown', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _scoreBreakdown = v?.isEmpty == true ? null : v,
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
                    context: context, initialDate: _scoredAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _scoredAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Scored At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_scoredAt != null ? _fmt(_scoredAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Features Used', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _featuresUsed = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Status', prefixIcon: Icon(Icons.info_outline), border: OutlineInputBorder()),
                onSaved: (v) => _status = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Lead Score'),
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