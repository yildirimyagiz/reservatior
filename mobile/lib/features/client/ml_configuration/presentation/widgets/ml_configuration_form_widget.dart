import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class MlConfigurationFormWidget extends ConsumerStatefulWidget {
  final MlConfiguration? item;
  final Function(MlConfiguration) onSubmit;
  const MlConfigurationFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<MlConfigurationFormWidget> createState() =>
      _MlConfigurationFormWidgetState();
}

class _MlConfigurationFormWidgetState
    extends ConsumerState<MlConfigurationFormWidget> {
  bool? _enableAutoTagging;
  double? _qualityThreshold;
  bool? _enableMLFeatures;
  int? _maxTagsPerImage;
  String? _analysisMode;
  String? _updatedBy;
  int? _version;
  @override
  void initState() {
    super.initState();
    _enableAutoTagging = widget.item?.enableAutoTagging;
    _qualityThreshold = widget.item?.qualityThreshold;
    _enableMLFeatures = widget.item?.enableMLFeatures;
    _maxTagsPerImage = widget.item?.maxTagsPerImage;
    _analysisMode = widget.item?.analysisMode;
    _updatedBy = widget.item?.updatedBy;
    _version = widget.item?.version;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.mlconfiguration'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.mlconfiguration'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('mobile.auto.enableautotagging'.tr()),
              value: _enableAutoTagging ?? false,
              onChanged: (v) => setState(() => _enableAutoTagging = v),
            ),
            TextFormField(
              initialValue: _qualityThreshold?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.qualitythreshold'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _qualityThreshold = double.tryParse(v ?? ""),
            ),
            SwitchListTile(
              title: Text('mobile.auto.enablemlfeatures'.tr()),
              value: _enableMLFeatures ?? false,
              onChanged: (v) => setState(() => _enableMLFeatures = v),
            ),
            TextFormField(
              initialValue: _maxTagsPerImage?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.maxtagsperimage'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _maxTagsPerImage = int.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _analysisMode?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.analysismode'.tr()),
              onChanged: (v) => _analysisMode = v,
            ),
            TextFormField(
              initialValue: _updatedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.updatedby'.tr()),
              onChanged: (v) => _updatedBy = v,
            ),
            TextFormField(
              initialValue: _version?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.version'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _version = int.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  'enableAutoTagging': _enableAutoTagging,
                  if (_qualityThreshold != null)
                    'qualityThreshold': _qualityThreshold,
                  'enableMLFeatures': _enableMLFeatures,
                  if (_maxTagsPerImage != null)
                    'maxTagsPerImage': _maxTagsPerImage,
                  if (_analysisMode != null) 'analysisMode': _analysisMode,
                  if (_updatedBy != null) 'updatedBy': _updatedBy,
                  if (_version != null) 'version': _version,
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
                  widget.onSubmit(MlConfiguration.fromJson(json));
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
