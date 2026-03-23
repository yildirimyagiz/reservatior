import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIPropertyDescription Form Widget  |  Fields: propertyId, generatedDescription, originalDescription, tone, targetAudience, keyFeatures, seoKeywords, qualityScore, generatedAt, isApproved, approvedBy, approvedAt

class AIPropertyDescriptionFormWidget extends StatefulWidget {
  final AIPropertyDescription? item;
  final void Function(AIPropertyDescription)? onSubmit;
  const AIPropertyDescriptionFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIPropertyDescriptionFormWidget> createState() => _AIPropertyDescriptionFormWidgetState();
}

class _AIPropertyDescriptionFormWidgetState extends State<AIPropertyDescriptionFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _generatedDescription;
  String? _originalDescription;
  String? _tone;
  String? _targetAudience;
  String? _keyFeatures;
  String? _seoKeywords;
  double? _qualityScore;
  DateTime? _generatedAt;
  bool _isApproved = false;
  String? _approvedBy;
  DateTime? _approvedAt;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _generatedDescription = widget.item?.generatedDescription?.toString();
    _originalDescription = widget.item?.originalDescription?.toString();
    _tone = widget.item?.tone?.toString();
    _targetAudience = widget.item?.targetAudience?.toString();
    _keyFeatures = widget.item?.keyFeatures?.toString();
    _seoKeywords = widget.item?.seoKeywords?.toString();
    _qualityScore = widget.item?.qualityScore;
    _generatedAt = widget.item?.generatedAt;
    _isApproved = widget.item?.isApproved ?? false;
    _approvedBy = widget.item?.approvedBy?.toString();
    _approvedAt = widget.item?.approvedAt;
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
        if (_generatedDescription?.isNotEmpty == true) 'generatedDescription': _generatedDescription,
        if (_originalDescription?.isNotEmpty == true) 'originalDescription': _originalDescription,
        if (_tone?.isNotEmpty == true) 'tone': _tone,
        if (_targetAudience?.isNotEmpty == true) 'targetAudience': _targetAudience,
        if (_keyFeatures?.isNotEmpty == true) 'keyFeatures': _keyFeatures,
        if (_seoKeywords?.isNotEmpty == true) 'seoKeywords': _seoKeywords,
        if (_qualityScore != null) 'qualityScore': _qualityScore,
        if (_generatedAt != null) 'generatedAt': _generatedAt!.toIso8601String(),
        'isApproved': _isApproved,
        if (_approvedBy?.isNotEmpty == true) 'approvedBy': _approvedBy,
        if (_approvedAt != null) 'approvedAt': _approvedAt!.toIso8601String(),
    };
    final result = widget.item != null
        ? AIPropertyDescription.fromJson({...widget.item!.toJson(), ...data})
        : AIPropertyDescription.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Generated Description', prefixIcon: Icon(Icons.attach_money), border: OutlineInputBorder()),
                onSaved: (v) => _generatedDescription = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Original Description', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
                onSaved: (v) => _originalDescription = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tone', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _tone = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Target Audience', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _targetAudience = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Key Features', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _keyFeatures = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Seo Keywords', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _seoKeywords = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quality Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _qualityScore = double.tryParse(v ?? ''),
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
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Is Approved'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _isApproved,
                  onChanged: (v) { ss(() {}); setState(() => _isApproved = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Approved By', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _approvedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _approvedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _approvedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Approved At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_approvedAt != null ? _fmt(_approvedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Property Description'),
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