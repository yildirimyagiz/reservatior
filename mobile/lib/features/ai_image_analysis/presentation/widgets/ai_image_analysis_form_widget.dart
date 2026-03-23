import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── AIImageAnalysis Form Widget  |  Fields: propertyId, photoId, analysisType, detectedRooms, qualityScore, styleTags, colorPalette, lightingQuality, recommendations, analyzedAt, confidence

class AIImageAnalysisFormWidget extends StatefulWidget {
  final AIImageAnalysis? item;
  final void Function(AIImageAnalysis)? onSubmit;
  const AIImageAnalysisFormWidget({super.key, this.item, this.onSubmit});
  @override State<AIImageAnalysisFormWidget> createState() => _AIImageAnalysisFormWidgetState();
}

class _AIImageAnalysisFormWidgetState extends State<AIImageAnalysisFormWidget> {
  final _key = GlobalKey<FormState>();
  String? _propertyId;
  String? _photoId;
  String? _analysisType;
  String? _detectedRooms;
  double? _qualityScore;
  String? _styleTags;
  String? _colorPalette;
  double? _lightingQuality;
  String? _recommendations;
  DateTime? _analyzedAt;
  double? _confidence;

  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId?.toString();
    _photoId = widget.item?.photoId?.toString();
    _analysisType = widget.item?.analysisType?.toString();
    _detectedRooms = widget.item?.detectedRooms?.toString();
    _qualityScore = widget.item?.qualityScore;
    _styleTags = widget.item?.styleTags?.toString();
    _colorPalette = widget.item?.colorPalette?.toString();
    _lightingQuality = widget.item?.lightingQuality;
    _recommendations = widget.item?.recommendations?.toString();
    _analyzedAt = widget.item?.analyzedAt;
    _confidence = widget.item?.confidence;
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
        if (_photoId?.isNotEmpty == true) 'photoId': _photoId,
        if (_analysisType?.isNotEmpty == true) 'analysisType': _analysisType,
        if (_detectedRooms?.isNotEmpty == true) 'detectedRooms': _detectedRooms,
        if (_qualityScore != null) 'qualityScore': _qualityScore,
        if (_styleTags?.isNotEmpty == true) 'styleTags': _styleTags,
        if (_colorPalette?.isNotEmpty == true) 'colorPalette': _colorPalette,
        if (_lightingQuality != null) 'lightingQuality': _lightingQuality,
        if (_recommendations?.isNotEmpty == true) 'recommendations': _recommendations,
        if (_analyzedAt != null) 'analyzedAt': _analyzedAt!.toIso8601String(),
        if (_confidence != null) 'confidence': _confidence,
    };
    final result = widget.item != null
        ? AIImageAnalysis.fromJson({...widget.item!.toJson(), ...data})
        : AIImageAnalysis.fromJson(data);
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
                decoration: InputDecoration(labelText: 'Photo Id', prefixIcon: Icon(Icons.link), border: OutlineInputBorder()),
                onSaved: (v) => _photoId = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Analysis Type', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _analysisType = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Detected Rooms', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _detectedRooms = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quality Score', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _qualityScore = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Style Tags', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _styleTags = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Color Palette', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _colorPalette = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Lighting Quality', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _lightingQuality = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Recommendations', prefixIcon: Icon(Icons.text_fields), border: OutlineInputBorder()),
                onSaved: (v) => _recommendations = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context, initialDate: _analyzedAt ?? DateTime.now(),
                    firstDate: DateTime(2000), lastDate: DateTime(2100),
                  );
                  if (d != null) setState(() => _analyzedAt = d);
                },
                child: InputDecorator(
                  decoration: const InputDecoration(labelText: 'Analyzed At',
                    prefixIcon: Icon(Icons.calendar_today), border: OutlineInputBorder()),
                  child: Text(_analyzedAt != null ? _fmt(_analyzedAt) : 'Tap to select date'),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confidence', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _confidence = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create Ai Image Analysis'),
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