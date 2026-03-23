import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── ProjectAnalytics Form Widget  |  Fields: projectId, analysisType, analysisData, score

class ProjectAnalyticsFormWidget extends StatefulWidget {
  final ProjectAnalytics? item;
  final void Function(ProjectAnalytics)? onSubmit;
  const ProjectAnalyticsFormWidget({super.key, this.item, this.onSubmit});
  @override State<ProjectAnalyticsFormWidget> createState() => _ProjectAnalyticsFormWidgetState();
}

class _ProjectAnalyticsFormWidgetState extends State<ProjectAnalyticsFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _projectId;
  String? _analysisType;
  String? _analysisData;
  double? _score;

  @override
  void initState() {
    super.initState();
    _projectId = widget.item?.projectId?.toString();
    _analysisType = widget.item?.analysisType?.toString();
    _analysisData = widget.item?.analysisData?.toString();
    _score = widget.item?.score;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        if (_projectId?.isNotEmpty == true) 'projectId': _projectId,
        if (_analysisType?.isNotEmpty == true) 'analysisType': _analysisType,
        if (_analysisData?.isNotEmpty == true) 'analysisData': _analysisData,
        if (_score != null) 'score': _score,
    };
    final result = widget.item != null
        ? ProjectAnalytics.fromJson({...widget.item!.toJson(), ...data})
        : ProjectAnalytics.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Project Id', prefixIcon: const Icon(Icons.link), border: const OutlineInputBorder()),
                onSaved: (v) => _projectId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Analysis Type', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _analysisType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Analysis Data', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _analysisData = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _score = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Project Analytics'),
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