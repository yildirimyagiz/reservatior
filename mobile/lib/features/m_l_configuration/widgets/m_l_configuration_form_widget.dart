import 'package:flutter/material.dart';
import '../../../../gen_models/models_library.dart';

// ── MLConfiguration Form Widget  |  Fields: enableAutoTagging, qualityThreshold, enableMLFeatures, maxTagsPerImage, analysisMode, customSettings, updatedBy, version

class MLConfigurationFormWidget extends StatefulWidget {
  final MLConfiguration? item;
  final void Function(MLConfiguration)? onSubmit;
  const MLConfigurationFormWidget({super.key, this.item, this.onSubmit});
  @override State<MLConfigurationFormWidget> createState() => _MLConfigurationFormWidgetState();
}

class _MLConfigurationFormWidgetState extends State<MLConfigurationFormWidget> {
  final _key = GlobalKey<FormState>();
  bool _enableAutoTagging = false;
  double? _qualityThreshold;
  bool _enableMLFeatures = false;
  int? _maxTagsPerImage;
  String? _analysisMode;
  String? _customSettings;
  String? _updatedBy;
  int? _version;

  @override
  void initState() {
    super.initState();
    _enableAutoTagging = widget.item?.enableAutoTagging ?? false;
    _qualityThreshold = widget.item?.qualityThreshold;
    _enableMLFeatures = widget.item?.enableMLFeatures ?? false;
    _maxTagsPerImage = widget.item?.maxTagsPerImage;
    _analysisMode = widget.item?.analysisMode?.toString();
    _customSettings = widget.item?.customSettings?.toString();
    _updatedBy = widget.item?.updatedBy?.toString();
    _version = widget.item?.version;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    if (!_key.currentState!.validate()) return;
    _key.currentState!.save();
    final data = <String, dynamic>{
        'enableAutoTagging': _enableAutoTagging,
        if (_qualityThreshold != null) 'qualityThreshold': _qualityThreshold,
        'enableMLFeatures': _enableMLFeatures,
        if (_maxTagsPerImage != null) 'maxTagsPerImage': _maxTagsPerImage,
        if (_analysisMode?.isNotEmpty == true) 'analysisMode': _analysisMode,
        if (_customSettings?.isNotEmpty == true) 'customSettings': _customSettings,
        if (_updatedBy?.isNotEmpty == true) 'updatedBy': _updatedBy,
        if (_version != null) 'version': _version,
    };
    final result = widget.item != null
        ? MLConfiguration.fromJson({...widget.item!.toJson(), ...data})
        : MLConfiguration.fromJson(data);
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
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Enable Auto Tagging'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _enableAutoTagging,
                  onChanged: (v) { ss(() {}); setState(() => _enableAutoTagging = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quality Threshold', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _qualityThreshold = double.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              StatefulBuilder(
                builder: (ctx2, ss) => SwitchListTile(
                  title: Text('Enable M L Features'),
                  secondary: const Icon(Icons.toggle_on),
                  value: _enableMLFeatures,
                  onChanged: (v) { ss(() {}); setState(() => _enableMLFeatures = v); },
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Max Tags Per Image', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _maxTagsPerImage = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Analysis Mode', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _analysisMode = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Custom Settings', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _customSettings = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Updated By', prefixIcon: const Icon(Icons.text_fields), border: const OutlineInputBorder()),
                onSaved: (v) => _updatedBy = v?.isEmpty == true ? null : v,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Version', prefixIcon: Icon(Icons.numbers), border: OutlineInputBorder()),
                onSaved: (v) => _version = int.tryParse(v ?? ''),
              ),
              const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(widget.item != null ? Icons.save : Icons.add),
              label: Text(widget.item != null ? 'Save Changes' : 'Create M L Configuration'),
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