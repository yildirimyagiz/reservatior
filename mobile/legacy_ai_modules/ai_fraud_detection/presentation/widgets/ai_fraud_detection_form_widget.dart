import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiFraudDetectionFormWidget extends ConsumerStatefulWidget {
  final AiFraudDetection? item;
  final Function(AiFraudDetection) onSubmit;
  const AiFraudDetectionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiFraudDetectionFormWidget> createState() =>
      _AiFraudDetectionFormWidgetState();
}

class _AiFraudDetectionFormWidgetState
    extends ConsumerState<AiFraudDetectionFormWidget> {
  String? _entityType;
  String? _entityId;
  double? _riskScore;
  String? _riskCategory;
  DateTime? _detectedAt;
  DateTime? _reviewedAt;
  String? _reviewedBy;
  String? _resolution;
  @override
  void initState() {
    super.initState();
    _entityType = widget.item?.entityType;
    _entityId = widget.item?.entityId;
    _riskScore = widget.item?.riskScore;
    _riskCategory = widget.item?.riskCategory;
    _detectedAt = widget.item?.detectedAt;
    _reviewedAt = widget.item?.reviewedAt;
    _reviewedBy = widget.item?.reviewedBy;
    _resolution = widget.item?.resolution;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aifrauddetection'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aifrauddetection'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _entityType?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entitytype'.tr()),
              onChanged: (v) => _entityType = v,
            ),
            TextFormField(
              initialValue: _entityId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.entityid'.tr()),
              onChanged: (v) => _entityId = v,
            ),
            TextFormField(
              initialValue: _riskScore?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.riskscore'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _riskScore = double.tryParse(v ?? ""),
            ),
            TextFormField(
              initialValue: _riskCategory?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.riskcategory'.tr()),
              onChanged: (v) => _riskCategory = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_detected_at'.tr()}: ${_detectedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _detectedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _detectedAt = d);
              },
            ),
            ListTile(
              title: Text("${'mobile.admin.field_reviewed_at'.tr()}: ${_reviewedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _reviewedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _reviewedAt = d);
              },
            ),
            TextFormField(
              initialValue: _reviewedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.reviewedby'.tr()),
              onChanged: (v) => _reviewedBy = v,
            ),
            TextFormField(
              initialValue: _resolution?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.resolution'.tr()),
              onChanged: (v) => _resolution = v,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_entityType != null) 'entityType': _entityType,
                  if (_entityId != null) 'entityId': _entityId,
                  if (_riskScore != null) 'riskScore': _riskScore,
                  if (_riskCategory != null) 'riskCategory': _riskCategory,
                  if (_detectedAt != null)
                    'detectedAt': _detectedAt!.toIso8601String(),
                  if (_reviewedAt != null)
                    'reviewedAt': _reviewedAt!.toIso8601String(),
                  if (_reviewedBy != null) 'reviewedBy': _reviewedBy,
                  if (_resolution != null) 'resolution': _resolution,
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
                  widget.onSubmit(AiFraudDetection.fromJson(json));
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
