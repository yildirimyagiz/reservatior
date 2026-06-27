import 'package:flutter/material.dart' hide Notification, Route;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:easy_localization/easy_localization.dart';

class AiPropertyDescriptionFormWidget extends ConsumerStatefulWidget {
  final AiPropertyDescription? item;
  final Function(AiPropertyDescription) onSubmit;
  const AiPropertyDescriptionFormWidget({
    super.key,
    this.item,
    required this.onSubmit,
  });
  @override
  ConsumerState<AiPropertyDescriptionFormWidget> createState() =>
      _AiPropertyDescriptionFormWidgetState();
}

class _AiPropertyDescriptionFormWidgetState
    extends ConsumerState<AiPropertyDescriptionFormWidget> {
  String? _propertyId;
  String? _generatedDescription;
  String? _originalDescription;
  String? _tone;
  String? _targetAudience;
  double? _qualityScore;
  DateTime? _generatedAt;
  bool? _isApproved;
  String? _approvedBy;
  DateTime? _approvedAt;
  @override
  void initState() {
    super.initState();
    _propertyId = widget.item?.propertyId;
    _generatedDescription = widget.item?.generatedDescription;
    _originalDescription = widget.item?.originalDescription;
    _tone = widget.item?.tone;
    _targetAudience = widget.item?.targetAudience;
    _qualityScore = widget.item?.qualityScore;
    _generatedAt = widget.item?.generatedAt;
    _isApproved = widget.item?.isApproved;
    _approvedBy = widget.item?.approvedBy;
    _approvedAt = widget.item?.approvedAt;
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
              widget.item == null ? "${'mobile.auto.new'.tr()} ${'mobile.modules.aipropertydescription'.tr()}" : "${'mobile.auto.edit'.tr()} ${'mobile.modules.aipropertydescription'.tr()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: _propertyId?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.propertyid'.tr()),
              onChanged: (v) => _propertyId = v,
            ),
            TextFormField(
              initialValue: _generatedDescription?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.generateddescription'.tr(),
              ),
              onChanged: (v) => _generatedDescription = v,
            ),
            TextFormField(
              initialValue: _originalDescription?.toString(),
              decoration: InputDecoration(
                labelText: 'mobile.auto.originaldescription'.tr(),
              ),
              onChanged: (v) => _originalDescription = v,
            ),
            TextFormField(
              initialValue: _tone?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.tone'.tr()),
              onChanged: (v) => _tone = v,
            ),
            TextFormField(
              initialValue: _targetAudience?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.targetaudience'.tr()),
              onChanged: (v) => _targetAudience = v,
            ),
            TextFormField(
              initialValue: _qualityScore?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.qualityscore'.tr()),
              keyboardType: TextInputType.number,
              onChanged: (v) => _qualityScore = double.tryParse(v ?? ""),
            ),
            ListTile(
              title: Text("${'mobile.admin.field_generated_at'.tr()}: ${_generatedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _generatedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _generatedAt = d);
              },
            ),
            SwitchListTile(
              title: Text('mobile.auto.isapproved'.tr()),
              value: _isApproved ?? false,
              onChanged: (v) => setState(() => _isApproved = v),
            ),
            TextFormField(
              initialValue: _approvedBy?.toString(),
              decoration: InputDecoration(labelText: 'mobile.auto.approvedby'.tr()),
              onChanged: (v) => _approvedBy = v,
            ),
            ListTile(
              title: Text("${'mobile.admin.field_approved_at'.tr()}: ${_approvedAt ?? 'mobile.admin.select'.tr()}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: _approvedAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => _approvedAt = d);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final data = <String, dynamic>{
                  if (_propertyId != null) 'propertyId': _propertyId,
                  if (_generatedDescription != null)
                    'generatedDescription': _generatedDescription,
                  if (_originalDescription != null)
                    'originalDescription': _originalDescription,
                  if (_tone != null) 'tone': _tone,
                  if (_targetAudience != null)
                    'targetAudience': _targetAudience,
                  if (_qualityScore != null) 'qualityScore': _qualityScore,
                  if (_generatedAt != null)
                    'generatedAt': _generatedAt!.toIso8601String(),
                  'isApproved': _isApproved,
                  if (_approvedBy != null) 'approvedBy': _approvedBy,
                  if (_approvedAt != null)
                    'approvedAt': _approvedAt!.toIso8601String(),
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
                  widget.onSubmit(AiPropertyDescription.fromJson(json));
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
