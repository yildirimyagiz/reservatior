import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiImageAnalysisFormWidget extends ConsumerStatefulWidget {
  final AiImageAnalysis? item;
  final Function(AiImageAnalysis) onSubmit;
  const AiImageAnalysisFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiImageAnalysisFormWidget> createState() =>
      _AiImageAnalysisFormWidgetState();
}

class _AiImageAnalysisFormWidgetState
    extends ConsumerState<AiImageAnalysisFormWidget> {
  String? _propertyId;
  String? _photoId;
  String? _analysisType;
  double? _qualityScore;
  double? _lightingQuality;
  DateTime? _analyzedAt;
  double? _confidence;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _photoId = widget.item?.photoId;
    _analysisType = widget.item?.analysisType;
    _qualityScore = widget.item?.qualityScore;
    _lightingQuality = widget.item?.lightingQuality;
    _analyzedAt = widget.item?.analyzedAt;
    _confidence = widget.item?.confidence;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aiimageanalysis'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aiimageanalysis'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _photoId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.photoid'.tr()),
              onChanged: (v) => _photoId = v,
            ),
            TextFormField(
              initialValue: _analysisType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.analysistype'.tr()),
              onChanged: (v) => _analysisType = v,
            ),
            TextFormField(
              initialValue: _qualityScore?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.qualityscore'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _qualityScore = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _lightingQuality?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.lightingquality'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _lightingQuality = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_analyzed_at'.tr()}: ${_analyzedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _analyzedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _analyzedAt = d);
              },
            ),
            TextFormField(
              initialValue: _confidence?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.confidence'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _confidence = double.tryParse(v ?? ""),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_photoId != null) 'photoId': _photoId,
                  if (_analysisType != null) 'analysisType': _analysisType,
                  if (_qualityScore != null) 'qualityScore': _qualityScore,
                  if (_lightingQuality != null)
                    'lightingQuality': _lightingQuality,
                  if (_analyzedAt != null)
                    'analyzedAt': _analyzedAt!.toIso8601String(),
                  if (_confidence != null) 'confidence': _confidence,
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
                  widget.onSubmit(AiImageAnalysis.fromJson(json));
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
